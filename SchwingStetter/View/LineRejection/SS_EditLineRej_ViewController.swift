//
//  SS_EditLineRej_ViewController.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 29/12/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_EditLineRej_ViewController: UIViewController {

    
    @IBOutlet weak var constr_headerView_hei: NSLayoutConstraint!
    @IBOutlet weak var txt_part: UITextField!
    @IBOutlet weak var txt_wonum: UITextField!
    @IBOutlet weak var txt_workStation: UITextField!
    @IBOutlet weak var txt_mtrIssuFor: UITextField!
    @IBOutlet weak var lbl_prtNum: UILabel!
    @IBOutlet weak var lbl_wrkStati: UILabel!
    @IBOutlet weak var view_bg: UIView!
    @IBOutlet weak var constr_view_hei: NSLayoutConstraint!

    var lineRejct_controller = SS_LineRejection_Controller()
    var controllr_addNewItem = SS_AddNewItem_Controller()
    
    var materialTypeObj: MIA_MaterialTypes!
    let dropDownView = SS_Dropdown_ViewController()
    
    var lr_drumPrtNum: MIA_Drum_ParNum!
    var lr_mixerPrtNum: MIA_Mixer_PartNum!
    var lr_wrkOrdNum: LR_WorkOrdNum!
    var lr_listItems: LR_ListItems!
    var lr_workStation: LR_WorkStation!
    var ary_prtNum = [String]()
    var ary_WONum = [String]()
    var ary_wrkStation = [String]()
    var dic_finalVal = [String: Any]()

    var lr_itemList: Message_LR_ListItems!
    var mrtTypID_ = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        constr_headerView_hei.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
        lineRejct_controller.showMaterialIssueFor()
        lineRejct_controller.delegate_lrMtrIssFor = self
        lineRejct_controller.delegate_lrDrum_partNo = self
        lineRejct_controller.delegate_lrMixer_partNo = self
        lineRejct_controller.delegate_lrWorkOrdNum = self
        lineRejct_controller.delegate_lrWrkSta = self
        controllr_addNewItem.delegate_lrUpdateLineRej = self
        //constr_view_hei.constant = lbl_prtNum.frame.size.height + 20
        loadBasicDetails()
    }

    //MARK:- Self Methods
    
    func loadBasicDetails() {
        txt_mtrIssuFor.text = SS_Utility.materialIssueNme(mrtID_:  Int(lr_itemList.materialIssueFor!))

        if (Int(lr_itemList.materialIssueFor!) != 3) {
            constr_view_hei.constant = (lbl_prtNum.frame.size.height + 20) * 4
            lbl_prtNum.text =  Int(lr_itemList.materialIssueFor!) == 1 ? "Drum Model :" : "Mixer Part No. :"
            txt_wonum.text = "\(lr_itemList.workorderNo!)"
            txt_workStation.text = "\(lr_itemList.workStation!)" + "_" + "\(lr_itemList.lineRejectionID!)"
             txt_part.text = "\(lr_itemList.drumpartNo!)"
        }else{
            constr_view_hei.constant = (lbl_prtNum.frame.size.height + 20) * 3
            lbl_prtNum.text = "Work Station :"
            lbl_wrkStati.text = "Work Order Number :"
            txt_part.text = "\(lr_itemList.workStation!)" + "_" + "\(lr_itemList.lineRejectionID!)"
            txt_workStation.text = "\(lr_itemList.workorderNo!)"
        }
        
    }
    
    func getPartNumBaseOnMrtTyp(tagVal_: Int) {
        switch tagVal_ {
        case 1:
            lineRejct_controller.getDrumPartNumber(mtrIssType_id: tagVal_)
            lbl_prtNum.text = "Drum Model"
        case 2:
            lineRejct_controller.getMixerPartNumber(mtrIssType_id: tagVal_)
            lbl_prtNum.text = "Mixer Part No."
        case 3:
            lineRejct_controller.getLineRejectionWorkStation(mtrIssType_id: tagVal_)
            lbl_prtNum.text = "Work Station"//"Mounting WO No."
        default:
            return
        }
    }
    
    //MARK:- Get WONUM or WrkStataion Based on Material Type
    func getWONumOrWrkStataBasedOnPartNum_ID(mrtTypeId_: Int) {//, prtNo_ID: Int
        switch mrtTypeId_ {
        case 1, 2:
            lineRejct_controller.getLineRejectionWorkStation(mtrIssType_id: mrtTypeId_)
        case 3:
            lbl_wrkStati.text = "Work Order Number :"
            lineRejct_controller.getWorkOrderNumber(mtrIssType_id: mrtTypeId_, partNum_id: 0)//prtNo_ID
        default:
            break
        }
    }
    
    
    func getSelectedMrtTyp_ID(str_val: String) -> String {
        guard (materialTypeObj != nil) else {
            return ""
        }
        return (materialTypeObj.message!.first(where: {$0.name == str_val})?.id)!
    }
    
    func getWONumBasedOnPrtNum(id_: Int, mrtTyp_id_: String) {
        
        switch mrtTyp_id_ {
        case "1":
            //constr_view_hei.constant = (lbl_prtNum.frame.size.height + 20) * 4
            lineRejct_controller.getWorkOrderNumber(mtrIssType_id: Int(mrtTyp_id_)!, partNum_id: id_)
            
        case "2":
            
            //constr_view_hei.constant = (lbl_prtNum.frame.size.height + 20) * 4
            lineRejct_controller.getWorkOrderNumber(mtrIssType_id: Int(mrtTyp_id_)!, partNum_id: id_)
            
        case "3":
            guard (lr_wrkOrdNum.message![id_].id != nil) else {
                return
            }
            //SS_Utility.showIndicator(vc: self)
            //lineRejct_controller.getLineRejectionListItems(woNum_id: lr_wrkOrdNum.message![id_].id!, mtrIssType_id: Int(mrtTyp_id_)!)
            
        default:
            return
        }
    }
    
    func getSelectedPartNum_ID(str_val: String, mrtTypeID: Int) -> Int {
        switch mrtTypeID {
        case 1:
            guard (lr_drumPrtNum != nil) else {
                return 0
            }
            return (lr_drumPrtNum.message!.first(where: {$0.drumpartNo == str_val})?.id)!
            
        case 2:
            guard (lr_mixerPrtNum != nil) else {
                return 0
            }
            return (lr_mixerPrtNum.message!.first(where: {$0.partNo == str_val})?.id)!
        default:
            return 0
        }
        
    }
    
    //MARK:- Button Action
    @IBAction func backToVC(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateLineRej(sender: UIButton){
        dic_finalVal.removeAll()
        mrtTypID_ = Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!
        
        /*dic_finalVal = mrtTypID_ != 3 ? [Keys_val.lr_add_mrtIssFor.rawValue: controllr_addNewItem.fetchIdsOfJsonObjects(jsonObj: materialTypeObj, str_name: txt_mtrIssuFor.text!) , Keys_val.lr_add_partno.rawValue: controllr_addNewItem.fetchIdsOfJsonObjects(jsonObj: mrtTypID_ == 1 ? lr_drumPrtNum : lr_mixerPrtNum, str_name: "\(txt_part.text!.split(separator: "_").first!)"), Keys_val.lr_add_woNum.rawValue: controllr_addNewItem.fetchIdsOfJsonObjects(jsonObj: lr_wrkOrdNum, str_name: txt_wonum.text!), Keys_val.lr_add_wrkStation.rawValue: controllr_addNewItem.fetchIdsOfJsonObjects(jsonObj: lr_workStation, str_name: "\(txt_workStation.text!.split(separator: "_").first!)")]   :    [Keys_val.lr_add_mrtIssFor.rawValue: controllr_addNewItem.fetchIdsOfJsonObjects(jsonObj: materialTypeObj, str_name: txt_mtrIssuFor.text!), Keys_val.lr_add_partno.rawValue: 0, Keys_val.lr_add_woNum.rawValue: controllr_addNewItem.fetchIdsOfJsonObjects(jsonObj: lr_wrkOrdNum, str_name: txt_workStation.text!), Keys_val.lr_add_wrkStation.rawValue: controllr_addNewItem.fetchIdsOfJsonObjects(jsonObj: lr_workStation, str_name: "\(txt_part.text!.split(separator: "_").first!)")]*/
        
        
        dic_finalVal = mrtTypID_ != 3 ? [Keys_val.id_.rawValue: lr_itemList.id!, Keys_val.lr_add_partno.rawValue: controllr_addNewItem.fetchIdsOfJsonObjects(jsonObj: mrtTypID_ == 1 ? lr_drumPrtNum : lr_mixerPrtNum, str_name: "\(txt_part.text!.split(separator: "_").first!)"), Keys_val.lr_wo_Num.rawValue: controllr_addNewItem.fetchIdsOfJsonObjects(jsonObj: lr_wrkOrdNum, str_name: txt_wonum.text!), Keys_val.lr_add_wrkStation.rawValue: controllr_addNewItem.fetchIdsOfJsonObjects(jsonObj: lr_workStation, str_name: "\(txt_workStation.text!.split(separator: "_").first!)")]   :    [Keys_val.id_.rawValue: lr_itemList.id!, Keys_val.lr_add_partno.rawValue: 0, Keys_val.lr_wo_Num.rawValue: controllr_addNewItem.fetchIdsOfJsonObjects(jsonObj: lr_wrkOrdNum, str_name: txt_workStation.text!), Keys_val.lr_add_wrkStation.rawValue: controllr_addNewItem.fetchIdsOfJsonObjects(jsonObj: lr_workStation, str_name: "\(txt_part.text!.split(separator: "_").first!)")]
        
        
        controllr_addNewItem.updateLineRejection(dic_val: dic_finalVal)
        
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


extension SS_EditLineRej_ViewController: DropdownDelegate{
    func selectedIndexWithItem(index: Int, item: String, tagVal: Int) {
        
        switch tagVal {
        case 1:
            txt_mtrIssuFor.text = item
            txt_part.text = ""
            txt_workStation.text = ""
            txt_wonum.text = ""
            lr_listItems = LR_ListItems()
            ary_WONum.removeAll()
            ary_prtNum.removeAll()
            ary_wrkStation.removeAll()
            
            guard (materialTypeObj.message![index].id != nil) else {
                return
            }
            //constr_view_hei.constant = (lbl_prtNum.frame.size.height + 20) * 2
            getPartNumBaseOnMrtTyp(tagVal_: Int(materialTypeObj.message![index].id!)!)
            
        case 2:
            txt_part.text = item
            txt_workStation.text = ""
            txt_wonum.text = ""
            
            //constr_view_hei.constant = (lbl_prtNum.frame.size.height + 20) * 3
            getWONumOrWrkStataBasedOnPartNum_ID(mrtTypeId_: Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!)
            
        case 3:
            txt_workStation.text = item
            txt_wonum.text = ""
            
            getWONumBasedOnPrtNum(id_: getSelectedPartNum_ID(str_val: "\(txt_part.text!.split(separator: "_").first!)", mrtTypeID: Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!), mrtTyp_id_: getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))//index
            
        case 4:
            txt_wonum.text = item
            
            guard (lr_wrkOrdNum.message![index].id != nil) else {
                return
            }
            //SS_Utility.showIndicator(vc: self)
            //lineRejct_controller.getLineRejectionListItems(woNum_id: lr_wrkOrdNum.message![index].id!, mtrIssType_id: Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!)//
            
        default:
            break
            
        }
        dropDownView.removeDropdownFromSuperView(vc: self)
    }
}

extension SS_EditLineRej_ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        dropDownView.removeDropdownFromSuperView(vc: self)
        
        switch textField {
        case txt_mtrIssuFor:
            var ary_str = [String]()
            guard let dicVal = materialTypeObj else{
                return
            }
            for item_ in dicVal.message! {
                ary_str.append("\(SS_Utility.checkForDicNullValues(item_val: item_.name as Any))")
            }
            dropDownView.addDropdownView(selectedView: txt_mtrIssuFor, ary_data: ary_str, customView: view_bg, mainView: self.view, vc: self)
            
        case txt_part:
            dropDownView.addDropdownView(selectedView: txt_part, ary_data: getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!) != "3" ? ary_prtNum : ary_wrkStation , customView: view_bg, mainView: self.view, vc: self)
        case txt_workStation:
            dropDownView.addDropdownView(selectedView: txt_workStation, ary_data: getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!) != "3" ? ary_wrkStation : ary_WONum, customView: view_bg, mainView: self.view, vc: self)
        case txt_wonum:
            dropDownView.addDropdownView(selectedView: txt_wonum, ary_data: ary_WONum, customView: view_bg, mainView: self.view, vc: self)
            
        default:
            break
        }
    }
}

extension SS_EditLineRej_ViewController: LR_MaterialIssForDelegate{
    func successResponse(dic_response: MIA_MaterialTypes) {
        SS_Utility.stopIndicator(vc: self)
        materialTypeObj = dic_response
        
    }
    
    func errorResponse_matIssFor(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
            
        }
    }
}

extension SS_EditLineRej_ViewController: LR_DrumPartNumDelegate{
    func successResponse(dic_response: MIA_Drum_ParNum) {
        SS_Utility.stopIndicator(vc: self)
        lr_drumPrtNum = dic_response
        ary_prtNum.removeAll()
        for item_ in lr_drumPrtNum.message! {
            ary_prtNum.append("\(SS_Utility.checkForDicNullValues(item_val: item_.drumpartNo! + "_" + item_.drumModel!))")
        }
    }
    
    func errorResponse_drumPartNum(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
            
        }
    }
}

extension SS_EditLineRej_ViewController: LR_WorkOrdNumDelegate{
    func successResponse(dic_response: LR_WorkOrdNum) {
        SS_Utility.stopIndicator(vc: self)
        lr_wrkOrdNum = dic_response
        ary_WONum.removeAll()
        for item_ in lr_wrkOrdNum.message! {
            ary_WONum.append("\(SS_Utility.checkForDicNullValues(item_val: item_.workorderNo as Any))")
        }
    }
    
    func errorResponse_workOrdNum(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
            
        }
    }
}

extension SS_EditLineRej_ViewController: LR_MixerPartNumDelegate{
    func successResponse(dic_response: MIA_Mixer_PartNum) {
        SS_Utility.stopIndicator(vc: self)
        lr_mixerPrtNum = dic_response
        ary_prtNum.removeAll()
        for item_ in lr_mixerPrtNum.message! {
            ary_prtNum.append("\(SS_Utility.checkForDicNullValues(item_val: item_.partNo as Any))")
        }
    }
    
    func errorResponse_mixerPartNum(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}


extension SS_EditLineRej_ViewController: LR_WorkStationDelegate{
    func successResponse(dic_response: LR_WorkStation) {
        SS_Utility.stopIndicator(vc: self)
        lr_workStation = dic_response
        ary_wrkStation.removeAll()
        for item_ in lr_workStation.message! {
            ary_wrkStation.append("\(SS_Utility.checkForDicNullValues(item_val:item_.operationCode! + "_" + item_.listOfOperation! as Any))")
        }
    }
    
    func errorResponse_lrWrkSta(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}

extension SS_EditLineRej_ViewController: LR_UpdateLineRejDlegate{
    func successResponse(dic_response: LR_UpdateLineReject) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: dic_response.message!, alertType: 0){_ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func errorResponse_lrUpdateLRej(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
    
    
}

