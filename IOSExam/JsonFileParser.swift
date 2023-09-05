//
//  JsonFileParser.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 9/4/23.
//

import Foundation
import CoreData



class JsonFileParser {
    
    struct Reward: Decodable {
        let id: Int
        let name: String
        let desc: String
        let image: String
    }
    
    // Reference to your Core Data stack
    let coreDataStack: CoreDataStack
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func parseJsonFile() {
        guard let url = Bundle.main.url(forResource: "Reward", withExtension: "json") else {
            fatalError("Failed to locate Rewards.JSON in the bundle.")
        }
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let rewards = try decoder.decode([Reward].self, from: jsonData)
            insertRewardsIntoCoreData(rewards)
        } catch {
            print("Error decoding JSON data: \(error.localizedDescription)")
        }
    }

    private func insertRewardsIntoCoreData(_ rewards: [Reward]) {
        let context = coreDataStack.persistentContainer.viewContext
        let isEmpty = coreDataStack.isEntityEmpty(forEntityName: "RewardsEntity", managedObjectContext: context)
        
        guard isEmpty == true else { return }

        for reward in rewards {
            let rewardID = Int64(reward.id)
            let fetchRequest: NSFetchRequest<RewardsEntity> = RewardsEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %ld", rewardID)
            
            do {
                if let existingReward = try context.fetch(fetchRequest).first {
                    // update
                    existingReward.name = reward.name
                    existingReward.desc = reward.desc
                    existingReward.image = reward.image
                    coreDataStack.saveContext()
                } else {
                    // create
                    let rewardsEntity = RewardsEntity(context: context)
                    rewardsEntity.id = rewardID
                    rewardsEntity.name = reward.name
                    rewardsEntity.desc = reward.desc
                    rewardsEntity.image = reward.image
                    coreDataStack.saveContext()
                }
            } catch {
                print("Error fetching or saving context: \(error)")
            }
        }
    }

    func getRewards() -> [RewardsEntity] {
        return coreDataStack.fetchRewards()
    }
}
