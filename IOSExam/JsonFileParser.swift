//
//  JsonFileParser.swift
//  IOSExam
//
//  Created by Criselda Aguilar on 9/4/23.
//

import Foundation

struct Reward: Decodable {
    let id: Int
    let name: String
    let desc: String
    let image: String
}

struct UserProfile: Decodable {
    let id: String
    let first_name: String
    let last_name: String
    let mobile: String
    let is_verified: String
    let referral_code: String
}

class JsonFileParser {

    /// Parse JSON
    /// - Parameter filename: json file
    /// - Returns: json data
    func parseJsonFile<T: Decodable>(_ filename: String) -> [T]? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to locate \(filename).json in the bundle.")
        }
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedArray = try decoder.decode([T].self, from: jsonData)
            return decodedArray
        } catch {
            print("Error decoding JSON data: \(error.localizedDescription)")
            return nil
        }
    }
}
