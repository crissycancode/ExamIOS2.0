//
//  CoreDataStack+Login.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 9/5/23.
//

import Foundation
import CoreData

extension CoreDataStack {
    func loadLogin() {
        let context = persistentContainer.viewContext
        let isEmpty = isEntityEmpty(forEntityName: "LoginEntity", managedObjectContext: context)

        guard isEmpty == true else { return }

        let parser = JsonFileParser()
        if let login: [Login] = parser.parseJsonFile("Login") {
            insertLoginsIntoCoreData(login)
        } else {
            print("Parsing failed.")
        }
    }

    func fetchLoginEntitiesFromCoreData(login: String, password: String) -> Bool {
        let fetchRequest: NSFetchRequest<LoginEntity> = LoginEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mobile == %@ AND mpin == %@", NSString(string: login), password)
        do {
            let login = try managedObjectContext.fetch(fetchRequest)
            return login.first?.mobile != nil && login.first?.mpin != nil
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
        return false
    }
    
    private func insertLoginsIntoCoreData(_ logins: [Login]) {
        let context = persistentContainer.viewContext
        for login in logins {
            let mobile = login.mobile
            let fetchRequest: NSFetchRequest<LoginEntity> = LoginEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "mobile == %@", mobile)
            
            do {
                if let existingLogin = try context.fetch(fetchRequest).first {
                    // update
                    existingLogin.mobile = login.mobile
                    existingLogin.mpin = login.mpin
                    saveContext()
                } else {
                    // create
                    let loginEntity = LoginEntity(context: context)
                    loginEntity.mobile = login.mobile
                    loginEntity.mpin = login.mpin
                    saveContext()
                }
            } catch {
                print("Error fetching or saving context: \(error)")
            }
        }
    }
}
