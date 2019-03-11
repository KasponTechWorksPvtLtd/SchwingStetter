//
//  SS_AddNewItem_Controller.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 20/12/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

protocol DoneBtnClickedDelegate: AnyObject {
    func doneBtnClicked()
}

protocol LR_PartDescripDelegate {
    func successResponse(dic_response: LR_PartDescript)
    func errorResponse_partDescrip(error_: String)
}

protocol LR_AddItemsSubmitDelegate {
    func successResponse(dic_response: LR_AddItemsResult)
    func errorResponse_lrItems(error_: String)
}

protocol LR_LineRejectAddedItemsListDelegate {
    func successResponse(dic_response: LR_AddItemsList)
    func errorResponse_lrAddedItemList(error_: String)
    
}

protocol LR_UpdateEditedLineItemDlegate {
    func successResponse(dic_response: LR_UpdateEditedItem)
    func errorResponse_lrUpdate(error_: String)
}

protocol LR_UpdateLineRejDlegate {
    func successResponse(dic_response: LR_UpdateLineReject)
    func errorResponse_lrUpdateLRej(error_: String)
}

protocol LR_DeleteAddedItems {
    func successResponse(dic_response: KPT_DeleteAddedItem)
    func errorResponse_lrDeleteAddItems(error_: String)
}



class SS_AddNewItem_Controller: UIViewController {
    weak var delegate_doneBtn: DoneBtnClickedDelegate!
    var delegate_lrPartDescrip: LR_PartDescripDelegate!
    var delegate_lrAddItmSubmi: LR_AddItemsSubmitDelegate!
    var delegate_lrAddedItmList: LR_LineRejectAddedItemsListDelegate!
    var delegate_lrUpdateEditedItems: LR_UpdateEditedLineItemDlegate!
    var delegate_lrUpdateLineRej: LR_UpdateLineRejDlegate!
    var delegate_lrDeleteItems: LR_DeleteAddedItems!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func getPartDescript(partNum: Int, mtrTypeId: Int) {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_partDescrip.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.lr_partDescr.rawValue, Keys_val.id_.rawValue: partNum, Keys_val.lr_issFor.rawValue: mtrTypeId]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let lr_partDesObj = try decoder_.decode(LR_PartDescript.self, from: jsonData)
                    self.delegate_lrPartDescrip?.successResponse(dic_response: lr_partDesObj)
                }catch let err_ {
                    self.delegate_lrPartDescrip?.errorResponse_partDescrip(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrPartDescrip?.errorResponse_partDescrip(error_: "Try again later")
            }
            
        }
    }
    
    //MARK:- Submit Add lint items
    func submiteLRAddItems(ary_lrItems: [[String: Any]], dic_partNum: [String: Any]) {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_addItems.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.lr_addItems.rawValue, Keys_val.lr_add_mrtIssFor.rawValue: dic_partNum[Keys_val.lr_add_mrtIssFor.rawValue]!, Keys_val.lr_add_woNum.rawValue: dic_partNum[Keys_val.lr_add_woNum.rawValue]!, Keys_val.lr_add_wrkStation.rawValue: dic_partNum[Keys_val.lr_add_wrkStation.rawValue]!, Keys_val.partno.rawValue: dic_partNum[Keys_val.partno.rawValue]!, Keys_val.lr_reqBy.rawValue: SingleTone.share.login.data![0].userid!, Keys_val.lr_addNew_itemDetails.rawValue: ary_lrItems]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let lr_submObj = try decoder_.decode(LR_AddItemsResult.self, from: jsonData)
                    self.delegate_lrAddItmSubmi?.successResponse(dic_response: lr_submObj)

                }catch let err_ {
                    self.delegate_lrAddItmSubmi?.errorResponse_lrItems(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrAddItmSubmi?.errorResponse_lrItems(error_: "Try again later")
            }
        }
    }
    
    //MARK:- Get Add Line Rejection Items
    
    func getLineRejectionAddedItemsList(dicVal: Message_LR_ListItems) {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_addItemsList.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.lr_getitmList.rawValue, Keys_val.id_.rawValue:  dicVal.id!]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let lrItemLstObj = try decoder_.decode(LR_AddItemsList.self, from: jsonData)
                    self.delegate_lrAddedItmList?.successResponse(dic_response: lrItemLstObj)
                }catch let err_ {
                    self.delegate_lrAddedItmList?.errorResponse_lrAddedItemList(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrAddedItmList?.errorResponse_lrAddedItemList(error_: "Try again later")
            }
            
        }
    }
    
    func updateEditedItem(dic_val: [String: Any]) {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_updateEditedItems.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.edit.rawValue, Keys_val.id_.rawValue: dic_val[Keys_val.id_.rawValue]!, Keys_val.partno.rawValue: dic_val[Keys_val.lr_prtNum.rawValue]!, Keys_val.lr_wo_Num.rawValue: dic_val[Keys_val.lr_wo_Num.rawValue]! , Keys_val.description.rawValue: dic_val[Keys_val.description.rawValue]! , Keys_val.quantity.rawValue: dic_val[Keys_val.quantity.rawValue]!,  Keys_val.comments.rawValue: dic_val[Keys_val.comments.rawValue]!  ]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let lrupdatedObj = try decoder_.decode(LR_UpdateEditedItem.self, from: jsonData)
                    self.delegate_lrUpdateEditedItems?.successResponse(dic_response: lrupdatedObj)
                }catch let err_ {
                    self.delegate_lrUpdateEditedItems?.errorResponse_lrUpdate(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrUpdateEditedItems?.errorResponse_lrUpdate(error_: "Try again later")
            }
            
        }
    }
    
    
    func updateLineRejection(dic_val: [String: Any]) {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_updateLineRej.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.lr_updateLineRej.rawValue, Keys_val.id_.rawValue: dic_val[Keys_val.id_.rawValue]!, Keys_val.partno.rawValue: dic_val[Keys_val.lr_add_partno.rawValue]!, Keys_val.lr_wo_Num.rawValue: dic_val[Keys_val.lr_wo_Num.rawValue]! , Keys_val.lr_add_wrkStation.rawValue: dic_val[Keys_val.lr_add_wrkStation.rawValue]!  ]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let lrupdatedLRObj = try decoder_.decode(LR_UpdateLineReject.self, from: jsonData)
                    self.delegate_lrUpdateLineRej?.successResponse(dic_response: lrupdatedLRObj)
                }catch let err_ {
                    self.delegate_lrUpdateLineRej?.errorResponse_lrUpdateLRej(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrUpdateLineRej?.errorResponse_lrUpdateLRej(error_: "Try again later")
            }
            
        }
    }
    
    //MARK:- Deletion of Added Line Items
    func deleteAddLineItems(id_: Int) {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_delete.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.lr_deleteItems.rawValue, Keys_val.id_.rawValue: id_]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let lrDeleAddedItemsObj = try decoder_.decode(KPT_DeleteAddedItem.self, from: jsonData)
                    self.delegate_lrDeleteItems?.successResponse(dic_response: lrDeleAddedItemsObj)
                }catch let err_ {
                    self.delegate_lrDeleteItems?.errorResponse_lrDeleteAddItems(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrDeleteItems?.errorResponse_lrDeleteAddItems(error_: "Try again later")
            }
            
        }
    }
    
    
    func fetchIdsOfJsonObjects(jsonObj: Any, str_name: String) -> Int {
        //print("fetchID:- \(jsonObj) \n \(str_name)")
        if let obj = jsonObj as? MIA_MaterialTypes{
            return Int((obj.message!.first(where: {$0.name! == str_name})?.id)!)!
            
        }else if let obj = jsonObj as? MIA_Drum_ParNum {
            return Int((obj.message!.first(where: {$0.drumpartNo! == str_name})?.id)!)

        }else if let obj = jsonObj as? MIA_Mixer_PartNum {
            return Int((obj.message!.first(where: {$0.partNo == str_name})?.id)!)

        }else if let obj = jsonObj as? LR_WorkOrdNum {
            return Int((obj.message!.first(where: {$0.workorderNo == Int(str_name)})?.id)!)

        }else if let obj = jsonObj as? LR_WorkStation {
            return Int((obj.message!.first(where: {$0.operationCode == str_name})?.id)!)
            
        }
        return 0
    }
    @objc func addDoneButtonOnKeyboard(txt_feld: UITextField)
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = (items as! [UIBarButtonItem])
        doneToolbar.sizeToFit()
        
        txt_feld.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        //txt_feld_.resignFirstResponder()
        delegate_doneBtn.doneBtnClicked()
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

class SS_AddNewItemCell: UITableViewCell {
    @IBOutlet weak var btn_check: UIButton!
    @IBOutlet weak var btn_desc: UIButton!
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var txt_prtNum: UITextField!
    @IBOutlet weak var txt_desc: UITextField!
    @IBOutlet weak var txt_qty: UITextField!
    @IBOutlet weak var txt_comments: UITextField!
    
}

class SS_ViewLRItemCell: UITableViewCell {
    @IBOutlet weak var lbl_partNo: UILabel!
    @IBOutlet weak var lbl_descr: UILabel!
    @IBOutlet weak var lbl_qty: UILabel!
    @IBOutlet weak var lbl_cmts: UILabel!
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var contrait_lbl_height: NSLayoutConstraint!
    @IBOutlet weak var contrait_bgView_height: NSLayoutConstraint!

    
}

