//
//  CoreDataStack+Usere.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 9/6/23.
//

import Foundation
import CoreData

extension CoreDataStack {
    func loadUserProfiles() {
        let context = persistentContainer.viewContext
        let isEmpty = isEntityEmpty(forEntityName: "UserEntity", managedObjectContext: context)
        guard isEmpty == true else {return}
        let parser = JsonFileParser()
        if let users: [User] = parser.parseJsonFile("User") {
            print(users)
            insertUsersIntoCoreData(users)
        } else {
            print("Parsing failed.")
        }
    }
    
    private func insertUsersIntoCoreData(_ users: [User]) {
        let context = persistentContainer.viewContext
        for user in users {
            let mobile = user.mobile
            let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "mobile == %@", mobile)
            
            do {
                if let existingUser = try context.fetch(fetchRequest).first {
                    // update
                    existingUser.mobile = user.mobile
                    existingUser.id = user.id
                    existingUser.first_name = user.first_name
                    existingUser.last_name = user.last_name
                    existingUser.referral_code = user.referral_code
                    existingUser.is_verified = user.is_verified
                    saveContext()
                    
                } else {
                    // create
                    let userEntity = UserEntity(context: context)
                    userEntity.mobile = user.mobile
                    userEntity.id = user.id
                    userEntity.first_name = user.first_name
                    userEntity.last_name = user.last_name
                    userEntity.referral_code = user.referral_code
                    userEntity.is_verified = user.is_verified
                    saveContext()
                }
            } catch {
                print("Error fetching or saving context: \(error)")
            }
        }
    }

    func fetchUserEntitiesFromCoreData(_ mobile: String) -> [User] {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mobile == %@", NSString(string: mobile))
        do {
            let userEntity = try managedObjectContext.fetch(fetchRequest)
            let user = userEntity.map{ User(id: $0.id ?? "",
                                            first_name: $0.first_name ?? "",
                                            last_name: $0.last_name ?? "",
                                            mobile: $0.mobile ?? "",
                                            is_verified: $0.is_verified,
                                            referral_code: $0.referral_code ?? "")
            }
            return user
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
        return []
    }
}

