//
//  ApiProtocol.swift
//  LeafCompanion
//
//  Created by Matthew Mohrman on 5/11/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiManagerProtocol {
    func apiRequest(endpoint: Endpoint, parameters: Parameters?, headers: HTTPHeaders?) -> ApiRequestProtocol
}

extension ApiManagerProtocol {
    func apiRequest(endpoint: Endpoint) -> ApiRequestProtocol {
        return apiRequest(endpoint: endpoint, parameters: nil, headers: nil)
    }
    
    func apiRequest(endpoint: Endpoint, parameters: Parameters?) -> ApiRequestProtocol {
        return apiRequest(endpoint: endpoint, parameters: parameters, headers: nil)
    }
}

protocol ApiRequestProtocol {
    func apiResponseString(completionHandler: @escaping (DataResponse<String>) -> Void) -> Self
    func apiResponseJSON(completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self
}

extension SessionManager: ApiManagerProtocol {
    func apiRequest(endpoint: Endpoint, parameters: Parameters?, headers: HTTPHeaders?) -> ApiRequestProtocol {
        var headers = headers ?? HTTPHeaders()
        headers["API-Key"] = "f950a00e-73a5-11e7-8cf7-a6006ad3dba0"
        headers["Content-Type"] = "application/json; charset=utf-8"
        
        return request(endpoint.url, method: endpoint.method, parameters: parameters, encoding: endpoint.encoding, headers: headers)
    }
}

extension DataRequest: ApiRequestProtocol {
    func apiResponseString(completionHandler: @escaping (DataResponse<String>) -> Void) -> Self {
        return responseString(completionHandler: completionHandler)
    }
    
    func apiResponseJSON(completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
        return responseJSON(completionHandler: completionHandler)
    }
}
