//
//  MaterialIssue.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 22/11/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation

//MARK:- Material Types Object
struct MIA_MaterialTypes: Codable {
    let type: String?
    let message: [Message_MaterialType]?
    let code: Int?
}

struct Message_MaterialType: Codable {
    let id, name: String?
}

//MARK:- Drum Part Number Object
struct MIA_Drum_ParNum: Codable {
    let type: String?
    let message: [Message_DrumPrtNum]?
    let code: Int?
}

struct Message_DrumPrtNum: Codable {
    let id: Int?
    let drumpartNo, drumModel: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case drumpartNo = "drumpart_no"
        case drumModel = "drum_model"
    }
}

//MARK:- Drum Working Order Number Object

struct MIA_Drum_WONum: Codable {
    let type: String?
    let message: [Message_DrumWONum]?
    let code: Int?
}

struct Message_DrumWONum: Codable {
    let id, partNo: Int?
    let drumModelNo: String?
    let workorderNo, quantity: Int?
    let createdAt, updatedAt, drumModel: String?
    let drumid: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case partNo = "part_no"
        case drumModelNo = "drum_model_no"
        case workorderNo = "workorder_no"
        case quantity
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case drumModel = "drum_model"
        case drumid
    }
}


//MARK:- Mixer Part Number Object
struct MIA_Mixer_PartNum: Codable {
    let type: String?
    let message: [Message_MixerPrtNum]?
    let code: Int?
}

struct Message_MixerPrtNum: Codable {
    let id: Int?
    let partNo, mixerModel: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case partNo = "part_no"
        case mixerModel = "mixer_model"
    }
}

//MARK:- Mixer Working Order Number

struct MIA_Mixer_WONum: Codable {
    let type: String?
    let message: [Message_MixerWONum]?
    let code: Int?
}

struct Message_MixerWONum: Codable {
    let id, workorderNo: Int?
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


//MARK:- Mounting Working Order Number

struct MIA_Mount_WONum: Codable {
    let type: String?
    let message: [Message_MountWONum]?
    let code: Int?
}

struct Message_MountWONum: Codable {
    let id: Int?
    let customername: String?
    let workorderNo: Int?
    let partNo, quantity, description, createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, customername
        case workorderNo = "workorder_no"
        case partNo = "part_no"
        case quantity, description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

//MARK:- Material List BAsed on Workorder Number

struct MIA_Material_List: Codable {
    let type: String?
    let message: [Message_MtrList]?
    let code: Int?
   
    mutating func reset()  {
        do{
            self = try MIA_Material_List(from: "" as! Decoder)
        }catch(let err){
            print("MIA_Material_List Err:- \(err)")
        }
        
    }
}

struct Message_MtrList: Codable {
    
    let datas: Materialdatum?
    let storeStatus, shiftEngineerStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case datas
        case storeStatus = "store_status"
        case shiftEngineerStatus = "shift_engineer_status"
    }
    
    /*let id: Int?
    let date, materialIssuefor, model: String?
    let totalQty, issuedQty, remainingQty, shiftEngineerStatus: Int?
    let status: Int?
    let partNo: String?
    let workorderNo: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, date
        case materialIssuefor = "material_issuefor"
        case model
        case totalQty = "total_qty"
        case issuedQty = "issued_qty"
        case remainingQty = "remaining_qty"
        case shiftEngineerStatus = "shift_engineer_status"
        case status
        case partNo = "part_no"
        case workorderNo = "workorder_no"
    }*/
    
   /* let workorderNo: String?
    let id: Int?
    let materialIssuefor, model: String?
    let wONo, totalQty, issuedQty, remainingQty: Int?
    let status, shiftEngineerStatus: Int?
    let date, bomElements, revisedBy, createdAt: String?
    let updatedAt: String?
    let drumpartNo, drumModel: String?
    
    enum CodingKeys: String, CodingKey {
        case workorderNo = "workorder_no"
        case id
        case materialIssuefor = "material_issuefor"
        case model
        case wONo = "w_o_no"
        case totalQty = "total_qty"
        case issuedQty = "issued_qty"
        case remainingQty = "remaining_qty"
        case status
        case shiftEngineerStatus = "shift_engineer_status"
        case date
        case bomElements = "bom_elements"
        case revisedBy = "revised_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case drumpartNo = "drumpart_no"
        case drumModel = "drum_model"
    }*/
    
}

struct Materialdatum: Codable {
    let id: Int?
    let date, materialIssuefor, model: String?
    let totalQty, issuedQty, remainingQty, shiftEngineerStatus: Int?
    let status: Int?
    let drumpartNo, drumModel: String?
    let workorderNo: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, date
        case materialIssuefor = "material_issuefor"
        case model
        case totalQty = "total_qty"
        case issuedQty = "issued_qty"
        case remainingQty = "remaining_qty"
        case shiftEngineerStatus = "shift_engineer_status"
        case status
        case drumpartNo = "drumpart_no"
        case drumModel = "drum_model"
        case workorderNo = "workorder_no"
    }
}


//MARK:- Material Acknowledgement Status

struct MIA_Material_Acknowledge: Codable {
    let type, message: String?
    let code: Int?
}
