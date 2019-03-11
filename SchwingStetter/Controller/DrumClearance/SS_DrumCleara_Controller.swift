//
//  SS_DrumCleara_Controller.swift
//  SchwingStetter
//
//  Created by TestMac on 17/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation
import UIKit

protocol DrumClrListDelegate: AnyObject {
    func successResponse(dic_response: DrumCLRList)
    func errorResponse_list(error_: String)
}

protocol DrumClrSrlNumDelegate: AnyObject {
    func successResponse(dic_response: DrumCLRSrlNum)
    func errorResponse_srlNum(error_: String)
}

protocol DrumClrSubByRejDelegate: AnyObject {
    func successResponse(dic_response: DrumCLRSubByRej)
    func errorResponse_subByRej(error_: String)
}


class SS_DrumCleara_Controller {
    
    weak var delegate_drumClrList: DrumClrListDelegate?
    weak var delegate_drumSrlNum: DrumClrSrlNumDelegate?
    weak var delegate_drumSubByRej: DrumClrSubByRejDelegate?
    
    
    
    func getDrumClrList() {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.drumClr_list.rawValue, str_postParam: ["":""]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let drumListObj = try decoder_.decode(DrumCLRList.self, from: jsonData)
                    self.delegate_drumClrList?.successResponse(dic_response: drumListObj)
                }catch let err_ {
                    self.delegate_drumClrList?.errorResponse_list(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_drumClrList?.errorResponse_list(error_: "Try again later")
            }
        }
    }
    
    
    func getDrumSerialNumber(id_: Int) {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.drumClr_srnNum.rawValue, str_postParam: [Keys_val.id_.rawValue: id_]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let drumSrlNumObj = try decoder_.decode(DrumCLRSrlNum.self, from: jsonData)
                    self.delegate_drumSrlNum?.successResponse(dic_response: drumSrlNumObj)

                }catch let err_ {
                    self.delegate_drumSrlNum?.errorResponse_srlNum(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_drumSrlNum?.errorResponse_srlNum(error_: "Try again later")
            }
        }
    }
    
    func submitByRejectDrumClearance(dicVal: [String: Any]) {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.drumClr_submis_rej.rawValue, str_postParam: dicVal){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let drumSubByRejObj = try decoder_.decode(DrumCLRSubByRej.self, from: jsonData)
                    self.delegate_drumSubByRej?.successResponse(dic_response: drumSubByRejObj)
                }catch let err_ {
                    self.delegate_drumSubByRej?.errorResponse_subByRej(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_drumSubByRej?.errorResponse_subByRej(error_: "Try again later")
            }
        }
    }
    
}

