//
//  ProductionPlan.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 09/11/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation

struct ProductionView: Codable {
    let  id, workorderNo: Int?
    let mixerModelno, partNo, planSchedule: String?
    let priority, createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case workorderNo = "workorder_no"
        case mixerModelno = "mixer_modelno"
        case partNo = "part_no"
        case planSchedule = "plan_schedule"
        case priority
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct EditProductionView: Codable {
    let type, message: String?
    let code: Int?
}

struct SSProdPlanPartNum: Codable {
    let type: String?
    let message: [Message_PartNum]?
    let code: Int?
}

struct Message_PartNum: Codable {
    let id: Int?
    let partNo, mixerModel: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case partNo = "part_no"
        case mixerModel = "mixer_model"
    }
}
