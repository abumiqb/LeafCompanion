//
//  ConnectAPI.swift
//  LeafCompanion
//
//  Created by Matthew Mohrman on 5/11/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation
import Alamofire

class ConnectApi {
    private let sessionManager: ApiManagerProtocol
    
    init(sessionManager: ApiManagerProtocol = SessionManager.default) {
        self.sessionManager = sessionManager
        if let sessionManager = self.sessionManager as? SessionManager, sessionManager.adapter == nil {
            //sessionManager.adapter = AuthorizationAdapter()
        }
    }
    
    func authenticate(username: String, password: String, completionHandler: @escaping (ApiResult<[Vehicle]>) -> Void) {
        let parameters = [
            "authenticate": [
                "userid": username,
                "brand-s": "N",
                "language-s": "en_US",
                "password": password,
                "country": "US"
            ]
        ]
        
        _ = sessionManager.apiRequest(endpoint: .authenticate, parameters: parameters).apiResponseJSON { response in
            switch response.result {
            case .success(let responseValue):
                do {
                    
                    
                    if let responseDictionary = responseValue as? [String:Any], let vehiclesDictionary = responseDictionary["vehicles"], let data = try? JSONSerialization.data(withJSONObject: vehiclesDictionary) {
                        let vehicles = try JSONDecoder().decode([Vehicle].self, from: data)
                        completionHandler(ApiResult{ return vehicles })
                    }
                } catch let error {
                    completionHandler(ApiResult{ throw error })
                }
            case .failure(let error):
                completionHandler(ApiResult{ throw error })
            }
        }
    }
}
