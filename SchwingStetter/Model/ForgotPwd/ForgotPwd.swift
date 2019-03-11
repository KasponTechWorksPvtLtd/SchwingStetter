//
//  ForgotPwd.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 29/11/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation

//MARK:- Forgot Password Success Object

struct SSForgotPwd: Codable {
    let status: Int?
    let responseMessage, data: String?
    let responseCode: Int?
    let methodName: String?
    let additionalData: Int?
    
    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case responseMessage = "ResponseMessage"
        case data = "Data"
        case responseCode = "ResponseCode"
        case methodName
        case additionalData = "AdditionalData"
    }
}

//MARK:- Forgot Password Error Object
struct SSForgotPwd_Err: Codable {
    let status: Int?
    let responseMessage: String?
    let data: [Datum_Err]?
    let responseCode: Int?
    let methodName: String?
    let additionalData: Int?
    
    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case responseMessage = "ResponseMessage"
        case data = "Data"
        case responseCode = "ResponseCode"
        case methodName
        case additionalData = "AdditionalData"
    }
}

struct Datum_Err: Codable {
    let empty: String?
}

