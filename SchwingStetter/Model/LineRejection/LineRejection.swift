//
//  LineRejection.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 26/12/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation

//MARK:- Line Rejection Items
struct LR_ListItems: Codable {
    let type: String?
    var message: [Message_LR_ListItems]?
    let code: Int?
    
    init() {
        type = ""
        code = 0
        message = [Message_LR_ListItems]()
    }
}

struct Message_LR_ListItems: Codable {
    let id: Int?
    let drumpartNo, workStation, lineRejectionID: String?
    let materialIssueFor, workorderNo: Int?
    let requestedBy: String?
    let sapStatus, qcReworkDetails: Int?
    let qcComments: String?
    let storeStatus, qcStatus: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case drumpartNo = "drumpart_no"
        case workStation = "work_station"
        case lineRejectionID = "line_rejection_id"
        case materialIssueFor = "material_issue_for"
        case workorderNo = "workorder_no"
        case requestedBy = "requested_by"
        case sapStatus = "sap_status"
        case qcReworkDetails = "qc_rework_details"
        case qcComments = "qc_comments"
        case storeStatus = "store_status"
        case qcStatus = "qc_status"
    }
    
    init() {
        id = 0; materialIssueFor = 0; workorderNo = 0; sapStatus = 0; storeStatus = 0; qcStatus = 0
        requestedBy = ""; qcReworkDetails = 0; qcComments = ""; drumpartNo = ""; workStation = ""; lineRejectionID = ""
    }
}

//MARK:-  Line Rejection Work Station

struct LR_WorkStation: Codable {
    let type: String?
    let message: [Message_LR_WrkSta]?
    let code: Int?
}

struct Message_LR_WrkSta: Codable {
    let id: Int?
    let listOfOperation, operationCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case listOfOperation = "list_of_operation"
        case operationCode = "operation_code"
    }
}


//MARK:- Line Rejection Work Order Number

struct LR_WorkOrdNum: Codable {
    let type: String?
    let message: [Message_LR_WONum]?
    let code: Int?
}

struct Message_LR_WONum: Codable {
    /*let id: Int?
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
    }*/
    
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

//MARK:- Line Rejection Part Number Description

struct LR_PartDescript: Codable {
    let type: String?
    let message: [Message_Descrip]?
    let code: Int?
}

struct Message_Descrip: Codable {
    let description: String?
}


//Mark:- Line Rejection Add Items Response

struct LR_AddItemsResult: Codable {
    let type, message: String?
    let code: Int?
}


//MARK:- Added Line Items List
struct LR_AddItemsList: Codable {
    let type: String?
    let message: [Message_AddedLineItemList]?
    let code: Int?
}

struct Message_AddedLineItemList: Codable {
    let id, workorderNo, partNo: Int?
    let description, comments: String?
    let quantity, lineRejectionID: Int?
    let updatedAt, createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case workorderNo = "workorder_no"
        case partNo = "part_no"
        case description, comments, quantity
        case lineRejectionID = "line_rejection_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}


//MARK:- Update Edited Item
struct LR_UpdateEditedItem: Codable {
    let type, message: String?
    let code: Int?
}

//MARK:- Update Line Rejection
struct LR_UpdateLineReject: Codable {
    let type, message: String?
    let code: Int?
}

//MARK:- Deletion of LR List
struct KPT_DeleteList: Codable {
    let type, message: String?
    let code: Int?
}

//MARK:- Deletion of LR Added Items
struct KPT_DeleteAddedItem: Codable {
    let type, message: String?
    let code: Int?
}
