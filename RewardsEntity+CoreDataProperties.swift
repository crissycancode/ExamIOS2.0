//
//  RewardsEntity+CoreDataProperties.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 8/31/23.
//
//

import Foundation
import CoreData


extension RewardsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RewardsEntity> {
        return NSFetchRequest<RewardsEntity>(entityName: "RewardsEntity")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var name: String?

}

extension RewardsEntity : Identifiable {

}
