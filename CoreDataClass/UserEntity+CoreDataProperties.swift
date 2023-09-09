//
//  UserEntity+CoreDataProperties.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 9/7/23.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var first_name: String?
    @NSManaged public var last_name: String?
    @NSManaged public var mobile: String?
    @NSManaged public var is_verified: Bool
    @NSManaged public var referral_code: String?

}

extension UserEntity : Identifiable {

}
