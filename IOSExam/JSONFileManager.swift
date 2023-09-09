//
//  JSONFileManager.swift
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

struct User: Decodable, Encodable {
    let id: String
    let first_name: String
    let last_name: String
    let mobile: String
    let is_verified: Bool
    let referral_code: String
}

struct Login: Decodable, Encodable {
    let mobile: String
    let mpin: String
}

struct Register: Decodable, Encodable {
    let first_name: String
    let last_name: String
    let mobile: String
    let mpin: String
}

struct NewUser: Codable{
    let first_name: String
    let last_name: String
    let mobile: String
    let mpin: String
    
    let id: UUID
    let is_verified: Bool
    let referral_code: String
}

class JSONFileManager {
    
    /// Parse JSON
    /// - Parameter filename: json file
    /// - Returns: json data
    func parse<T: Decodable>(_ filename: String) -> [T]? {
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
    
    func decode<T: Decodable>(_ data: Data?) -> [T]? {
        if let jsonData = data,
           let decodedData = try? JSONDecoder().decode([T].self, from: jsonData) {
            return decodedData
        } else {
            print("Error decoding data.")
            return nil
        }
    }
    
    func appendToJSONFile<T: Codable>(_ newData: T, file fileName: String) -> (updated: Bool, data: Data?) {
        guard var dataArray: [T] = parse(fileName) else { return (false, nil) }
        dataArray.append(newData)
        let encodedData = encode(dataArray, fileName: fileName)
        return (encodedData.isUpdated, encodedData.jsonEncodedData)
    }

    private func encode<T: Encodable>(_ jsonData: [T], fileName: String) -> (isUpdated: Bool, jsonEncodedData: Data?){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encodedData = try? encoder.encode(jsonData) {
            let updatedFile = update(fileName, jsonData: encodedData)
            return (updatedFile.isUpdated, updatedFile.jsonUpdatedData)
        } else {
            print("Error encoding data to JSON format.")
            return (false, nil)
        }
    }

    private func update(_ filePath: String, jsonData: Data) -> (isUpdated: Bool, jsonUpdatedData: Data?){
        do {
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let jsonFilePath = documentsDirectory.appendingPathComponent(filePath)
                try jsonData.write(to: jsonFilePath, options: .atomic)
                return (true, jsonData) // updated successfully, return the updated jsonData
            } else {
                print("Error obtaining documents directory.")
                return (false, nil)
            }
        } catch {
            print("Error writing JSON data: \(error.localizedDescription)")
            return (false, nil)
        }
    }
    
    private func testPrintUpdataData(_ updatedJsonData: Data){
        if let updatedJsonString = String(data: updatedJsonData, encoding: .utf8) {
            print("Updated JSON Data:")
            print(updatedJsonString)
        }
    }
}



