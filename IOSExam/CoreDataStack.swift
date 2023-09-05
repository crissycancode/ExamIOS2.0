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

    /// Check if the Entity is empty
    /// - Parameters:
    ///   - entityName: coredata entity
    ///   - managedObjectContext: --
    /// - Returns: boolean value
    func isEntityEmpty(forEntityName entityName: String, managedObjectContext: NSManagedObjectContext) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let count = try managedObjectContext.count(for: fetchRequest)
            return count == 0
        } catch {
            print("Error counting objects for entity: \(error)")
            return false
        }
    }

}
