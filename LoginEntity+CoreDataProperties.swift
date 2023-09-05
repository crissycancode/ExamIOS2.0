//
//  LoginEntity+CoreDataProperties.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 9/5/23.
//
//

import Foundation
import CoreData


extension LoginEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginEntity> {
        return NSFetchRequest<LoginEntity>(entityName: "LoginEntity")
    }

    @NSManaged public var mobile: String?
    @NSManaged public var mpin: String?

}

extension LoginEntity : Identifiable {

}
