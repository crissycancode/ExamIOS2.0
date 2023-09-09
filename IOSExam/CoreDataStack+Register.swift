//
//  CoreDataStack+Register.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 9/7/23.
//

import Foundation
import CoreData

extension CoreDataStack {
    
    func loadRegisteredUsers() {
        let context = persistentContainer.viewContext
        let isEmpty = isEntityEmpty(forEntityName: "RegisterEntity", managedObjectContext: context)
        
        guard isEmpty == true else { return }
        
        let parser = JSONFileManager()
        if let registeredUsers: [Register] = parser.parse("Registration") {
            insertRegisterIntoCoreData(registeredUsers)
        } else {
            print("Parsing failed.")
        }
    }
    
    func insertRegisterIntoCoreData(_ register: [Register]) { // if RegisterEntity is empty
        let context = persistentContainer.viewContext
        for user in register {
            let fetchRequest: NSFetchRequest<RegisterEntity> = RegisterEntity.fetchRequest()
            do {
                if let existingRegister = try context.fetch(fetchRequest).first {
                    // update
                    existingRegister.first_name = user.first_name
                    existingRegister.last_name = user.last_name
                    existingRegister.mobile = user.mobile
                    existingRegister.mpin = user.mpin
                    saveContext()
                } else {
                    // create
                    let newRegister = RegisterEntity(context: context)
                    newRegister.first_name = user.first_name
                    newRegister.last_name = user.last_name
                    newRegister.mobile = user.mobile
                    newRegister.mpin = user.mpin
                    saveContext()
                }
            } catch {
                print("Error fetching or saving context: \(error)")
            }
        }
    }
    
    func doesMobileNumberExistInCoreData(_ mobile: String) -> Bool {
        let fetchRequest: NSFetchRequest<RegisterEntity> = RegisterEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mobile == %@", NSString(string: mobile))
        do {
            
            let register = try managedObjectContext.fetch(fetchRequest)
            return register.first?.mobile != nil
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
        return false
    }
    
    func insertUserInputToCoreDataAndJson(_ data: NewUser) {  // Data from user input
        let fileManager = JSONFileManager()
        let user = User(id: (data.id).uuidString,
                        first_name: data.first_name,
                        last_name: data.last_name,
                        mobile: data.mobile,
                        is_verified: data.is_verified,
                        referral_code: data.referral_code)
        
        let login = Login(mobile: data.mobile,
                          mpin: data.mpin)
        
        let register = Register(first_name: data.first_name,
                                last_name: data.last_name,
                                mobile: data.mobile,
                                mpin: data.mpin)
        
        let updatedUser = fileManager.appendToJSONFile(user, file: "User")
        let updatedLogin = fileManager.appendToJSONFile(login, file: "Login")
        let updatedRegister = fileManager.appendToJSONFile(register, file: "Registration")
        
        let decodedRegister: [Register] = fileManager.decode(updatedRegister.data) ?? []
        insertRegisterIntoCoreData(decodedRegister)
        
        let decodedLogin: [Login] = fileManager.decode(updatedLogin.data) ?? []
        insertLoginsIntoCoreData(decodedLogin)
        
        let decodedUser: [User] = fileManager.decode(updatedUser.data) ?? []
        insertUsersIntoCoreData(decodedUser)
    }
}
