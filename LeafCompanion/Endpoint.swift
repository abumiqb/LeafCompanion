//
//  Endpoint.swift
//  LeafCompanion
//
//  Created by Matthew Mohrman on 5/11/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint {
    case authenticate
    
    // MARK: - Public Properties
    var method: HTTPMethod {
        switch self {
        case .authenticate:
            return .post
        }
    }
    
    var url: URL {
        let baseUrl = URL(string: "https://icm.infinitiusa.com/NissanLeafProd/rest")!
        
        switch self {
        case .authenticate:
            return baseUrl.appendingPathComponent("/auth/authenticationForAAS")
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .authenticate:
            return JSONEncoding.default
        }
    }
}
