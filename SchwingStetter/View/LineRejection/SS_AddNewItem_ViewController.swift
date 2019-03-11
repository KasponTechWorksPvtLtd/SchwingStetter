//
//  SS_AddNewItem_ViewController.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 20/12/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_AddNewItem_ViewController: UIViewController {

    
    @IBOutlet weak var lbl_matIssFor: UILabel!
    @IBOutlet weak var lbl_prtNum: UILabel!
    @IBOutlet weak var lbl_woNum: UILabel!
    @IBOutlet weak var lbl_wrkSta: UILabel!
    @IBOutlet weak var table_addNewItems: UITableView!
    @IBOutlet weak var constr_headerView_hei: NSLayoutConstraint!
    @IBOutlet weak var constr_table_hei: NSLayoutConstraint!
    @IBOutlet weak var constr_scrolView_hei: NSLayoutConstraint!
    @IBOutlet weak var constr_bgView_hei: NSLayoutConstraint!

    @IBOutlet weak var txt_part_: UITextField!
    @IBOutlet weak var txt_wonum_: UITextField!
    @IBOutlet weak var txt_workStation_: UITextField!
    @IBOutlet weak var txt_mtrIssuFor_: UITextField!
    @IBOutlet weak var view_bg_: UIView!
    
    
    var dic_lineRejVal = [String: Any]()
    var dic_finalVal = [String: Any]()
    var ary_lineRejItems = [[String: Any]]()
    var count_tableRow = 1
    let controller_addNewItems = SS_AddNewItem_Controller()
    let dropDownView = SS_Dropdown_ViewController()
    
    var materialTypeObj: MIA_MaterialTypes!
    var lr_drumPrtNum: MIA_Drum_ParNum!
    var lr_mixerPrtNum: MIA_Mixer_PartNum!
    var lr_wrkOrdNum: LR_WorkOrdNum!
    var lr_workStation: LR_WorkStation!
    var lr_partDesc: LR_PartDescript!
    var ary_prtNum = [String]()
    var ary_WONum = [String]()
    var ary_wrkStation = [String]()
    
    var lineRejct_controller = SS_LineRejection_Controller()
    //var addLineRej_controller = SS_AddNewItem_Controller()
    var mrtTyp_ID = 0
    var selectedIndex_ = -1
    var ary_cellDic = [[String: Any]]()
    

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
        controller_addNewItems.delegate_lrAddItmSubmi = self
        loadLineRejctionDetails()

        NotificationCenter.default.addObserver(self, selector: #selector(SS_AddNewItem_ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SS_AddNewItem_ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
       // constr_scrolView_hei.constant = table_addNewItems.rowHeight + 44
        
        ary_cellDic.insert([Keys_val.partno.rawValue: "", Keys_val.description.rawValue: "", Keys_val.quantity.rawValue: "", Keys_val.comments.rawValue: ""], at: 0)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //MARK:- Self Methods
    func loadLineRejctionDetails() {
        mrtTyp_ID = getSelectedMrtTyp_ID(str_val: dic_lineRejVal[Keys_val.lr_add_mrtIssFor.rawValue] as! String)
        txt_mtrIssuFor_.text = (dic_lineRejVal[Keys_val.lr_add_mrtIssFor.rawValue] as! String)
        txt_part_.text = (dic_lineRejVal[Keys_val.lr_add_partno.rawValue] as! String)
        txt_wonum_.text = (dic_lineRejVal[Keys_val.lr_add_woNum.rawValue] as! String)
        txt_workStation_.text = (dic_lineRejVal[Keys_val.lr_add_wrkStation.rawValue] as! String)
        constr_bgView_hei.constant = txt_mtrIssuFor_.frame.height * 6
        switch mrtTyp_ID {
        case 1:
            lbl_prtNum.text = "Drum Model :"
            
        case 2:
            lbl_prtNum.text = "Mixer Part No. :"
            
        case 3:
            lbl_prtNum.text = "Work Station :"
            lbl_wrkSta.text = "Work Order Number :"
            constr_bgView_hei.constant = txt_mtrIssuFor_.frame.height * 4
            txt_part_.text = (dic_lineRejVal[Keys_val.lr_add_wrkStation.rawValue] as! String)
            txt_workStation_.text = (dic_lineRejVal[Keys_val.lr_add_woNum.rawValue] as! String)
        default:
            break
        }
        
       
    }
    
    func saveTableData() {
        ary_cellDic.removeAll()
        for i in 0..<count_tableRow {
            guard let cell = table_addNewItems.cellForRow(at: IndexPath(row: i, section: 0)) as? SS_AddNewItemCell else {
                return
            }
            if !(cell.txt_prtNum.text == "")  && !(cell.txt_qty.text == "") && !(cell.txt_comments.text == ""){ //&& !(cell.txt_desc.text?.isEmpty)!
                ary_cellDic.insert([Keys_val.partno.rawValue: cell.txt_prtNum.text!, Keys_val.description.rawValue: cell.txt_desc.text!, Keys_val.quantity.rawValue: cell.txt_qty.text!, Keys_val.comments.rawValue: cell.txt_comments.text!], at: i)
            }else{
                ary_cellDic.insert([Keys_val.partno.rawValue: "", Keys_val.description.rawValue: "", Keys_val.quantity.rawValue: "", Keys_val.comments.rawValue: ""], at: i)
            }
            print("saveTableData:- \(ary_cellDic.count)")
        }
        
    }
    //MARK:- Button Action
    
    @IBAction func addNewEmptyNewItem(sender: UIButton){
        let cell = table_addNewItems.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! SS_AddNewItemCell

        if !(cell.txt_prtNum.text?.isEmpty)! && !(cell.txt_desc.text?.isEmpty)! && !(cell.txt_qty.text?.isEmpty)! && !(cell.txt_comments.text?.isEmpty)!{
            //saveTableData()
            count_tableRow += 1
            
             ary_cellDic.insert([Keys_val.partno.rawValue: "", Keys_val.description.rawValue: "", Keys_val.quantity.rawValue: "", Keys_val.comments.rawValue: ""], at: ary_cellDic.count)
            
            constr_table_hei.constant  = CGFloat(Int(table_addNewItems.rowHeight) * count_tableRow)
            constr_scrolView_hei.constant = constr_table_hei.constant + 70// constr_table_hei.constant  table_addNewItems.frame.size.height
            //table_addNewItems.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic) //count_tableRow - 1
            print("addNewEmptyNewItem:- \(ary_cellDic.count)")
            table_addNewItems.reloadData()
           // saveTableData()
        }else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: "All Fields are mandatory", alertType: 0){_ in  }
        }
        //saveTableData()
    }
    
    
    @IBAction func submitLineRejItems(sender: UIButton){
        
        ary_lineRejItems.removeAll()
        dic_finalVal.removeAll()
        mrtTyp_ID = getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor_.text!)
        
        dic_finalVal = mrtTyp_ID != 3 ? [Keys_val.lr_add_mrtIssFor.rawValue: controller_addNewItems.fetchIdsOfJsonObjects(jsonObj: materialTypeObj, str_name: txt_mtrIssuFor_.text!) , Keys_val.lr_add_partno.rawValue: controller_addNewItems.fetchIdsOfJsonObjects(jsonObj: mrtTyp_ID == 1 ? lr_drumPrtNum : lr_mixerPrtNum, str_name: "\(txt_part_.text!.split(separator: "_").first!)"), Keys_val.lr_add_woNum.rawValue: controller_addNewItems.fetchIdsOfJsonObjects(jsonObj: lr_wrkOrdNum, str_name: txt_wonum_.text!), Keys_val.lr_add_wrkStation.rawValue: controller_addNewItems.fetchIdsOfJsonObjects(jsonObj: lr_workStation, str_name: "\(txt_workStation_.text!.split(separator: "_").first!)")]   :    [Keys_val.lr_add_mrtIssFor.rawValue: controller_addNewItems.fetchIdsOfJsonObjects(jsonObj: materialTypeObj, str_name: txt_mtrIssuFor_.text!), Keys_val.lr_add_partno.rawValue: 0, Keys_val.lr_add_woNum.rawValue: controller_addNewItems.fetchIdsOfJsonObjects(jsonObj: lr_wrkOrdNum, str_name: txt_workStation_.text!), Keys_val.lr_add_wrkStation.rawValue: controller_addNewItems.fetchIdsOfJsonObjects(jsonObj: lr_workStation, str_name: "\(txt_part_.text!.split(separator: "_").first!)")]
        
        
        for i in 0..<count_tableRow {
            let cell = table_addNewItems.cellForRow(at: IndexPath(row: i, section: 0)) as! SS_AddNewItemCell
            if !(cell.txt_prtNum.text?.isEmpty)!  && !(cell.txt_qty.text?.isEmpty)! && !(cell.txt_comments.text?.isEmpty)!{ //&& !(cell.txt_desc.text?.isEmpty)!
                ary_lineRejItems.append([Keys_val.partno.rawValue: cell.txt_prtNum.text!, Keys_val.description.rawValue: cell.txt_desc.text!, Keys_val.quantity.rawValue: cell.txt_qty.text!, Keys_val.comments.rawValue: cell.txt_comments.text!, Keys_val.lr_add_woNum_.rawValue: dic_finalVal[Keys_val.lr_add_woNum.rawValue]!])
            }else{
                SS_Utility.showAlert(str_title: "Alert", str_msg: "All Fields are mandatory", alertType: 0){_ in  }
                return
            }
        }
        
        //dic_finalVal[Keys_val.lr_addNew_itemDetails.rawValue] = ary_lineRejItems
        print("\(dic_finalVal) \n \(ary_lineRejItems)")
        SS_Utility.showIndicator(vc: self)
        controller_addNewItems.submiteLRAddItems(ary_lrItems: ary_lineRejItems, dic_partNum: dic_finalVal)
    }
    
    @IBAction func resetLineItems(sender: UIButton){
        for i in 0...count_tableRow {
            let cell = table_addNewItems.cellForRow(at: IndexPath(row: i, section: 0)) as? SS_AddNewItemCell
            cell?.txt_comments.text = ""
            cell?.txt_qty.text = ""
            cell?.txt_desc.text = ""
            cell?.txt_prtNum.text = ""
            
        }
        ary_cellDic.removeAll()
         ary_cellDic.insert([Keys_val.partno.rawValue: "", Keys_val.description.rawValue: "", Keys_val.quantity.rawValue: "", Keys_val.comments.rawValue: ""], at: 0)
        
        count_tableRow = 1
        table_addNewItems.reloadData()
        constr_table_hei.constant  = CGFloat(Int(table_addNewItems.rowHeight) * count_tableRow)
        constr_scrolView_hei.constant = constr_table_hei.constant + 70
        
    }
    
    
    @IBAction func backToVC(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Selector Action
    @objc func checkForPartNum(sender: UIButton) {
        controller_addNewItems.delegate_lrPartDescrip = self
        selectedIndex_ = sender.tag
        let cell = table_addNewItems.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! SS_AddNewItemCell
        guard cell.txt_prtNum.text! !=  "" else {
            return
        }
        SS_Utility.showIndicator(vc: self)
        controller_addNewItems.getPartDescript(partNum: Int(cell.txt_prtNum.text!)!, mtrTypeId: mrtTyp_ID)
    }
    
    @objc func deleteRowItem(sender: UIButton) {
        if ary_cellDic.count > 1 { //count_tableRow
            count_tableRow -= 1
            
            print("deleteRowItem:- \(sender.tag)")
            constr_table_hei.constant  = CGFloat(Int(table_addNewItems.rowHeight) * count_tableRow)
            //table_addNewItems.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
            ary_cellDic.remove(at: sender.tag)
            /*let cell = table_addNewItems.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? SS_AddNewItemCell
            cell?.txt_prtNum.text = ""
            cell?.txt_qty.text = ""
            cell?.txt_comments.text = ""
            cell?.txt_desc.text = ""*/
            print("deleteRowItem:- \(ary_cellDic.count)")
            constr_scrolView_hei.constant = constr_table_hei.constant + 70 // constr_table_hei.constant table_addNewItems.frame.size.height
            table_addNewItems.reloadData()
        }
    }
    
    @objc func showDescripView(sender: UIButton){
        let des = ""
        
        SS_Utility.showAlert(str_title: "Description", str_msg: des, alertType: 0){_ in
            
        }
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
            return
        }
    }
    
    func getWONumBasedOnPrtNum(id_: Int, mrtTyp_id_: String) {
        
        switch mrtTyp_id_ {
        case "1":
           
            constr_bgView_hei.constant = (lbl_prtNum.frame.size.height + 18) * 4
            lineRejct_controller.getWorkOrderNumber(mtrIssType_id: Int(mrtTyp_id_)!, partNum_id: id_)//lr_drumPrtNum.message![id_].id!
            
        case "2":
            guard (lr_mixerPrtNum.message![id_].id != nil) else {
                return
            }
            constr_bgView_hei.constant = (lbl_prtNum.frame.size.height + 18) * 4
            lineRejct_controller.getWorkOrderNumber(mtrIssType_id: Int(mrtTyp_id_)!, partNum_id: lr_mixerPrtNum.message![id_].id!)
            
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
    
    func getSelectedMrtTyp_ID(str_val: String) -> Int {
        guard (materialTypeObj != nil) else {
            return 0
        }
        return Int((materialTypeObj.message!.first(where: {$0.name! == str_val})?.id)!)!
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
            lbl_wrkSta.text = "Work Station :"
            lineRejct_controller.getLineRejectionWorkStation(mtrIssType_id: mrtTypeId_)
        case 3:
           // lbl_wrkSta.text = "Mixer Part No."
            lbl_wrkSta.text = "Work Order Number :"
            lineRejct_controller.getWorkOrderNumber(mtrIssType_id: mrtTypeId_, partNum_id: 0)//prtNo_ID
        default:
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

extension SS_AddNewItem_ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary_cellDic.count//count_tableRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_addNewItems.dequeueReusableCell(withIdentifier: Cell_Identifier.cell_lrAddNewItems.rawValue, for: indexPath) as! SS_AddNewItemCell
        controller_addNewItems.addDoneButtonOnKeyboard(txt_feld: cell.txt_prtNum)
        controller_addNewItems.addDoneButtonOnKeyboard(txt_feld: cell.txt_qty)
        controller_addNewItems.delegate_doneBtn = cell
        
        print("cell:- \(ary_cellDic.count) \(count_tableRow)")
        
        if (indexPath.row <  ary_cellDic.count ) {//== count_tableRow
            let dic = ary_cellDic[indexPath.row]
            cell.txt_prtNum.text = dic[Keys_val.partno.rawValue] as? String
            cell.txt_desc.text = dic[Keys_val.description.rawValue] as? String
            cell.txt_qty.text = dic[Keys_val.quantity.rawValue] as? String
            cell.txt_comments.text = dic[Keys_val.comments.rawValue] as? String
        }
        
        
        cell.btn_check.tag = indexPath.row
        cell.btn_check.addTarget(self, action: #selector(checkForPartNum(sender:)), for: .touchUpInside)
        
        cell.btn_delete.tag = indexPath.row
        cell.btn_delete.addTarget(self, action: #selector(deleteRowItem(sender:)), for: .touchUpInside)
        
        cell.btn_desc.tag = indexPath.row
        cell.btn_desc.addTarget(self, action: #selector(showDescripView(sender:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastvisibleCell = table_addNewItems.indexPathsForVisibleRows?.last{
            if indexPath == lastvisibleCell{
                //saveTableData()
            }
        }
    }
}

extension SS_AddNewItem_ViewController: DropdownDelegate{
    func selectedIndexWithItem(index: Int, item: String, tagVal: Int) {
        
        switch tagVal {
        case 1:
            txt_mtrIssuFor_.text = item
            txt_part_.text = ""
            txt_workStation_.text = ""
            txt_wonum_.text = ""
            
            guard (materialTypeObj.message![index].id != nil) else {
                return
            }
            constr_bgView_hei.constant = (lbl_prtNum.frame.size.height + 18) * 2
            getPartNumBaseOnMrtTyp(tagVal_: Int(materialTypeObj.message![index].id!)!)
            
        case 2:
            txt_part_.text = item
            txt_workStation_.text = ""
            txt_wonum_.text = ""
            constr_bgView_hei.constant = (lbl_prtNum.frame.size.height + 18) * 3
            getWONumOrWrkStataBasedOnPartNum_ID(mrtTypeId_: Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor_.text!)))
            
        case 3:
            txt_workStation_.text = item
            txt_wonum_.text = ""
            
            getWONumBasedOnPrtNum(id_: getSelectedPartNum_ID(str_val: "\(txt_part_.text!.split(separator: "_").first!)", mrtTypeID: Int(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor_.text!))), mrtTyp_id_: "\(getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor_.text!))")
            
        case 4:
            txt_wonum_.text = item

            
        default:
            break
            
        }
        dropDownView.removeDropdownFromSuperView(vc: self)
    }
}

extension SS_AddNewItem_ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == txt_mtrIssuFor_ || textField == txt_part_ || textField == txt_wonum_ || textField == txt_workStation_){
                textField.resignFirstResponder()
        }
        
        dropDownView.removeDropdownFromSuperView(vc: self)
        
        switch textField {
        case txt_mtrIssuFor_:
            var ary_str = [String]()
            guard let dicVal = materialTypeObj else{
                return
            }
            for item_ in dicVal.message! {
                ary_str.append("\(SS_Utility.checkForDicNullValues(item_val: item_.name as Any))")
            }
            dropDownView.addDropdownView(selectedView: txt_mtrIssuFor_, ary_data: ary_str, customView: view_bg_, mainView: self.view, vc: self)
            
        case txt_part_:
            dropDownView.addDropdownView(selectedView: txt_part_, ary_data: getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor_.text!) != 3 ? ary_prtNum : ary_wrkStation , customView: view_bg_, mainView: self.view, vc: self)
        case txt_workStation_:
            dropDownView.addDropdownView(selectedView: txt_workStation_, ary_data: getSelectedMrtTyp_ID(str_val: txt_mtrIssuFor_.text!) != 3 ? ary_wrkStation : ary_WONum, customView: view_bg_, mainView: self.view, vc: self)
        case txt_wonum_:
            dropDownView.addDropdownView(selectedView: txt_wonum_, ary_data: ary_WONum, customView: view_bg_, mainView: self.view, vc: self)
            
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        saveTableData()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



extension SS_AddNewItemCell: DoneBtnClickedDelegate{
    func doneBtnClicked() {
        txt_prtNum.resignFirstResponder()
        txt_qty.resignFirstResponder()
    }

}


extension SS_AddNewItem_ViewController: LR_MaterialIssForDelegate{
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

extension SS_AddNewItem_ViewController: LR_DrumPartNumDelegate{
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

extension SS_AddNewItem_ViewController: LR_WorkOrdNumDelegate{
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

extension SS_AddNewItem_ViewController: LR_MixerPartNumDelegate{
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


extension SS_AddNewItem_ViewController: LR_WorkStationDelegate{
    func successResponse(dic_response: LR_WorkStation) {
        SS_Utility.stopIndicator(vc: self)
        lr_workStation = dic_response
        ary_wrkStation.removeAll()
        for item_ in lr_workStation.message! {
            ary_wrkStation.append("\(SS_Utility.checkForDicNullValues(item_val: item_.listOfOperation as Any))")
        }
    }
    
    func errorResponse_lrWrkSta(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}

extension SS_AddNewItem_ViewController: LR_PartDescripDelegate{
    func successResponse(dic_response: LR_PartDescript) {
        SS_Utility.stopIndicator(vc: self)
        lr_partDesc = dic_response
        if (lr_partDesc.message?.count != 0) && selectedIndex_ != -1 {
            let cell = table_addNewItems.cellForRow(at: IndexPath(row: selectedIndex_, section: 0)) as! SS_AddNewItemCell
            cell.txt_desc.text = lr_partDesc.message![0].description!
        }else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: "There is no description for this part number.", alertType: 0){_ in
            }
        }
    }
    
    func errorResponse_partDescrip(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}

extension SS_AddNewItem_ViewController: LR_AddItemsSubmitDelegate{
    func successResponse(dic_response: LR_AddItemsResult) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: dic_response.message!, alertType: 0){_ in
            self.dismiss(animated: true, completion: nil)

        }
    }
    
    func errorResponse_lrItems(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
    
  
}
