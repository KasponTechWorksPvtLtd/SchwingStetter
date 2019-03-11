//
//  SS_DrumClear_ViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 16/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_DrumClear_ViewController: UIViewController {

    

    @IBOutlet weak var view_bg: UIView!
    @IBOutlet weak var view_bg_submit: UIView!
    @IBOutlet weak var txt_part: UITextField!
    @IBOutlet weak var txt_dsnum: UITextField!
    @IBOutlet weak var txt_modelNme: UITextField!
    @IBOutlet weak var txt_action: UITextField!
    @IBOutlet weak var constra_view_height: NSLayoutConstraint!
     @IBOutlet weak var constr_headerView_hei: NSLayoutConstraint!
    
    let drum_controller = SS_DrumCleara_Controller()
    var drumClrList: DrumCLRList!
    var drumClrSrlNum: DrumCLRSrlNum!
    var ary_drumPartNum = [String]()
    var ary_drumSrlNum = [String]()
    var drumSerialNum = -1
    let dropDownView = SS_Dropdown_ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        drum_controller.delegate_drumClrList = self
        drum_controller.delegate_drumSrlNum = self
        drum_controller.delegate_drumSubByRej = self
        
        SS_Utility.showIndicator(vc: self)
        drum_controller.getDrumClrList()
        constra_view_height.constant = txt_part.frame.size.height + 25
        view_bg_submit.isHidden = true
        
        constr_headerView_hei.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
        
    }

    
    //MARK:- ButtonACtion
   /* @IBAction func showDropDown(sender: UIButton){
        
        print("sender:- \(sender.convert(sender.frame, to: self.view))")
        let cus_frm = sender.convert(sender.frame, to: self.view)
        
        let ddVC = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.DROPDOWNVC.rawValue) as! SS_Dropdown_ViewController
        ddVC.delegate = self
        ddVC.view.frame = CGRect(x: cus_frm.origin.x - 200, y: cus_frm.origin.y, width: cus_frm.size.width, height: 100)
        ddVC.view.backgroundColor = UIColor.green
        ddVC.ary_data = ["801601",  "801602", "801603"]
        
        self.view.addSubview(ddVC.view)
    }*/
    
    @IBAction func homeBtnClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitClicked(sender: UIButton){
  
        if (!(txt_action.text?.isEmpty)!) {
            let status_ = txt_action.text == SS_Utility.DrumClearance.Assembly.rawValue ? SS_Utility.DrumClearance.Assembly.hashValue : SS_Utility.DrumClearance.Spare.hashValue
            print("status_:- \(status_)")
            drum_controller.submitByRejectDrumClearance(dicVal: [Keys_val.id_.rawValue: drumSerialNum, Keys_val.empID.rawValue: SingleTone.share.login.data![0].userid!, Keys_val.status_.rawValue: status_]) //1

        }else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Action field should not be empty", alertType: 0){_ in
            }
        }
    }
    
    @IBAction func cancelClicked(sender: UIButton){
        /*drum_controller.submitByRejectDrumClearance(dicVal: [Keys_val.id_.rawValue: drumSerialNum, Keys_val.empID.rawValue: SingleTone.share.login.data![0].userid!, Keys_val.status_.rawValue: 0])*/
        self.navigationController?.popViewController(animated: true)
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

extension SS_DrumClear_ViewController: DropdownDelegate{
    func selectedIndexWithItem(index: Int, item: String, tagVal: Int) {
        
        switch tagVal {
        case 5:
            txt_part.text = item
            guard (drumClrList.message![index].id != nil) else {
                return
            }
            
            drumSerialNum = SS_Utility.checkForDicNullValues(item_val: drumClrList.message![index].id!) as! Int //drumSerialNo
            SS_Utility.showIndicator(vc: self)
            
            drum_controller.getDrumSerialNumber(id_: drumClrList.message![index].id!) // 25 id drumID
        case 6:
            txt_dsnum.text = item
            txt_modelNme.text = txt_part.text?.components(separatedBy: ["_"]).last! //"6C2RH"
            view_bg_submit.isHidden = false
            constra_view_height.constant = txt_part.frame.size.height * 7 + 25
        case 8:
            txt_action.text = item
        default:
            break

        }
        dropDownView.removeDropdownFromSuperView(vc: self)
    }
}

extension SS_DrumClear_ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()

        switch textField {
        case txt_part:
                dropDownView.addDropdownView(selectedView: txt_part, ary_data: ary_drumPartNum, customView: view_bg, mainView: self.view, vc: self)
        
        case txt_dsnum:
                dropDownView.addDropdownView(selectedView: txt_dsnum, ary_data: ary_drumSrlNum, customView: view_bg, mainView: self.view, vc: self)
            
        case txt_action:
                dropDownView.addDropdownView(selectedView: txt_action, ary_data: ["Spare", "Assembly"], customView: view_bg, mainView: self.view, vc: self)
        default:
            break
        }
    }
}

extension SS_DrumClear_ViewController: DrumClrListDelegate{
    
    func successResponse(dic_response: DrumCLRList) {

        SS_Utility.stopIndicator(vc: self)
        drumClrList = dic_response
        for item_ in drumClrList.message! {
            ary_drumPartNum.append("\(SS_Utility.checkForDicNullValues(item_val: item_.drumpartNo! + "_" + item_.drumModel!))")
        }
    }
  
    func errorResponse_list(error_: String) {
        SS_Utility.stopIndicator(vc: self)
//        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
//        }
    }
}

extension SS_DrumClear_ViewController: DrumClrSrlNumDelegate {
    func successResponse(dic_response: DrumCLRSrlNum) {
        SS_Utility.stopIndicator(vc: self)
        drumClrSrlNum = dic_response
      
        guard drumClrSrlNum.message != nil  else{
            return
        }
        ary_drumSrlNum.removeAll()
        for item_ in drumClrSrlNum.message! {
            ary_drumSrlNum.append("\(SS_Utility.checkForDicNullValues(item_val: item_.drumSerialNo as Any))")
        }
        constra_view_height.constant = txt_part.frame.size.height * 3 + 25
    }
    
    func errorResponse_srlNum(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
  
}

extension SS_DrumClear_ViewController: DrumClrSubByRejDelegate {
    func successResponse(dic_response: DrumCLRSubByRej) {
        SS_Utility.showAlert(str_title: "Alert", str_msg: "\(SS_Utility.checkForDicNullValues(item_val: dic_response.message as Any))", alertType: 0, completion: {//type
            if($0 == true){
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    func errorResponse_subByRej(error_: String) {
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0, completion: {
            if($0 == true){
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
}
