 //
//  SS_Edit_PP_ViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 16/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_Edit_PP_ViewController: UIViewController {

    var dic_select: [String: Any]?
    var ary_pickerdata = [String]()
    
    @IBOutlet weak var lbl_WON: UITextField!
    @IBOutlet weak var lbl_MAV: UITextField!
    @IBOutlet weak var lbl_PNO: UITextField!
    @IBOutlet weak var lbl_Priority: UITextField!
    @IBOutlet weak var lbl_PShedule: UITextField!
     @IBOutlet weak var constr_headerView_hei: NSLayoutConstraint!
    
    var ary_editProdu: ProductionView!
     var planController = SS_ProdPlan_Controller()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lbl_WON.text = "\(SS_Utility.checkForDicNullValues(item_val: ary_editProdu.workorderNo as Any))"
        lbl_MAV.text = "\(SS_Utility.checkForDicNullValues(item_val: ary_editProdu.mixerModelno as Any))"
        lbl_PNO.text = "\(SS_Utility.checkForDicNullValues(item_val: ary_editProdu.partNo as Any))"
        lbl_Priority.text = "\(SS_Utility.checkForDicNullValues(item_val: ary_editProdu.priority as Any))"
        lbl_PShedule.text = "\(SS_Utility.checkForDicNullValues(item_val: ary_editProdu.planSchedule as Any))"
        
        constr_headerView_hei.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
        
        planController.delegate_edit = self
        loadPickerView()
    }
    
    
    func loadPickerView(){
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(dismissPicker), tag_: 0)
        lbl_Priority.inputAccessoryView = toolBar
        
        let picker_cust = UIPickerView()
        picker_cust.delegate = self
        lbl_Priority.inputView = picker_cust
    }

    
    //MARK:- Button ACtion
    @IBAction func update(){
        if let str_priority = lbl_Priority.text {
            planController.updateEditedProductionView(str_priority: str_priority, dic_product: ary_editProdu)
        }else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Priority should not be empty", alertType: 0) {_ in
            }
        }
    }
    
    
    @IBAction func backBtnClicked(){
        self.dismiss(animated: true, completion: nil)
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

extension SS_Edit_PP_ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ary_pickerdata.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ary_pickerdata[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lbl_Priority.text = ary_pickerdata[row]
    }
    
    
}

extension SS_Edit_PP_ViewController: EditProductionPlanDelegate{
    
    func successResponse(dic_response: EditProductionView) {
        SS_Utility.showAlert(str_title: "Alert", str_msg: dic_response.message!, alertType: 0, completion: {
            if($0 == true){
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    func errorResponse(error_: String) {
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
            
        }
    }
    
    
}
