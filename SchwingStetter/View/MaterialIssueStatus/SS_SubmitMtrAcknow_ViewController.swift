//
//  SS_SubmitMtrAcknow_ViewController.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 28/11/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_SubmitMtrAcknow_ViewController: UIViewController {

    
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_woNum: UILabel!
    @IBOutlet weak var lbl_totalQty: UILabel!
    @IBOutlet weak var lbl_issuedQty: UILabel!
    @IBOutlet weak var txt_storeStus: UITextField!
    @IBOutlet weak var txt_shiftEngStus: UITextField!
    @IBOutlet weak var view_bg: UIView!
     @IBOutlet weak var constr_headerView_hei: NSLayoutConstraint!
    
    var mia_mtr: Materialdatum! //Message_MtrList!
    var mateIssTyp_controller = SS_MaterialIssue_Controller()
    let dropDownView = SS_Dropdown_ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        constr_headerView_hei.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
        
        mateIssTyp_controller.delegate_mrtAckn = self
        loadMtrList()
    }
    
    func loadMtrList()  {
        lbl_date.text = mia_mtr.date
        lbl_woNum.text = "\(mia_mtr.workorderNo!)"
        lbl_totalQty.text = "\(mia_mtr.totalQty!)"
        lbl_issuedQty.text = "\(mia_mtr.issuedQty!)"
        txt_shiftEngStus.text = SS_Utility.MrtAckn_StoreStus(tagVal: mia_mtr.status!)//status shiftEngineerStatus
    }
    
    /*func getMrtSatusId(str_mtrStatus: String) -> Int {
        switch str_mtrStatus {
        case SS_Utility.Enum_MaterialStatusName.Material_Issued.rawValue:
            return 1
        default:
            <#code#>
        }
    }*/
    
    //MARK:-  Button ACtion
    
    @IBAction func submitMrtAcknow(sender: UIButton){
        if !(txt_shiftEngStus.text?.isEmpty)! {
            SS_Utility.showIndicator(vc: self)
            mateIssTyp_controller.submitMaterialAcknStatus(mrtStatusID: SS_Utility.Enum_MaterialStatusName.returnMtrStatusTag(mrtStusNme: txt_shiftEngStus.text!), mrtWONumId: mia_mtr.id!)
        }else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Store Status should not be empty.", alertType: 0){_ in
                
            }
        }
        
    }
    
    @IBAction func cancelMrtAcknow(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtnClicked(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
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

extension SS_SubmitMtrAcknow_ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        
        switch textField {
        case txt_shiftEngStus:
            dropDownView.addDropdownView(selectedView: txt_shiftEngStus, ary_data: ["Material Issued", "Partialy issued", "Material damaged"], customView: view_bg, mainView: self.view, vc: self)
            
        default:
            break
        }
    }
}

extension SS_SubmitMtrAcknow_ViewController: DropdownDelegate{
    func selectedIndexWithItem(index: Int, item: String, tagVal: Int) {
        
        switch tagVal {
        case 1:
            txt_shiftEngStus.text = item
        default:
            break
        }
        dropDownView.removeDropdownFromSuperView(vc: self)
    }
}

extension SS_SubmitMtrAcknow_ViewController: MIA_MaterialAcknDelegate{
    func successResponse(dic_response: MIA_Material_Acknowledge) {
        SS_Utility.stopIndicator(vc: self)
        //let str_msg = dic_response.message == "1" ? "Updated successfully" : "Not Updated"
        SS_Utility.showAlert(str_title: "Alert", str_msg: dic_response.message!, alertType: 0){ _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func errorResponse_mrtAckn(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
    
    
}

