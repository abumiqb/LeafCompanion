//
//  Brand.swift
//  LeafCompanion
//
//  Created by Matthew Mohrman on 5/11/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation

enum Brand: String, Codable {
    case nissan = "N"
    
    func name() -> String {
        switch self {
        case .nissan:
            return "Nissan"
        }
    }
}
