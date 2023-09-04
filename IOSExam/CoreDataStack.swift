//
//  CoreDataStack.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 9/4/23.
//

import Foundation
import CoreData

class CoreDataStack {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RewardsApp")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func fetchRewards() -> [RewardsEntity] {
        let fetchRequest: NSFetchRequest<RewardsEntity> = RewardsEntity.fetchRequest()
        do {
            let rewards = try managedObjectContext.fetch(fetchRequest)
            
//            var uniqueRewardIDs = Set<Int>()
//            let uniqueRewards = rewards.filter { reward in
//                let rewardID = reward.id
//                if uniqueRewardIDs.contains(Int(rewardID)) {
//                    return false
//                } else {
//                    uniqueRewardIDs.insert(Int(rewardID))
//                    return true
//                }
//            }
            
            return filterRequest(rewards) as! [RewardsEntity]
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
        return []
    }
    
    func filterRequest(_ rewards: [Any]) -> [Any] {
        var uniqueRewardIDs = Set<Int>()
        let uniqueRewards = rewards.filter { reward in
            let rewardID = (reward as AnyObject).id
            if uniqueRewardIDs.contains(Int(rewardID!)) {
                return false
            } else {
                uniqueRewardIDs.insert(Int(rewardID!))
                return true
            }
        }
        return Array(uniqueRewards) as! [Any]
    }
}
