//
//  CNCApprove.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 14/11/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation

//MARK:- CNC Segment List
struct CNCSegment: Codable {
    let type: String?
    let message: [Message]?
    let code: Int?
}

struct Message: Codable {
    
    let rawPartno: String?
    let id: Int?
    let createdAt: String?
    let userid: Int?
    let partNo, noOfPlateSegment, drumModel: String?
    let alternateUniqueValue: Int?
    
    enum CodingKeys: String, CodingKey {
        case rawPartno = "raw_partno"
        case id
        case createdAt = "created_at"
        case userid
        case partNo = "part_no"
        case noOfPlateSegment = "no_of_plate_segment"
        case drumModel = "drum_model"
        case alternateUniqueValue = "alternate_unique_value"
    }
    
    /*let fdrmid, fabid: Int?
    let sessionid: String?
    let userid, rawMaterialPartNo, rawMaterialQty, rmq: Int?
    let drumModel, noOfSegments: Int?
    let scrapWeight, scrapPercentage, machineRunningMeterStart, machineRunningMeterEnd: String?
    let createAt: String?
    let updateAt: String? //JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case fdrmid, fabid, sessionid, userid
        case rawMaterialPartNo = "raw_material_part_no"
        case rawMaterialQty = "raw_material_qty"
        case rmq
        case drumModel = "drum_model"
        case noOfSegments = "no_of_segments"
        case scrapWeight = "scrap_weight"
        case scrapPercentage = "scrap_percentage"
        case machineRunningMeterStart = "machine_running_meter_start"
        case machineRunningMeterEnd = "machine_running_meter_end"
        case createAt = "create_at"
        case updateAt = "update_at"
    }*/
}

//MARK:- Segment details
struct CNCSegmentDetails: Codable {
    let type: String?
    let message: Message_Details?
    let code: Int?
}

struct Message_Details: Codable {
    let mixerdata: [Mixerdatum]?
    let totalSegmentWeight: String?
    let rmWeight: Double?
    let scrapPercentage: String?
    
    enum CodingKeys: String, CodingKey {
        case mixerdata
        case totalSegmentWeight = "total_Segment_weight"
        case rmWeight = "rm_weight"
        case scrapPercentage = "scrap_percentage"
    }
}

struct Mixerdatum: Codable {
    let weight, wtPerSegment, coneCategory, partNo: String?
    let noOfPlateSegment, drumModel: String?
    
    enum CodingKeys: String, CodingKey {
        case weight
        case wtPerSegment = "wt_per_segment"
        case coneCategory = "cone_category"
        case partNo = "part_no"
        case noOfPlateSegment = "no_of_plate_segment"
        case drumModel = "drum_model"
    }
}


//MARK:- CNC Segment Submit
struct CNCSegmentSubmit: Codable {
    let type: String?
    let message: String?
    let code: Int?
}

//MARK:- CNC Part Number
struct CNCPartNum: Codable {
    let type: String?
    let message: [Message_PartNo]?
    let code: Int?
}

struct Message_PartNo: Codable {
    let id: Int?
    let rawPartno, description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case rawPartno = "raw_partno"
        case description
    }
}

// MARK: Encode/decode helpers

/*class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}*/

