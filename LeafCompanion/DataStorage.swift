//
//  DataStorage.swift
//  LeafCompanion
//
//  Created by Matthew Mohrman on 5/16/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation

public class DataStorage {
    static func store<T: Encodable>(_ object: T, as fileName: String) {
        let url = cachesUrl().appendingPathComponent(fileName, isDirectory: false)
        
        do {
            let data = try JSONEncoder().encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static func retrieve<T: Decodable>(_ fileName: String, as type: T.Type) -> T? {
        let url = cachesUrl().appendingPathComponent(fileName, isDirectory: false)
        
        guard FileManager.default.fileExists(atPath: url.path), let data = FileManager.default.contents(atPath: url.path) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static fileprivate func cachesUrl() -> URL {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            fatalError("Could not create URL for specified directory!")
        }
        
        return url
    }
}
