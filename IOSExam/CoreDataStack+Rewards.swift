//
//  CoreDataStack+Rewards.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 9/5/23.
//

import Foundation
import CoreData

extension CoreDataStack {
    // MARK: Rewards
    func fetchRewards() -> [RewardsEntity] {
        let context = persistentContainer.viewContext
        let isEmpty = isEntityEmpty(forEntityName: "RewardsEntity", managedObjectContext: context)
        
        guard isEmpty == true else { return fetchRewardsEntitiesFromCoreData() }
        
        let parser = JsonFileParser()
        if let parsedRewards: [Reward] = parser.parseJsonFile("Reward") {
            insertRewardsIntoCoreData(parsedRewards)
        } else {
            print("Parsing failed.")
        }
        return fetchRewardsEntitiesFromCoreData()
    }
    
    private func fetchRewardsEntitiesFromCoreData() -> [RewardsEntity] {
        let fetchRequest: NSFetchRequest<RewardsEntity> = RewardsEntity.fetchRequest()
        do {
            let rewards = try managedObjectContext.fetch(fetchRequest)
            return rewards
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
        return []
    }
    
    private func insertRewardsIntoCoreData(_ rewards: [Reward]) {
        let context = persistentContainer.viewContext

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
                    saveContext()
                } else {
                    // create
                    let rewardsEntity = RewardsEntity(context: context)
                    rewardsEntity.id = rewardID
                    rewardsEntity.name = reward.name
                    rewardsEntity.desc = reward.desc
                    rewardsEntity.image = reward.image
                    saveContext()
                }
            } catch {
                print("Error fetching or saving context: \(error)")
            }
        }
    }
}
