//
//  SS_MaterialStatus_ViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 17/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_MaterialStatus_ViewController: UIViewController {

    
    @IBOutlet weak var view_bg: UIView!
    @IBOutlet weak var txt_part: UITextField!
    @IBOutlet weak var txt_wonum: UITextField!
    @IBOutlet weak var txt_modelNme: UITextField!
    @IBOutlet weak var txt_midate: UITextField!
    @IBOutlet weak var txt_confirmat: UITextField!

    @IBOutlet weak var lbl_partNum: UILabel!
    @IBOutlet weak var lbl_woNum: UILabel!
    
    @IBOutlet weak var table_mrtList: UITableView!
    @IBOutlet weak var constra_viewBG_height: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_nodata: UILabel!
    @IBOutlet weak var constr_headerView_hei: NSLayoutConstraint!
    
    var mateIssTyp_controller = SS_MaterialIssue_Controller()
    var materialTypeObj: MIA_MaterialTypes!
    
    var mia_drumPrtNum: MIA_Drum_ParNum!
    var mia_drumWONum: MIA_Drum_WONum!
    var mia_mixerPrtNum: MIA_Mixer_PartNum!
    var mia_mixerWONum: MIA_Mixer_WONum!
    var mia_mountWONum: MIA_Mount_WONum!
    var mia_mrtList: MIA_Material_List!
    var mia_mrtAckn: MIA_Material_Acknowledge!
    var ary_prtNum = [String]()
    var ary_WONum = [String]()
    let dropDownView = SS_Dropdown_ViewController()
    var controller_addNewItem = SS_AddNewItem_Controller()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         //setMaterialIssueDate()
        constra_viewBG_height.constant = lbl_partNum.frame.size.height + 15
        mateIssTyp_controller.delegate_materialType = self
        mateIssTyp_controller.delegate_drumPartNum = self
        mateIssTyp_controller.delegate_drumWONum = self
        mateIssTyp_controller.delegate_mixerPartNum = self
        mateIssTyp_controller.delegate_mixerWONum = self
        mateIssTyp_controller.delegate_mountWONum = self
        mateIssTyp_controller.delegate_mrtList = self

        constr_headerView_hei.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
        
        controller_addNewItem.addDoneButtonOnKeyboard(txt_feld: txt_wonum)
        controller_addNewItem.addDoneButtonOnKeyboard(txt_feld: txt_modelNme)
        controller_addNewItem.delegate_doneBtn = self
        
        SS_Utility.showIndicator(vc: self)
        mateIssTyp_controller.getMaterialTypes()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        guard let id_mrtTyp = getSelectedMrtTyp_ID(str_val: txt_part.text!) as String?  else {
            return
        }
        
        switch id_mrtTyp {
        case "1":
            if(!(txt_part.text?.isEmpty)! && !(txt_wonum.text?.isEmpty)! && !(txt_modelNme.text?.isEmpty)!){
                mateIssTyp_controller.getMaterialList(mrtTypeID: Int(id_mrtTyp)!, mrtWONumId: getSelectedWONumIDBasedOn_str(mrtType: Int(id_mrtTyp)!, won: Int(txt_wonum.text!)!))
            }
        case "2":
            if(!(txt_part.text?.isEmpty)! && !(txt_wonum.text?.isEmpty)! && !(txt_modelNme.text?.isEmpty)!){
                mateIssTyp_controller.getMaterialList(mrtTypeID: Int(id_mrtTyp)!, mrtWONumId: getSelectedWONumIDBasedOn_str(mrtType: Int(id_mrtTyp)!, won: Int(txt_wonum.text!)!))
            }
        case "3":
            if(!(txt_part.text?.isEmpty)! && !(txt_modelNme.text?.isEmpty)!){
                mateIssTyp_controller.getMaterialList(mrtTypeID: Int(id_mrtTyp)!, mrtWONumId: getSelectedWONumIDBasedOn_str(mrtType: Int(id_mrtTyp)!, won: Int(txt_modelNme.text!)!))
            }
            
        default:
            break
        }
        
    }
    
    
    //MARK:- SelfMethods
    func clearTableView() {
        lbl_nodata.isHidden = true
        mia_mrtList = nil
        table_mrtList.reloadData()
        
    }
    //MARK:- ButtonAction
    
    @IBAction func homeBtnClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchForMaterialList(sender: UIButton){
        txt_wonum.resignFirstResponder()
        
        guard let id_mrtTyp = getSelectedMrtTyp_ID(str_val: txt_part.text!) as String?  else {
            return
        }
        
        switch id_mrtTyp {
        case "1":
            if(!(txt_part.text?.isEmpty)! && !(txt_wonum.text?.isEmpty)! && !(txt_modelNme.text?.isEmpty)!){
                SS_Utility.showIndicator(vc: self)
                mateIssTyp_controller.getMaterialList(mrtTypeID: Int(id_mrtTyp)!, mrtWONumId: getSelectedWONumIDBasedOn_str(mrtType: Int(id_mrtTyp)!, won: Int(txt_wonum.text!)!))
            }
        case "2":
            if(!(txt_part.text?.isEmpty)! && !(txt_wonum.text?.isEmpty)! && !(txt_modelNme.text?.isEmpty)!){
                SS_Utility.showIndicator(vc: self)
                mateIssTyp_controller.getMaterialList(mrtTypeID: Int(id_mrtTyp)!, mrtWONumId: getSelectedWONumIDBasedOn_str(mrtType: Int(id_mrtTyp)!, won: Int(txt_wonum.text!)!))
            }
        case "3":
            if(!(txt_part.text?.isEmpty)! && !(txt_modelNme.text?.isEmpty)!){
                SS_Utility.showIndicator(vc: self)
                mateIssTyp_controller.getMaterialList(mrtTypeID: Int(id_mrtTyp)!, mrtWONumId: getSelectedWONumIDBasedOn_str(mrtType: Int(id_mrtTyp)!, won: Int(txt_modelNme.text!)!))
            }
            
        default:
            break
        }
        
    }
    
    
    @IBAction func submitClicked(sender: UIButton){
        SS_Utility.showAlert(str_title: "Message", str_msg: "Successfully submitted", alertType: 0, completion: {
            if($0 == true){
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    @IBAction func cancelClicked(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    //MARK:- MaterialIssueDate
    
    func setMaterialIssueDate() {
        let date_ = Date()
        let dateFomr = DateFormatter()
        dateFomr.dateFormat = "dd-MM-YYYY"
        txt_midate.text = dateFomr.string(from: date_)
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(dismissPicker), tag_: 0)
        txt_midate.inputAccessoryView = toolBar
        
        let dateView = UIDatePicker().customDatePickerType(mySelector: #selector(datePickerValueChanged(sender:)))
        txt_midate.inputView = dateView
    }
    
    
    //MARK:- DatePicker ValueChanged Event
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let dateForm = DateFormatter()
        dateForm.dateFormat = "dd-MM-YYYY" // .short
        txt_midate.text = dateForm.string(from: sender.date)
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
        
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

extension SS_MaterialStatus_ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mia_mrtList != nil) ? mia_mrtList.message!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_mrtList.dequeueReusableCell(withIdentifier: Cell_Identifier.cell_materialList.rawValue) as! SS_MaterialAckn_TableCell
        let dicVal = mia_mrtList.message![indexPath.row].datas!
        
        cell.lbl_date.text = ": " + dicVal.date!
        cell.lbl_woNum.text = ": \(dicVal.workorderNo!)"
        cell.lbl_totalQty.text = ": \(dicVal.totalQty!)"
        cell.lbl_issuedQty.text = ": \(dicVal.issuedQty!)"
        cell.lbl_shiftEngStus.text = ": " + SS_Utility.MrtAckn_StoreStus(tagVal: dicVal.shiftEngineerStatus!)//status
        cell.lbl_storeStus.text = ": " + SS_Utility.MrtAckn_StoreStus(tagVal: dicVal.status!)//status
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table_mrtList.deselectRow(at: indexPath, animated: true)
        
        let mtr_sub = self.storyboard?.instantiateViewController(withIdentifier: SB_Identifier.SUBMITMTRACKNOVC.rawValue) as! SS_SubmitMtrAcknow_ViewController
        mtr_sub.mia_mtr = mia_mrtList.message![indexPath.row].datas!
        self.navigationController?.present(mtr_sub, animated: true, completion: nil)
        
    }
}

extension SS_MaterialStatus_ViewController: DropdownDelegate{
    func selectedIndexWithItem(index: Int, item: String, tagVal: Int) {
        
        switch tagVal {
        case 5:
            txt_part.text = item
            txt_modelNme.text = ""
            txt_wonum.text = ""
            
            clearTableView()
            constra_viewBG_height.constant = (lbl_partNum.frame.size.height + 15) * 2
            
            guard (materialTypeObj.message![index].id != nil) else {
                return
            }
            
            getPartNumBaseOnMrtTyp(tagVal_: Int(materialTypeObj.message![index].id!)!)
            
        case 6:
            txt_modelNme.text = item
            txt_wonum.text = ""
            clearTableView()
            txt_modelNme.resignFirstResponder()
            //txt_modelNme.text = "AM6SHC2"
            getWONumBasedOnPrtNum(id_: index, mrtTyp_id_: getSelectedMrtTyp_ID(str_val: txt_part.text!))
        case 9:
            txt_wonum.text = item
            clearTableView()
            //SS_Utility.showIndicator(vc: self)
            //mateIssTyp_controller.getMaterialList(mrtTypeID: Int(getSelectedMrtTyp_ID(str_val: txt_part.text!))!, mrtWONumId: getSelectedWONum_ID(mrtType: Int(getSelectedMrtTyp_ID(str_val: txt_part.text!))!, index_: index))
            
        default:
            break
            
        }
        txt_wonum.resignFirstResponder()
        dropDownView.removeDropdownFromSuperView(vc: self)
    }
    
    func getPartNumBaseOnMrtTyp(tagVal_: Int) {
        SS_Utility.showIndicator(vc: self)
        switch tagVal_ {
        case 1:
            mateIssTyp_controller.getDrumPartNum(tagVal_: 1)
            lbl_partNum.text = "Drum Model"
        case 2:
            mateIssTyp_controller.getMixerPartNum()
            lbl_partNum.text = "Mixer Part No."
        case 3:
            mateIssTyp_controller.getMountWONum()
            lbl_partNum.text = "Mounting WO No."
        default:
            return
        }
    }
    
    func getWONumBasedOnPrtNum(id_: Int, mrtTyp_id_: String) {
        SS_Utility.showIndicator(vc: self)
        switch mrtTyp_id_ {
        case "1":
            guard (mia_drumPrtNum.message![id_].id != nil) else {
                return
            }
            constra_viewBG_height.constant = (lbl_partNum.frame.size.height + 15) * 3
            mateIssTyp_controller.getDrumWONum(tagVal_: mia_drumPrtNum.message![id_].id! )
        case "2":
            guard (mia_mixerPrtNum.message![id_].id != nil) else {
                return
            }
            constra_viewBG_height.constant = (lbl_partNum.frame.size.height + 15) * 3
            mateIssTyp_controller.getMixerWONum(tagVal_: mia_mixerPrtNum.message![id_].id!)//partNo
        case "3":
            guard (mia_mountWONum.message![id_].id != nil) else {
                return
            }
            SS_Utility.stopIndicator(vc: self)
            //SS_Utility.showIndicator(vc: self)
            //mateIssTyp_controller.getMaterialList(mrtTypeID: 3, mrtWONumId: Int(mia_mountWONum.message![id_].id!))
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

    func getSelectedWONum_ID(mrtType: Int, index_: Int) -> Int {
        
        switch mrtType {
        case 1: guard (mia_drumWONum.message![index_].id != nil) else {
            return 0
        }
        return mia_drumWONum.message![index_].id!
        case 2:  guard (mia_mixerWONum.message![index_].id != nil) else {
            return 0
        }
        return mia_mixerWONum.message![index_].id!
        case 3:  guard (mia_mountWONum.message![index_].id != nil) else {
            return 0
        }
        return mia_mountWONum.message![index_].id!
        default: return 0
        }
    }
    
    func getSelectedWONumIDBasedOn_str(mrtType: Int, won: Int) -> Int {
        switch mrtType {
        case 1:
            guard let dic_ = mia_drumWONum.message?.first(where: { $0.workorderNo == won }) else {
                return 0
            }
            return dic_.id!
        case 2:
            guard let dic_ = mia_mixerWONum.message?.first(where: { $0.workorderNo == won }) else {
                return 0
            }
            return dic_.id!
        
        case 3:
            guard let dic_ = mia_mountWONum.message?.first(where: { $0.workorderNo == won }) else {
                return 0
            }
            
            return dic_.id!
        default: return 0
        }
    }
}

extension SS_MaterialStatus_ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txt_part.resignFirstResponder()
        if txt_part.text != "" {
            if  textField != txt_wonum && getSelectedMrtTyp_ID(str_val: txt_part.text!) != "3"  {
                textField.resignFirstResponder()
            }
            if textField == txt_modelNme && getSelectedMrtTyp_ID(str_val: txt_part.text!) == "3" {
                textField.becomeFirstResponder()
            }
        }
        
        dropDownView.removeDropdownFromSuperView(vc: self)
        
        switch textField {
        case txt_part:
            var ary_str = [String]()
            guard let dicVal = materialTypeObj else{
                return
            }
            for item_ in dicVal.message! {
                ary_str.append("\(SS_Utility.checkForDicNullValues(item_val: item_.name as Any))")
            }
            dropDownView.addDropdownView(selectedView: txt_part, ary_data: ary_str, customView: view_bg, mainView: self.view, vc: self)

        case txt_modelNme:
            
            let ary_search = getSelectedMrtTyp_ID(str_val: txt_part.text!) != "3" ? ary_prtNum : ary_WONum
            dropDownView.addDropdownView(selectedView: txt_modelNme, ary_data: ary_search, customView: view_bg, mainView: self.view, vc: self)

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
            if textField == txt_modelNme && getSelectedMrtTyp_ID(str_val: txt_part.text!) == "3" {
                let ary_search: [String]? =  ary_WONum
                var str_ = txt_modelNme.text! + string
                let _ = range.length == 1 ? "\(str_.removeLast())" : str_
                guard var found = (ary_search?.filter{ $0.contains(str_) }) else {
                    return false
                }
                
                if (range.location == 0 && found.count == 0){
                    found = ary_WONum
                }
                
                dropDownView.addDropdownView(selectedView: txt_modelNme, ary_data: found, customView: view_bg, mainView: self.view, vc: self)
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


extension SS_MaterialStatus_ViewController: DoneBtnClickedDelegate{
    func doneBtnClicked() {
        txt_wonum.resignFirstResponder()
        txt_modelNme.resignFirstResponder()
        
    }
    
}

extension SS_MaterialStatus_ViewController: MIA_MaterialTypesDelegate{
    func successResponse(dic_response: MIA_MaterialTypes) {
        SS_Utility.stopIndicator(vc: self)
        materialTypeObj = dic_response
        
    }
    
    func errorResponse_materialType(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
            
        }
    }
}

extension SS_MaterialStatus_ViewController: MIA_DrumPartNumDelegate{
    func successResponse(dic_response: MIA_Drum_ParNum) {
        SS_Utility.stopIndicator(vc: self)
        mia_drumPrtNum = dic_response
        ary_prtNum.removeAll()
        for item_ in mia_drumPrtNum.message! {
            ary_prtNum.append("\(SS_Utility.checkForDicNullValues(item_val: item_.drumpartNo! + "_" + item_.drumModel!))")
        }
    }
    
    func errorResponse_drumPartNum(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in

        }
    }
}

extension SS_MaterialStatus_ViewController: MIA_DrumWONumDelegate{
    func successResponse(dic_response: MIA_Drum_WONum) {
        SS_Utility.stopIndicator(vc: self)
        mia_drumWONum = dic_response
        ary_WONum.removeAll()
        for item_ in mia_drumWONum.message! {
            ary_WONum.append("\(SS_Utility.checkForDicNullValues(item_val: item_.workorderNo as Any))")
        }
    }
    
    func errorResponse_drumWONum(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in

        }
    }
}

extension SS_MaterialStatus_ViewController: MIA_MixerPartNumDelegate{
    func successResponse(dic_response: MIA_Mixer_PartNum) {
        SS_Utility.stopIndicator(vc: self)
        mia_mixerPrtNum = dic_response
        ary_prtNum.removeAll()
        for item_ in mia_mixerPrtNum.message! {
            ary_prtNum.append("\(SS_Utility.checkForDicNullValues(item_val: item_.partNo! + "_" + item_.mixerModel!))")
        }
    }
    
    func errorResponse_mixerPartNum(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}

extension SS_MaterialStatus_ViewController: MIA_MixerWONumDelegate{
    func successResponse(dic_response: MIA_Mixer_WONum) {
        SS_Utility.stopIndicator(vc: self)
        mia_mixerWONum = dic_response
        ary_WONum.removeAll()
        for item_ in mia_mixerWONum.message! {
            ary_WONum.append("\(SS_Utility.checkForDicNullValues(item_val: item_.workorderNo as Any))")
        }
        
    }
    
    func errorResponse_mixerWONum(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}

extension SS_MaterialStatus_ViewController: MIA_MountWONumDelegate{
    func successResponse(dic_response: MIA_Mount_WONum) {
        SS_Utility.stopIndicator(vc: self)
        mia_mountWONum = dic_response
        ary_WONum.removeAll()
        for item_ in mia_mountWONum.message! {
            ary_WONum.append("\(SS_Utility.checkForDicNullValues(item_val: item_.workorderNo as Any))")
        }
        
    }
    
    func errorResponse_mountWONum(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
            
        }
    }
}

extension SS_MaterialStatus_ViewController: MIA_MaterialListDelegate{
    func successResponse(dic_response: MIA_Material_List) {
        SS_Utility.stopIndicator(vc: self)
        mia_mrtList = dic_response
        
        if (mia_mrtList.message!.count != 0) {
            table_mrtList.isHidden = false
            lbl_nodata.isHidden = true
            table_mrtList.reloadData()

        }else{
            table_mrtList.isHidden = true
            lbl_nodata.isHidden = false
        }
    }
    
    func errorResponse_mrtList(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        clearTableView()
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
            self.table_mrtList.isHidden = true
            self.lbl_nodata.isHidden = false
        }
    }
}

/*extension SS_MaterialStatus_ViewController: MIA_MaterialAcknDelegate{
    func successResponse(dic_response: MIA_Material_Acknowledge) {
        SS_Utility.stopIndicator(vc: self)
        mia_mrtAckn = dic_response
    }
    
    func errorResponse_mrtAckn(error_: String) {
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}*/
