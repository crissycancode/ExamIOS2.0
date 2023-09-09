//
//  RegisterEntity+CoreDataProperties.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 9/7/23.
//
//

import Foundation
import CoreData


extension RegisterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RegisterEntity> {
        return NSFetchRequest<RegisterEntity>(entityName: "RegisterEntity")
    }

    @NSManaged public var first_name: String?
    @NSManaged public var last_name: String?
    @NSManaged public var mobile: String?
    @NSManaged public var mpin: String?

}

extension RegisterEntity : Identifiable {

}
