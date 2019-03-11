//
//  SnagDelayRework.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 14/11/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation

struct OperationCode: Codable {
    let type: String?
    let message: [Message_Operation]?
    let code: Int?
}

struct Message_Operation: Codable {
    let id: Int?
    let operationCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case operationCode = "operation_code"
    }
}


struct SnagDelayRework: Codable {
    let type: String?
    let message: [Message_SnagDelayRework]?
    let code: Int?
}

struct Message_SnagDelayRework: Codable {
    let id, empNo: Int?
    let code, description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case empNo = "emp_no"
        case code, description
    }
}

struct SnagAcceptByReject: Codable {
    let type, message: String?
    let code: Int?
}



struct GetCodeForProcessType {
    
    static func processType_value(str_val: String) -> Int {
        
        switch str_val {
        case "Fabrication":
            return 1
        case "Assembly":
            return 2
        default:
            return 0
        }
    }
    
    static func workStation_value(ary_val: OperationCode, forValue: String) -> String{
        
        let ary_filtered = ary_val.message?.filter{ $0.operationCode == forValue}
        return ary_filtered?.count != 0 ? "\(ary_filtered![0].id!)" : "ALL"
    }
    
    static func type_value(str_val: String) -> Int {
        
        switch str_val {
        case "Delay":
            return 1
        case "Rework":
            return 2
        case "Snag":
            return 3
        default:
            return 0
        }
    }
    
}
