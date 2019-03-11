//
//  SS_SnagDelayRework_Controller.swift
//  SchwingStetter
//
//  Created by TestMac on 22/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

protocol SnagOperationCodeDelegate: AnyObject {
    func successResponse(dic_response: OperationCode)
    func errorResponse_operCode(error_: String)
}

protocol SnagDelayReworkDelegate: AnyObject {
    func successResponse(dic_response: SnagDelayRework)
    func errorResponse_sdr(error_: String)
}

protocol SnagAcceptByRejectDelegate: AnyObject {
    func successResponse(dic_response: SnagAcceptByReject)
    func errorResponse_submit(error_: String)
}

class SS_SnagDelayRework_Controller: NSObject {

    weak var delegate_operationCode: SnagOperationCodeDelegate?
    weak var delegate_snagDelayRework: SnagDelayReworkDelegate?
    weak var delegate_snagAcceptByReject: SnagAcceptByRejectDelegate?
    
    
    func getOperationCodeList(tag_: Int) {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.snag_operationcode.rawValue, str_postParam: [Keys_val.basedon.rawValue: tag_]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let operationCodeObj = try decoder_.decode(OperationCode.self, from: jsonData)
                    self.delegate_operationCode?.successResponse(dic_response: operationCodeObj)
                }catch let err_ {
                    self.delegate_operationCode?.errorResponse_operCode(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_operationCode?.errorResponse_operCode(error_: "Try again later")
            }
        }
    }
    
    func getSnagDelayRework(dicVal: [String: Any]) {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.snag_delaysnagrework.rawValue, str_postParam: dicVal){
            if !$0.isEmpty{
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let snagObj = try decoder_.decode(SnagDelayRework.self, from: jsonData)
                    
                    self.delegate_snagDelayRework?.successResponse(dic_response: snagObj)
                }catch let err_ {
                    self.delegate_snagDelayRework?.errorResponse_sdr(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_snagDelayRework?.errorResponse_sdr(error_: "Try again later")
            }
        }
    }
    
    func snagAcceptyBySubmit(dicVal: [String: Any]) {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.snag_delayrework.rawValue, str_postParam: dicVal){//snag_delayrework
            if !$0.isEmpty{
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let snagObj = try decoder_.decode(SnagAcceptByReject.self, from: jsonData)
                   
                    self.delegate_snagAcceptByReject?.successResponse(dic_response: snagObj)
                }catch let err_ {
                    self.delegate_snagAcceptByReject?.errorResponse_submit(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_snagAcceptByReject?.errorResponse_submit(error_: "Try again later")
            }
        }
    }
    
    func validateForEmptyFields(processType: UITextField, ws: UITextField, type: UITextField) -> Bool {
        if !(processType.text?.isEmpty)!, !(ws.text?.isEmpty)!, !(type.text?.isEmpty)! {
            return true
        }else{
            return false
        }
    }
}

class SS_DelaySnag_TableCell: UITableViewCell {
    
    @IBOutlet weak var lbl_empId: UILabel!
    @IBOutlet weak var lbl_cone: UILabel!
    @IBOutlet weak var lbl_descr: UILabel!
    @IBOutlet weak var btn_approve: UIButton!
    @IBOutlet weak var btn_reject: UIButton!
    
    
}



