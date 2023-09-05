//
//  UserProfileEntity+CoreDataProperties.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 9/5/23.
//
//

import Foundation
import CoreData


extension UserProfileEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProfileEntity> {
        return NSFetchRequest<UserProfileEntity>(entityName: "UserProfileEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var first_name: String?
    @NSManaged public var last_name: String?
    @NSManaged public var mobile: String?
    @NSManaged public var is_verified: String?
    @NSManaged public var referral_code: String?

}

extension UserProfileEntity : Identifiable {

}
