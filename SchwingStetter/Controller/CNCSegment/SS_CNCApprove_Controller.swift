//
//  SS_CNCApprove_Controller.swift
//  SchwingStetter
//
//  Created by TestMac on 19/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

protocol CNCPartNoDelegate: AnyObject {
    func successResponse(dic_response: CNCPartNum)
    func errorResponse_cncPrtNo(error_: String)
}

protocol CNCApproveDelegate: AnyObject {
    func successResponse(dic_response: CNCSegment)
    func errorResponse_cncList(error_: String)
}

protocol CNCApproveDetailsDelegate: AnyObject {
    func successResponse(dic_response: CNCSegmentDetails)
    func errorResponse_cncDetails(error_: String)
}

protocol CNCSegmentSubmitDelegate: AnyObject {
    func successResponse(dic_response: CNCSegmentSubmit)
    func errorResponse_cncSubmit(error_: String)
}




class SS_CNCApprove_Controller: UIViewController {

    weak var delegate_CNC: CNCApproveDelegate?
    weak var delegate_CNCSelectedList: CNCApproveDetailsDelegate?
    weak var delegate_CNCSegSubmit: CNCSegmentSubmitDelegate?
    weak var delegate_CNCPartNo: CNCPartNoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- To Get Part Number
    func getCNCPartNumber() {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.cncSegmentList.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.cnc_partNo.rawValue]) {
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let cncPrtNoModel = try decoder_.decode(CNCPartNum.self, from: jsonData)
                    self.delegate_CNCPartNo?.successResponse(dic_response: cncPrtNoModel)
                }catch let err_ {
                    self.delegate_CNCPartNo?.errorResponse_cncPrtNo(error_: err_.localizedDescription)
                }
                
            }else {
                self.delegate_CNCPartNo?.errorResponse_cncPrtNo(error_: "Try again later")
            }
        }
    }
    
    func getCNCApprovalList(partNo_Id_: String) {
         methNam = methoName1.cnc_
        
        print(MethodNames.cncSegmentList.rawValue)
        print(Keys_val.switchcase.rawValue, Keys_val.get.rawValue)
        print(Keys_val.id_.rawValue, partNo_Id_)
        
        postWebService(str_methodName: MethodNames.cncSegmentList.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.get.rawValue, Keys_val.id_.rawValue: partNo_Id_]) {
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let cncApprovModel = try decoder_.decode(CNCSegment.self, from: jsonData)
                    self.delegate_CNC?.successResponse(dic_response: cncApprovModel)
                }catch let err_ {
                    self.delegate_CNC?.errorResponse_cncList(error_: err_.localizedDescription)
                }
                
            }else {
                self.delegate_CNC?.errorResponse_cncList(error_: "Try again later")
            }
        }
    }

    func getSelectedCNCApproveDetails(rwPartNum: String) {
        methNam = methoName1.cnc_
        
        print(MethodNames.cncSegmentList.rawValue)
        print(Keys_val.switchcase.rawValue,Keys_val.getdrumdetails.rawValue)
         print(Keys_val.partno.rawValue, rwPartNum)
        
        postWebService(str_methodName: MethodNames.cncSegmentList.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.getdrumdetails.rawValue, Keys_val.alternativePartNumber.rawValue: rwPartNum]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let cncDetails = try decoder_.decode(CNCSegmentDetails.self, from: jsonData)
                    self.delegate_CNCSelectedList?.successResponse(dic_response: cncDetails)
                }catch let err_{
                    self.delegate_CNCSelectedList?.errorResponse_cncDetails(error_: err_.localizedDescription)
                }
                
            }else{
                self.delegate_CNCSelectedList?.errorResponse_cncDetails(error_: "Try again later")
            }
        }
    }
    
    func approveSelectedCNCSegment(numOfPrts: Int, alternateUniqueId: Int, status: Int) {
        methNam = methoName1.cnc_
        
        print(MethodNames.cncSegmentSubmit.rawValue)
        print(Keys_val.noOfPlates.rawValue, numOfPrts)
        print(Keys_val.status_.rawValue, status)
        print(Keys_val.alternativePartNumber.rawValue, alternateUniqueId)
       
        
        
        postWebService(str_methodName: MethodNames.cncSegmentSubmit.rawValue, str_postParam: [Keys_val.noOfPlates.rawValue: numOfPrts, Keys_val.status_.rawValue: status, Keys_val.alternativePartNumber.rawValue: alternateUniqueId]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let cncResObj = try decoder_.decode(CNCSegmentSubmit.self, from: jsonData)
                    self.delegate_CNCSegSubmit?.successResponse(dic_response: cncResObj)
                }catch let err_{
                    self.delegate_CNCSegSubmit?.errorResponse_cncSubmit(error_: err_.localizedDescription)
                }
                
            }else{
                self.delegate_CNCSegSubmit?.errorResponse_cncSubmit(error_: "Try again later")
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class SS_CNCApproveCell: UITableViewCell{
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_empID: UILabel!
    @IBOutlet weak var lbl_rmPartNum: UILabel!
}

class SS_EditCNCApproveCell: UITableViewCell{
    @IBOutlet weak var lbl_drumModel: UILabel!
    @IBOutlet weak var lbl_segmentQty: UILabel!
    @IBOutlet weak var lbl_coneCateg: UILabel!
    @IBOutlet weak var lbl_segWt: UILabel!
    
    
    @IBOutlet weak var lbl_segWeight: UILabel!
    @IBOutlet weak var lbl_rmWeight: UILabel!
    @IBOutlet weak var lbl_scrap: UILabel!
    
    @IBOutlet weak var btn_accept: UIButton!
    @IBOutlet weak var btn_reject: UIButton!
    
}
