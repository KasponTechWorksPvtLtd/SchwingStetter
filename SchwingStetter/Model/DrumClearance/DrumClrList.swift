//
//  DrumClrList.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 21/11/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation

//MARK:- DrumList
struct DrumCLRList: Codable {
    let type: String?
    let message: [Message_DrumClr]?
    let code: Int?
}

struct Message_DrumClr: Codable {
    let id, drumID: Int?
    let drumModel, drumpartNo: String?
    let workorderNumber: Int?
    let drumSerialNo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case drumID = "drum_id"
        case drumModel = "drum_model"
        case drumpartNo = "drumpart_no"
        case workorderNumber = "workorder_number"
        case drumSerialNo = "drum_serial_no"
    }
}

//MARK:- DrumSerialNumber

struct DrumCLRSrlNum: Codable {
    let type: String?
    let message: [Message_SrlNum]?
    let code: Int?
}

struct Message_SrlNum: Codable {
    let drumSerialNo: String?
    
    enum CodingKeys: String, CodingKey {
        case drumSerialNo = "drum_serial_no"
    }
}


//MARK:- DrumClearanceSubmitByReject

struct DrumCLRSubByRej: Codable {
    let message, type: String?
    let  code: Int?
}

