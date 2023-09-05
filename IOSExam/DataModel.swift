//
//  DataModel.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 8/29/23.
//

import Foundation

struct RewardsDataModel: Hashable {
    let id: Int
    let name: String
    let description: String
    let image: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(image)
    }
    
    static func == (lhs: RewardsDataModel, rhs: RewardsDataModel) -> Bool {
        return  lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.image == rhs.image
    }
}
