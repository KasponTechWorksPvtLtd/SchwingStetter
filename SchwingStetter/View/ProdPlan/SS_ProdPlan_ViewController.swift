//
//  SS_ProdPlan_ViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 16/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_ProdPlan_ViewController: UIViewController {

    
    @IBOutlet weak var table_pp: UITableView!
    @IBOutlet weak var txt_fromDate: UITextField!
    @IBOutlet weak var txt_partNo: UITextField!
    @IBOutlet weak var txt_toDate: UITextField!
    @IBOutlet weak var lbl_nodata: UILabel!
     @IBOutlet weak var constr_headerView_hei: NSLayoutConstraint!
    @IBOutlet weak var view_bg: UIView!

    //var dic_response = [String: Any]()
    var ary_dicResponse = [ProductionView]()//[[String: Any]]()
    let planController = SS_ProdPlan_Controller()
    var pppNo: SSProdPlanPartNum!
    var ary_prtNo = [String]()
    let dropDownView = SS_Dropdown_ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table_pp.estimatedRowHeight = 60
        self.table_pp.rowHeight = UITableViewAutomaticDimension
        self.table_pp.tableFooterView = UIView()

        // Do any additional setup after loading the view.
        
       /* ary_dicResponse.append([Keys_val.share.workingOrder: "801528", Keys_val.share.mixerAssembly: "AMBAHD2", Keys_val.share.portNum: "8010726", Keys_val.share.priority: "1", Keys_val.share.plannedSchedule: "22-10-2018"])
        ary_dicResponse.append([Keys_val.share.workingOrder: "801529", Keys_val.share.mixerAssembly: "AMBAFG5", Keys_val.share.portNum: "8010727", Keys_val.share.priority: "2", Keys_val.share.plannedSchedule: "23-10-2018"])
        ary_dicResponse.append([Keys_val.share.workingOrder: "801530", Keys_val.share.mixerAssembly: "AMBAKY1", Keys_val.share.portNum: "8010728", Keys_val.share.priority: "3", Keys_val.share.plannedSchedule: "24-10-2018"])*/
        
        constr_headerView_hei.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
    }
    
    override func viewWillLayoutSubviews() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //loadProductionViewData()
        self.getPPPNum()
    }
    
    //MARK:- Self Methods
    
    func getPPPNum() {
        SS_Utility.showIndicator(vc: self)
        planController.delegate_prodPlanPrtNo = self
        planController.getPartNumber()
    }
    
    func loadProductionViewData() {
        if !(txt_fromDate.text?.isEmpty)! && !(txt_toDate.text?.isEmpty)! {
            SS_Utility.showIndicator(vc: self)
            planController.delegate = self
            planController.getProductionList(fromDate_: txt_fromDate.text!, toDate_: txt_toDate.text!)
        }
    }
    
    //MARK:- DatePicker ValueChanged Event
    @objc func datePickerValueChanged(sender: UIDatePicker) {

        /*let dateForm = DateFormatter()
        //dateForm.dateStyle = .short
        dateForm.dateFormat = "yyyy-MM-dd"
        if sender.tag == 0{
            txt_fromDate.text = dateForm.string(from: sender.date)
            if(!(txt_toDate.text?.isEmpty)! && planController.compareTwoDates(from_: txt_fromDate.text!, to_: txt_toDate.text!)){
                txt_toDate.text = txt_fromDate.text
            }
        }
        else{
            txt_toDate.text = dateForm.string(from: sender.date)
        }*/
        let dateForm = DateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd"
        txt_toDate.text = dateForm.string(from: sender.date)

        
    }
    
    @objc func dismissPicker(sender: UIButton) {
       
        let dateForm = DateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd"
        let date_ = dateForm.string(from: Date())
        if(sender.tag == 1 && (txt_toDate.text?.isEmpty)!) {
            txt_toDate.text =  date_}
        
       /* if(sender.tag == 0 && (txt_fromDate.text?.isEmpty)!) {
             txt_fromDate.text =  date_
            if(!(txt_toDate.text?.isEmpty)!){
               let boolVal = planController.compareTwoDates(from_: date_, to_: txt_toDate.text!)
                if boolVal{
                    txt_toDate.text = date_
                }
            }
        }else if (sender.tag == 1 && (txt_toDate.text?.isEmpty)!){
                txt_toDate.text = planController.compareTwoDates(from_: txt_fromDate.text!, to_: date_) ? txt_fromDate.text : date_
        }
        
        if (!(txt_fromDate.text?.isEmpty)! && !(txt_toDate.text?.isEmpty)!) {
            loadProductionViewData()
        }*/
        view.endEditing(true)
    }
    
    //MARK:- Button ACtion
    @IBAction func backBtnClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchProdPlanList(sender: UIButton){
        guard !(txt_partNo.text?.isEmpty)! else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Part Number should not be empty.", alertType: 0){_ in
                
            }
            return
        }
        guard !(txt_toDate.text?.isEmpty)! else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Date should not be empty.", alertType: 0){_ in
                
            }
            return
        }
        
        SS_Utility.showIndicator(vc: self)
        planController.delegate = self
        planController.getProductionList(partNum: pppNo.message![txt_partNo.tag].id!, selecDate: txt_toDate.text!)
        
    }
    
    @objc func edit_prodPriority(sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.EDITPPVC.rawValue) as! SS_Edit_PP_ViewController
        //vc.dic_select = ary_dicResponse[sender.tag]
        for item_ in ary_dicResponse.indices {
            vc.ary_pickerdata.append(String(item_ + 1))
        }
        vc.ary_editProdu = ary_dicResponse[sender.tag]
        self.present(vc, animated: true, completion: nil)
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

extension SS_ProdPlan_ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        /*if((txt_fromDate.text?.isEmpty)! && textField.tag == 1){
            SS_Utility.showAlert(str_title: "Message", str_msg: "From date should not be empty", alertType: 0, completion: {_ in
            })
        }else{
            let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(dismissPicker(sender:)), tag_: textField.tag)
            textField.inputAccessoryView = toolBar
            
            let dateView = UIDatePicker().customDatePickerType(mySelector: #selector(datePickerValueChanged(sender:)))
            dateView.tag = textField.tag
            if(textField.tag == 1){
                let dateForm = DateFormatter()
                //dateForm.dateStyle = .short
                dateForm.dateFormat = "yyyy-MM-dd"
                dateView.minimumDate = dateForm.date(from: txt_fromDate.text!)
                SS_Utility.getCurrentDateAndTime()
            }
            
            textField.inputView = dateView
        }*/
        dropDownView.removeDropdownFromSuperView(vc: self)

        switch textField {
        case txt_toDate:
            let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(dismissPicker(sender:)), tag_: textField.tag)
            textField.inputAccessoryView = toolBar
            let dateView = UIDatePicker().customDatePickerType(mySelector: #selector(datePickerValueChanged(sender:)))
            let dateForm = DateFormatter()
            dateForm.dateFormat = "yyyy-MM-dd"
            textField.inputView = dateView
        case txt_partNo:
            textField.resignFirstResponder()
            dropDownView.addDropdownView(selectedView: txt_partNo, ary_data: ary_prtNo, customView: view_bg, mainView: self.view, vc: self)
        
        default:
            break
        }
        
    }
}

extension SS_ProdPlan_ViewController: DropdownDelegate{
    func selectedIndexWithItem(index: Int, item: String, tagVal: Int) {
        txt_partNo.text = item
        txt_partNo.tag = index
        dropDownView.removeDropdownFromSuperView(vc: self)

    }
}

extension SS_ProdPlan_ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary_dicResponse.count//3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_pp.dequeueReusableCell(withIdentifier: Cell_Identifier.cell_prodPlan.rawValue) as! SS_ProdPlan_tableCell
        
        let dicVal = ary_dicResponse[indexPath.row]
        
        cell.lbl_woNum.text = "\(SS_Utility.checkForDicNullValues(item_val: dicVal.workorderNo as Any))"
        cell.lbl_mav.text = "\(SS_Utility.checkForDicNullValues(item_val: dicVal.mixerModelno as Any))"
        cell.lbl_portNum.text = "\(SS_Utility.checkForDicNullValues(item_val: dicVal.partNo as Any))"
        cell.lbl_priorNum.text = "\(SS_Utility.checkForDicNullValues(item_val: dicVal.priority as Any))"
        cell.lbl_planSched.text = "\(SS_Utility.checkForDicNullValues(item_val: dicVal.planSchedule as Any))"

        cell.btn_edit.tag = indexPath.row
        cell.btn_edit.addTarget(self, action: #selector(edit_prodPriority(sender:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table_pp.deselectRow(at: indexPath, animated: true)
      
    }
}

extension SS_ProdPlan_ViewController: updateProductionPlanDelegate{
    
    func listOfProductionPlan(ary_production_: [ProductionView]) {
        SS_Utility.stopIndicator(vc: self)
        /*guard let pri_1 = ary_production_[0].priority, let pri_2 = ary_production_[1].priority else {
            return
        }*/
        ary_dicResponse = ary_production_.sorted(by: { Int($0.priority ?? "-1")! < Int($1.priority ?? "-1")! })
        if(ary_dicResponse.count == 0){
            lbl_nodata.isHidden = false
            table_pp.isHidden = true
        }else{
            lbl_nodata.isHidden = true
            table_pp.isHidden = false
            table_pp.reloadData()
        }
        
    }
    
    func errorInProductionList(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in 
        }
    }
}

extension SS_ProdPlan_ViewController: ProdPlanPartNumDelegate {
    func successResponse(dic_response: SSProdPlanPartNum) {
        SS_Utility.stopIndicator(vc: self)
        pppNo = dic_response
        ary_prtNo.removeAll()
        
        if pppNo.message!.count > 1 {
            ary_prtNo.append("ALL")
        }
        
        for item_ in pppNo.message! {
            ary_prtNo.append("\(SS_Utility.checkForDicNullValues(item_val: item_.partNo! + "_" + item_.mixerModel!))")
        }
        
    }
    
    func errorResponseProdPlanPrtNo(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
    
}

