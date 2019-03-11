//
//  SS_LineReject_ViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 17/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_LineReject_ViewController: UIViewController {

    
    @IBOutlet weak var view_bg: UIView!
    @IBOutlet weak var txt_part: UITextField!
    @IBOutlet weak var txt_wonum: UITextField!
    @IBOutlet weak var txt_workStation: UITextField!
    @IBOutlet weak var txt_mtrIssuFor: UITextField!
    @IBOutlet weak var constr_headerView_hei: NSLayoutConstraint!
    @IBOutlet weak var constr_view_hei: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_prtNum: UILabel!
    @IBOutlet weak var lbl_wrkStati: UILabel!
    @IBOutlet weak var table_lineRej: UITableView!
    @IBOutlet weak var lbl_nodata: UILabel!

    var mateIssTyp_controller = SS_MaterialIssue_Controller()
    var lineRejct_controller = SS_LineRejection_Controller()
    weak var delegate_materialType: MIA_MaterialTypesDelegate?
    var materialTypeObj: MIA_MaterialTypes!
    let dropDownView = SS_Dropdown_ViewController()
    var controller_addNewItem = SS_AddNewItem_Controller()
    var lr_drumPrtNum: MIA_Drum_ParNum!
    var lr_mixerPrtNum: MIA_Mixer_PartNum!
    var lr_wrkOrdNum: LR_WorkOrdNum!
    var lr_listItems: LR_ListItems!
    var lr_workStation: LR_WorkStation!
    var ary_prtNum = [String]()
    var ary_WONum = [String]()
    var ary_wrkStation = [String]()

    var int_ref_woNum = 0
    var int_ref_mrtIssId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       constr_headerView_hei.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
         constr_view_hei.constant = lbl_prtNum.frame.size.height + 15
        
        lineRejct_controller.showMaterialIssueFor()
        lineRejct_controller.delegate_lrMtrIssFor = self
        lineRejct_controller.delegate_lrDrum_partNo = self
        lineRejct_controller.delegate_lrMixer_partNo = self
        lineRejct_controller.delegate_lrWorkOrdNum = self
        lineRejct_controller.delegate_lrWrkSta = self
        lineRejct_controller.delegate_lrListItems = self
        lineRejct_controller.delegate_lrDeleteList = self
        controller_addNewItem.addDoneButtonOnKeyboard(txt_feld: txt_wonum)
        controller_addNewItem.addDoneButtonOnKeyboard(txt_feld: txt_workStation)

        controller_addNewItem.delegate_doneBtn = self
        
    }

    //MARK:- ButtonAction
    
    @IBAction func homeBtnClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitClicked(sender: UIButton){
        SS_Utility.showAlert(str_title: "Message", str_msg: "Successfully submitted", alertType: 0, completion: {
            if($0 == true){
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    @IBAction func searchForLineRejItems(sender: UIButton) {
       
        if lineRejct_controller.isValidTextField(txt1_: txt_mtrIssuFor, txt2_: txt_part, txt3_: txt_workStation, txt4_: txt_wonum, mrtTypId_: int_ref_mrtIssId) {
            getFinalList()
        }else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Kindly enter all fields.", alertType: 0){_ in  }
        }
        
    }
    
    @IBAction func addNewItems(sender: UIButton){
        guard !(txt_mtrIssuFor.text?.isEmpty)! else {
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Kindly enter all fields.", alertType: 0){_ in  }
            return
        }
        
        let mrtTag_ = Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!
        if lineRejct_controller.isValidTextField(txt1_: txt_mtrIssuFor, txt2_: txt_part, txt3_: txt_workStation, txt4_: txt_wonum, mrtTypId_: mrtTag_) {
           
            let vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.ADDNEWITEMSVC.rawValue) as! SS_AddNewItem_ViewController
            
            vc.dic_lineRejVal = mrtTag_ != 3 ? [Keys_val.lr_add_mrtIssFor.rawValue: txt_mtrIssuFor.text!, Keys_val.lr_add_partno.rawValue: txt_part.text ?? "", Keys_val.lr_add_woNum.rawValue: txt_wonum.text ?? "", Keys_val.lr_add_wrkStation.rawValue: txt_workStation.text ?? ""] : [Keys_val.lr_add_mrtIssFor.rawValue: txt_mtrIssuFor.text!, Keys_val.lr_add_partno.rawValue: "", Keys_val.lr_add_woNum.rawValue: txt_workStation.text ?? "", Keys_val.lr_add_wrkStation.rawValue: txt_part.text ?? ""]
            
            vc.materialTypeObj = materialTypeObj
             vc.lr_drumPrtNum = lr_drumPrtNum
             vc.lr_mixerPrtNum = lr_mixerPrtNum
             vc.lr_wrkOrdNum = lr_wrkOrdNum
             vc.lr_workStation = lr_workStation
            
            self.navigationController?.present(vc, animated: true, completion: nil)
        }else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Kindly enter all fields.", alertType: 0){_ in
                
            }
        }
 
    }
    
    @IBAction func cancelClicked(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK:- Selector Methods
    @objc func deleteSelectedList(sender: UIButton)  {
        /*let vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.VIEWLINEREJITEMSVC.rawValue) as! SS_ViewLRItems_ViewController
        vc.lr_itemList = lr_listItems.message![sender.tag]
        vc.mrtTypID_ = Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!
        self.present(vc, animated: true, completion: nil)*/
        SS_Utility.showAlert(str_title: "Alert", str_msg: "Are you sure, you want to delete this item.", alertType: 1, completion: {res in
            if(res == true){
                SS_Utility.showIndicator(vc: self)
                self.lineRejct_controller.deleteLineRejectionList(id_: self.lr_listItems.message![sender.tag].id!)
            }
        })
        
    }
    
    @objc func editAddedLineItems(sender: UIButton) {
        /*let vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.EDITLINEREJVC.rawValue) as! SS_EditLineRej_ViewController
        vc.lr_itemList = lr_listItems.message![sender.tag]
        vc.mrtTypID_ = Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!
        vc.ary_WONum = ary_WONum
        vc.ary_prtNum = ary_prtNum
        vc.ary_wrkStation = ary_wrkStation
        vc.lr_wrkOrdNum = lr_wrkOrdNum
        vc.lr_drumPrtNum = lr_drumPrtNum
        vc.lr_mixerPrtNum = lr_mixerPrtNum
        vc.lr_workStation = lr_workStation
        
        self.present(vc, animated: true, completion: nil)*/
        let vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.VIEWLINEREJITEMSVC.rawValue) as! SS_ViewLRItems_ViewController
        vc.lr_itemList = lr_listItems.message![sender.tag]
        vc.mrtTypID_ = Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!
        vc.qcStauts = lr_listItems.message![sender.tag].qcStatus!
        self.present(vc, animated: true, completion: nil)
    }
    
    func getFinalList() {
        SS_Utility.showIndicator(vc: self)
        self.lineRejct_controller.getLineRejectionListItems(woNum_id: self.int_ref_woNum, mtrIssType_id: self.int_ref_mrtIssId)
    }
    
    //MARK:- Self Methods
    
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
            SS_Utility.stopIndicator(vc: self)
            return
        }
    }
    
    /*func getDrumByMixerIDBasedOnMrtType(mrtTypeId: Int, selectedIndex: Int) -> Int {
        switch mrtTypeId {
        case 1:
            return lr_drumPrtNum.message![selectedIndex].id!
        case 2:
            return lr_mixerPrtNum.message![selectedIndex].id!
        case 3:
            return 0
        default:
            break
        }
    }*/
    
    func getWONumBasedOnPrtNum(id_: Int, mrtTyp_id_: String) {
        
        switch mrtTyp_id_ {
        case "1":
            /*guard (lr_drumPrtNum.message?[id_].id != nil) else {
                return
            }*/
            constr_view_hei.constant = (lbl_prtNum.frame.size.height + 15) * 4
            lineRejct_controller.getWorkOrderNumber(mtrIssType_id: Int(mrtTyp_id_)!, partNum_id: id_)//lr_drumPrtNum.message![id_].id!
            
        case "2":
            /*guard (lr_mixerPrtNum.message![id_].id != nil) else {
                return
            }*/
            constr_view_hei.constant = (lbl_prtNum.frame.size.height + 15) * 4
            lineRejct_controller.getWorkOrderNumber(mtrIssType_id: Int(mrtTyp_id_)!, partNum_id: id_)//lr_mixerPrtNum.message![id_].id!

        case "3":
            guard (lr_wrkOrdNum.message![id_].id != nil) else {
                return
            }
            
            int_ref_woNum = lr_wrkOrdNum.message![id_].id!
            int_ref_mrtIssId = Int(mrtTyp_id_)!
            //SS_Utility.showIndicator(vc: self)
            //lineRejct_controller.getLineRejectionListItems(woNum_id: lr_wrkOrdNum.message![id_].id!, mtrIssType_id: Int(mrtTyp_id_)!)
            
        default:
            return
        }
    }
    
    func getSelectedMrtTyp_ID(str_val: String) -> String {
        guard (materialTypeObj != nil) else {
            return ""
        }
        return (materialTypeObj.message!.first(where: {$0.name == str_val})?.id)!
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
    
    //MARK:- Get WONUM or WrkStataion Based on Material Type
    func getWONumOrWrkStataBasedOnPartNum_ID(mrtTypeId_: Int) {//, prtNo_ID: Int
        switch mrtTypeId_ {
        case 1, 2:
            lbl_wrkStati.text = "Work Station :"
            lineRejct_controller.getLineRejectionWorkStation(mtrIssType_id: mrtTypeId_)
        case 3:
            lbl_wrkStati.text = "Work Order Number :"
            lineRejct_controller.getWorkOrderNumber(mtrIssType_id: mrtTypeId_, partNum_id: 0)//prtNo_ID
        default:
            SS_Utility.stopIndicator(vc: self)
            break
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

extension SS_LineReject_ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (lr_listItems != nil) ? lr_listItems.message!.count : 0 //1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_lineRej.dequeueReusableCell(withIdentifier: Cell_Identifier.cell_lineRejection.rawValue) as! SS_LineRejCell
        let dic_val = lr_listItems.message![indexPath.row]
        
        cell.lbl_woNO.text = ": \(SS_Utility.checkForDicNullValues(item_val: dic_val.workorderNo as Any))"
        cell.lbl_prtNO.text = ": \(SS_Utility.checkForDicNullValues(item_val: dic_val.drumpartNo as Any))"
        cell.lbl_lineRejItms.text = ": \(SS_Utility.checkForDicNullValues(item_val: dic_val.lineRejectionID as Any))"
        cell.lbl_reqBy.text = ": \(SS_Utility.checkForDicNullValues(item_val: dic_val.requestedBy as Any))"
        cell.lbl_qcStus.text = ": \(SS_Utility.checkForDicNullValues(item_val: dic_val.qcStatus as Any))"
        cell.lbl_sapStus.text = ": \(SS_Utility.checkForDicNullValues(item_val: dic_val.sapStatus as Any))"
        cell.lbl_qcRewrkDetls.text = ": \(SS_Utility.checkForDicNullValues(item_val: dic_val.qcReworkDetails as Any))"
        cell.lbl_qcCmmts.text = ": \(SS_Utility.checkForDicNullValues(item_val: dic_val.qcComments as Any))"
        cell.lbl_action.text = ": \(SS_Utility.checkForDicNullValues(item_val: dic_val.storeStatus as Any))"
        
        //cell.btn_delete.setTitle("\(SS_Utility.checkForDicNullValues(item_val: dic_val.id as Any))", for: .normal)
        cell.btn_delete.isHidden = dic_val.qcStatus == 1 ? true : false
        cell.btn_delete.tag = indexPath.row
        cell.btn_delete.addTarget(self, action: #selector(deleteSelectedList(sender:)), for: .touchUpInside)
        
        cell.btn_edit.setTitle(dic_val.qcStatus == 1 ? "View" : "Edit", for: .normal)
        //cell.btn_edit.isHidden = dic_val.qcStatus == 1 ? true : false
        cell.btn_edit.tag = indexPath.row
        cell.btn_edit.addTarget(self, action: #selector(editAddedLineItems(sender:)), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

extension SS_LineReject_ViewController: DropdownDelegate{
    func selectedIndexWithItem(index: Int, item: String, tagVal: Int) {
        
        
        switch tagVal {
        case 1:
            txt_mtrIssuFor.text = item
            txt_part.text = ""
            txt_workStation.text = ""
            txt_wonum.text = ""
            lr_listItems = LR_ListItems()
            table_lineRej.reloadData()
            ary_WONum.removeAll()
            ary_prtNum.removeAll()
            ary_wrkStation.removeAll()
            
            constr_view_hei.constant = (lbl_prtNum.frame.size.height + 15) * 2
            guard (materialTypeObj.message![index].id != nil) else {
                return
            }
            SS_Utility.showIndicator(vc: self)
            getPartNumBaseOnMrtTyp(tagVal_: Int(materialTypeObj.message![index].id!)!)
            
        case 2:
            txt_part.text = item
            txt_workStation.text = ""
            txt_wonum.text = ""
            
            
            //txt_modelNme.text = "AM6SHC2"
            constr_view_hei.constant = (lbl_prtNum.frame.size.height + 15) * 3
            //getWONumBasedOnPrtNum(id_: index, mrtTyp_id_: getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))
            SS_Utility.showIndicator(vc: self)
            getWONumOrWrkStataBasedOnPartNum_ID(mrtTypeId_: Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!)//, prtNo_ID: getDrumByMixerIDBasedOnMrtType(mrtTypeId: Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!, selectedIndex: index)
        case 3:
            txt_workStation.text = item
            txt_wonum.text = ""
            //constr_view_hei.constant = (lbl_prtNum.frame.size.height + 15) * 4
            
            getWONumBasedOnPrtNum(id_: getSelectedPartNum_ID(str_val: "\(txt_part.text!.split(separator: "_").first!)", mrtTypeID: Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!), mrtTyp_id_: getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))//index
            
        case 4:
            txt_wonum.text = item
            
            guard (lr_wrkOrdNum.message![index].id != nil) else {
                return
            }
            
            int_ref_woNum = lr_wrkOrdNum.message![index].id!
            int_ref_mrtIssId = Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!
            //SS_Utility.showIndicator(vc: self)
            //lineRejct_controller.getLineRejectionListItems(woNum_id: lr_wrkOrdNum.message![index].id!, mtrIssType_id: Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!))!)//
            
        default:
            break
            
        }
        dropDownView.removeDropdownFromSuperView(vc: self)
        txt_workStation.resignFirstResponder()
        txt_wonum.resignFirstResponder()
        txt_part.resignFirstResponder()
    }
}

extension SS_LineReject_ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //textField.resignFirstResponder()
        dropDownView.removeDropdownFromSuperView(vc: self)
        
        txt_mtrIssuFor.resignFirstResponder()
        if txt_mtrIssuFor.text != "" {
            if  textField != txt_wonum && getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!) != "3"  {
                textField.resignFirstResponder()
            }
            if textField == txt_part && getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!) == "3" {
                textField.resignFirstResponder()
            }
        }
        
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        dropDownView.removeDropdownFromSuperView(vc: self)

        if textField == txt_wonum {
            let ary_search: [String]? =  ary_WONum
            var str_ = txt_wonum.text! + string
            let _ = range.length == 1 ? "\(str_.removeLast())" : str_
            guard var found = (ary_search?.filter{ $0.contains(str_) }) else {
                return false
            }
            
            if (range.location == 0 && found.count == 0){
                found = ary_WONum
            }
            dropDownView.addDropdownView(selectedView: txt_wonum, ary_data: found, customView: view_bg, mainView: self.view, vc: self)
            
            
            
        }
        
        if txt_part.text != "" {
            if textField == txt_workStation && getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor.text!) == "3" {
                let ary_search: [String]? =  ary_WONum
                var str_ = txt_workStation.text! + string
                let _ = range.length == 1 ? "\(str_.removeLast())" : str_
                guard var found = (ary_search?.filter{ $0.contains(str_) }) else {
                    return false
                }
                if (range.location == 0 && found.count == 0){
                    found = ary_WONum
                }
                dropDownView.addDropdownView(selectedView: txt_workStation, ary_data: found, customView: view_bg, mainView: self.view, vc: self)
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SS_LineReject_ViewController: DoneBtnClickedDelegate{
    func doneBtnClicked() {
        txt_wonum.resignFirstResponder()
        txt_workStation.resignFirstResponder()
    }
    
}

extension SS_LineReject_ViewController: LR_MaterialIssForDelegate{
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

extension SS_LineReject_ViewController: LR_DrumPartNumDelegate{
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

extension SS_LineReject_ViewController: LR_WorkOrdNumDelegate{
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

extension SS_LineReject_ViewController: LR_MixerPartNumDelegate{
    func successResponse(dic_response: MIA_Mixer_PartNum) {
        SS_Utility.stopIndicator(vc: self)
        lr_mixerPrtNum = dic_response
        ary_prtNum.removeAll()
        for item_ in lr_mixerPrtNum.message! {
            ary_prtNum.append("\(SS_Utility.checkForDicNullValues(item_val: item_.partNo! + "_" + item_.mixerModel! as Any))")
        }
    }
    
    func errorResponse_mixerPartNum(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}


extension SS_LineReject_ViewController: LR_WorkStationDelegate{
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

extension SS_LineReject_ViewController: LR_ListItemsDelegate{
    func successResponse(dic_response: LR_ListItems) {
        SS_Utility.stopIndicator(vc: self)
        lr_listItems = dic_response
        
        if (lr_listItems.message!.count != 0) {
            table_lineRej.isHidden = false
            lbl_nodata.isHidden = true
            table_lineRej.reloadData()
            
        }else{
            table_lineRej.isHidden = true
            lbl_nodata.isHidden = false
        }
        
    }
    
    func errorResponse_lineRejItem(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
    
    
}

extension SS_LineReject_ViewController: LR_DeleteListDelegate{
    func successResponse(dic_response: KPT_DeleteList) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: dic_response.message!, alertType: 0){_ in
            SS_Utility.showIndicator(vc: self)
            self.lineRejct_controller.getLineRejectionListItems(woNum_id: self.int_ref_woNum, mtrIssType_id: self.int_ref_mrtIssId)
        }
    }
    
    func errorResponse_deleteList(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
    
    
}
