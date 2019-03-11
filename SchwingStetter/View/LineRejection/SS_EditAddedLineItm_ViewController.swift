//
//  SS_EditAddedLineItm_ViewController.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 29/12/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_EditAddedLineItm_ViewController: UIViewController {

    
    @IBOutlet weak var constr_headerView_hei_: NSLayoutConstraint!
    @IBOutlet weak var txt_prtNo: UITextField!
    @IBOutlet weak var txt_desc: UITextField!
    @IBOutlet weak var txt_qty: UITextField!
    @IBOutlet weak var txt_comts: UITextField!
    var addLineRej_controller = SS_AddNewItem_Controller()
    var lr_partDesc: LR_PartDescript!
    var lr_selectedItem: Message_AddedLineItemList!
    var controller_addNewItem = SS_AddNewItem_Controller()
    
    var mrtTyp_ID = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        constr_headerView_hei_.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
        controller_addNewItem.delegate_lrUpdateEditedItems = self
        loadBasicDetials()
    }
    
    //MARK:- self methods
    func loadBasicDetials() {
        txt_prtNo.text = "\(SS_Utility.checkForDicNullValues(item_val: lr_selectedItem.partNo as Any))"
        txt_desc.text = "\(SS_Utility.checkForDicNullValues(item_val: lr_selectedItem.description as Any))"
        txt_qty.text = "\(SS_Utility.checkForDicNullValues(item_val: lr_selectedItem.quantity as Any))"
        txt_comts.text = "\(SS_Utility.checkForDicNullValues(item_val: lr_selectedItem.comments as Any))"
    }
    
    //MARK:- Check Part Number
    @IBAction func backToVC(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkEnteredPrtNum(sender: UIButton){
        SS_Utility.showIndicator(vc: self)
        addLineRej_controller.delegate_lrPartDescrip = self
        addLineRej_controller.getPartDescript(partNum: Int(txt_prtNo.text!)!, mtrTypeId: mrtTyp_ID)
    }
    
    @IBAction func updateSelectedItem(sender: UIButton){
        SS_Utility.showIndicator(vc: self)
        controller_addNewItem.updateEditedItem(dic_val: [Keys_val.id_.rawValue: lr_selectedItem.id!, Keys_val.lr_prtNum.rawValue: txt_prtNo.text!, Keys_val.lr_wo_Num.rawValue: lr_selectedItem.workorderNo!,  Keys_val.description.rawValue: txt_desc.text!, Keys_val.quantity.rawValue: txt_qty.text!, Keys_val.comments.rawValue: txt_comts.text!])
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


extension SS_EditAddedLineItm_ViewController: LR_PartDescripDelegate{
    func successResponse(dic_response: LR_PartDescript) {
        SS_Utility.stopIndicator(vc: self)
        lr_partDesc = dic_response
        if (lr_partDesc.message?.count != 0) {
            txt_desc.text = lr_partDesc.message![0].description!
        }else{
            txt_desc.text = ""
        }
    }
    
    func errorResponse_partDescrip(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}

extension SS_EditAddedLineItm_ViewController: LR_UpdateEditedLineItemDlegate{
    func successResponse(dic_response: LR_UpdateEditedItem) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: dic_response.message!, alertType: 0){_ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func errorResponse_lrUpdate(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
    
}

