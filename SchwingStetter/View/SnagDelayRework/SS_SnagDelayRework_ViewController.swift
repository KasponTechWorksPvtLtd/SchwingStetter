//
//  SS_SnagDelayRework_ViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 22/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_SnagDelayRework_ViewController: UIViewController {

    
    @IBOutlet weak var table_sdr: UITableView!
    @IBOutlet weak var txt_procTye: UITextField!
    @IBOutlet weak var txt_type: UITextField!
    @IBOutlet weak var txt_wrkStation: UITextField!
    @IBOutlet weak var view_bg: UIView!
     @IBOutlet weak var constr_headerView_hei: NSLayoutConstraint!
    @IBOutlet weak var lbl_nodata: UILabel!
    
    var ary_delay_dicRes: SnagDelayRework! //= [[String: Any]]()
    var dic_operationCode: OperationCode!
    let controller_snagdelay = SS_SnagDelayRework_Controller()
    let dropDownView = SS_Dropdown_ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        /*ary_delay_dicRes.append([Keys_val.share.empID : "415", Keys_val.share.cone: "F-SNG9", Keys_val.share.description: "Shell lines join welding not done"])
        ary_delay_dicRes.append([Keys_val.share.empID : "267", Keys_val.share.cone: "F-SNG5", Keys_val.share.description: "Water tank assembly taper"])
        ary_delay_dicRes.append([Keys_val.share.empID : "118", Keys_val.share.cone: "FAB/D1", Keys_val.share.description: "Short issue delay"])
        ary_delay_dicRes.append([Keys_val.share.empID : "007", Keys_val.share.cone: "FAB/R1", Keys_val.share.description: "Shortage makes reassembly"])*/
        
        constr_headerView_hei.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
        
        controller_snagdelay.delegate_operationCode = self
        controller_snagdelay.delegate_snagDelayRework = self
        controller_snagdelay.delegate_snagAcceptByReject = self
    }
    
    //MARK:- SELF Methods
    func clearTableview() {
        ary_delay_dicRes = nil
        table_sdr.reloadData()
        
    }
    
    func getSnagReworkDelayList() {
        if (controller_snagdelay.validateForEmptyFields(processType: txt_procTye, ws: txt_wrkStation, type: txt_type)){
            SS_Utility.showIndicator(vc: self)
            controller_snagdelay.getSnagDelayRework(dicVal: [Keys_val.processtype.rawValue: GetCodeForProcessType.processType_value(str_val: txt_procTye.text!), Keys_val.workstation.rawValue: GetCodeForProcessType.workStation_value(ary_val: dic_operationCode, forValue: txt_wrkStation.text!), Keys_val.type.rawValue: GetCodeForProcessType.type_value(str_val: txt_type.text!)])
        }else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Kindly select all fields", alertType: 0){_ in
                
            }
        }
    }
    //MARK:- ButtonAction
    
    @IBAction func homeBtnClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getUpdatedList(sender: UIButton){
        getSnagReworkDelayList()
    }

    //MARK:- Selector Action
    @objc func acceptClicked(sender: UIButton) {
        
        SS_Utility.showIndicator(vc: self)
        let dicVal = [Keys_val.switchcase.rawValue: Keys_val.approvalorreject.rawValue, Keys_val.processtype.rawValue:GetCodeForProcessType.processType_value(str_val: txt_procTye.text!), Keys_val.type.rawValue: GetCodeForProcessType.type_value(str_val: txt_type.text!), Keys_val.id_.rawValue: ary_delay_dicRes.message![sender.tag].id!, Keys_val.status_.rawValue: 1] as [String : Any]
        //Keys_val.code.rawValue: ary_delay_dicRes.message![sender.tag].code!
        
        controller_snagdelay.snagAcceptyBySubmit(dicVal: dicVal)
        
        /*showAlert(str_title: "Message", str_msg: "Successfully Updated", alertType: 0, completion: {
            if($0 == true){
                self.navigationController?.popViewController(animated: true)
            }
        })*/
    }
    
    @objc func rejectedClicked(sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
        SS_Utility.showAlert(str_title: "Alert", str_msg: "Click OK To Reject.", alertType: 1, completion: {
            if($0 == true){
                SS_Utility.showIndicator(vc: self)
                //let dicVal = [Keys_val.switchcase.rawValue: Keys_val.approvalorreject.rawValue, Keys_val.code.rawValue: self.ary_delay_dicRes.message![sender.tag].code!, Keys_val.status_.rawValue: 1] as [String : Any]
                let dicVal = [Keys_val.switchcase.rawValue: Keys_val.approvalorreject.rawValue, Keys_val.processtype.rawValue:GetCodeForProcessType.processType_value(str_val: self.txt_procTye.text!), Keys_val.type.rawValue: GetCodeForProcessType.type_value(str_val: self.txt_type.text!), Keys_val.id_.rawValue: self.ary_delay_dicRes.message![sender.tag].id!, Keys_val.status_.rawValue: 2] as [String : Any]
                self.controller_snagdelay.snagAcceptyBySubmit(dicVal: dicVal)
            }
        })
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


extension SS_SnagDelayRework_ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ary_delay_dicRes != nil) ? ary_delay_dicRes.message!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell = table_sdr.dequeueReusableCell(withIdentifier: Cell_Identifier.cell_delaySnag.rawValue) as! SS_DelaySnag_TableCell
        let dic = ary_delay_dicRes.message![indexPath.row]
        
        cell.lbl_empId.text = "\(dic.empNo!)"  //[Keys_val.share.empID] as? String
        cell.lbl_cone.text = dic.code //[Keys_val.share.cone] as? String
        cell.lbl_descr.text = dic.description //[Keys_val.share.description] as! String)
      
        cell.btn_approve.tag = indexPath.row
        cell.btn_approve.addTarget(self, action: #selector(acceptClicked), for: .touchUpInside)
        
        cell.btn_reject.tag = indexPath.row
        cell.btn_reject.addTarget(self, action: #selector(rejectedClicked), for: .touchUpInside)
        
        return cell
    }
    
    
}


extension SS_SnagDelayRework_ViewController: DropdownDelegate{
    func selectedIndexWithItem(index: Int, item: String, tagVal: Int) {
        
        switch tagVal {
        case 5:
            txt_procTye.text = item
            txt_wrkStation.text = ""
            txt_type.text = ""
            clearTableview()
            SS_Utility.showIndicator(vc: self)
            controller_snagdelay.getOperationCodeList(tag_: GetCodeForProcessType.processType_value(str_val: item))
            
        case 6:
            txt_type.text = ""
            clearTableview()
            txt_wrkStation.text = item
            
        case 7:
            txt_type.text = item
            clearTableview()
            
           /* if (controller_snagdelay.validateForEmptyFields(processType: txt_procTye, ws: txt_wrkStation, type: txt_type)){
                SS_Utility.showIndicator(vc: self)
                 controller_snagdelay.getSnagDelayRework(dicVal: [Keys_val.processtype.rawValue: GetCodeForProcessType.processType_value(str_val: txt_procTye.text!), Keys_val.workstation.rawValue: GetCodeForProcessType.workStation_value(ary_val: dic_operationCode, forValue: txt_wrkStation.text!), Keys_val.type.rawValue: GetCodeForProcessType.type_value(str_val: item)])
            }else{
                SS_Utility.showAlert(str_title: "Alert", str_msg: "Kindly select all fields", alertType: 0){_ in
                    
                }
            }*/
           
        default:
            break
            
        }
        
        dropDownView.removeDropdownFromSuperView(vc: self)
    }
}

extension SS_SnagDelayRework_ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.resignFirstResponder()
        dropDownView.removeDropdownFromSuperView(vc: self)
        
        switch textField {
        case txt_procTye:
            dropDownView.addDropdownView(selectedView: txt_procTye, ary_data: ["Fabrication",  "Assembly"], customView: view_bg, mainView: self.view, vc: self)
            
        case txt_wrkStation:
            if (dic_operationCode != nil) {
                var ary_operationCode = [String]()
                if dic_operationCode.message!.count > 1 {
                    ary_operationCode.append("ALL")
                }
                for item_ in dic_operationCode.message! {
                    ary_operationCode.append(item_.operationCode!)
                }
                dropDownView.addDropdownView(selectedView: txt_wrkStation, ary_data: ary_operationCode, customView: view_bg, mainView: self.view, vc: self)
            }else{
                SS_Utility.showAlert(str_title: "Alert", str_msg: "No data to show", alertType: 0){_ in
                }
            }
            
        case txt_type:
            dropDownView.addDropdownView(selectedView: txt_type, ary_data: ["Snag", "Rework", "Delay"], customView: view_bg, mainView: self.view, vc: self)
            
            
        default:
            break
        }
    }
}


extension SS_SnagDelayRework_ViewController: SnagOperationCodeDelegate{
    
    func successResponse(dic_response: OperationCode) {
        SS_Utility.stopIndicator(vc: self)
        dic_operationCode = dic_response
    }
    
    func errorResponse_operCode(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
            
        }
    }
    
}

extension SS_SnagDelayRework_ViewController: SnagDelayReworkDelegate{
 
    
    func successResponse(dic_response: SnagDelayRework) {
         SS_Utility.stopIndicator(vc: self)
        ary_delay_dicRes = dic_response
        if (ary_delay_dicRes.message?.count == 0) {
            clearTableview()
            table_sdr.isHidden = true
            lbl_nodata.isHidden = false
        }else{
            table_sdr.isHidden = false
            lbl_nodata.isHidden = true
            table_sdr.reloadData()

        }
    }
    
    func errorResponse_sdr(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
            self.table_sdr.isHidden = true
            self.lbl_nodata.isHidden = false
        }
    }
}




extension SS_SnagDelayRework_ViewController: SnagAcceptByRejectDelegate{
    
    func successResponse(dic_response: SnagAcceptByReject) {
         SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: dic_response.message!, alertType: 0){_ in
            //self.navigationController?.popViewController(animated: true)
            self.getSnagReworkDelayList()
        }
    }
    
    func errorResponse_submit(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
            
        }
        
    }
    
}
