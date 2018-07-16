//
//  Vehicle.swift
//  LeafCompanion
//
//  Created by Matthew Mohrman on 5/11/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation

struct Vehicle {
    var isPluggedIn: Bool
    var isCharging: Bool
    var batteryCapacity: Int
    var batteryLevel: Int
//    var lastUpdated: Date
//
    var vin: String
    var brand: Brand
//    var modelCode: String
    var modelName: String
    var modelYear: String
//    var exteriorColor: String
    var nickname: String
    
    enum CodingKeys: String, CodingKey {
        case vin = "uvi"
        case brand = "brands"
        case modelName = "modelname"
        case modelYear = "modelyear"
        case batteryRecords
        case nickname
    }
    
    enum BatteryRecordsKeys: String, CodingKey {
        case pluginState
        case batteryStatus
    }
    
    enum BatteryStatusKeys: String, CodingKey {
        case batteryChargingStatus
        case batteryCapacity
        case batteryLevel = "batteryRemainingAmount"
    }
}

extension Vehicle: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(vin, forKey: .vin)
        try container.encode(brand, forKey: .brand)
        try container.encode(modelName, forKey: .modelName)
        try container.encode(modelYear, forKey: .modelYear)
        try container.encode(nickname, forKey: .nickname)
        
        var batteryRecordsContainer = container.nestedContainer(keyedBy: BatteryRecordsKeys.self, forKey: .batteryRecords)
        
        var convertedValue = isPluggedIn ? "CONNECTED" : "NOT_CONNECTED"
        try batteryRecordsContainer.encode(convertedValue, forKey: .pluginState)
        
        var batteryStatusContainer = batteryRecordsContainer.nestedContainer(keyedBy: BatteryStatusKeys.self, forKey: .batteryStatus)
        
        convertedValue = isCharging ? "YES" : "NO"
        try batteryStatusContainer.encode(convertedValue, forKey: .batteryChargingStatus)
        try batteryStatusContainer.encode(batteryCapacity, forKey: .batteryCapacity)
        try batteryStatusContainer.encode(batteryLevel, forKey: .batteryLevel)
    }
}

extension Vehicle: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        vin = try values.decode(String.self, forKey: .vin)
        brand = try values.decode(Brand.self, forKey: .brand)
        modelName = try values.decode(String.self, forKey: .modelName)
        modelYear = try values.decode(String.self, forKey: .modelYear)
        nickname = try values.decode(String.self, forKey: .nickname)
        
        let batteryRecords = try values.nestedContainer(keyedBy: BatteryRecordsKeys.self, forKey: .batteryRecords)
        let pluginState = try batteryRecords.decode(String.self, forKey: .pluginState)
        isPluggedIn = pluginState == "CONNECTED"
        
        let batteryStatus = try batteryRecords.nestedContainer(keyedBy: BatteryStatusKeys.self, forKey: .batteryStatus)
        let batteryChargingStatus = try batteryStatus.decode(String.self, forKey: .batteryChargingStatus)
        isCharging = batteryChargingStatus == "YES"
        
        batteryCapacity = try batteryStatus.decode(Int.self, forKey: .batteryCapacity)
        batteryLevel = try batteryStatus.decode(Int.self, forKey: .batteryLevel)
    }
}
