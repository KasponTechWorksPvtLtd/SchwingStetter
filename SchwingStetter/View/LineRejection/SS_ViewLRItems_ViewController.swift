//
//  SS_ViewLRItems_ViewController.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 21/12/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_ViewLRItems_ViewController: UIViewController {

    
    @IBOutlet weak var table_viewLRI: UITableView!
    @IBOutlet weak var constr_headerView_hei_: NSLayoutConstraint!
    let controller_addNewItems = SS_AddNewItem_Controller()
    var lr_addedItmList: LR_AddItemsList!
    var lr_itemList: Message_LR_ListItems!
    var mrtTypID_ = 0
    var qcStauts = 0
    let font_ = UIFont.systemFont(ofSize: 14)

    @IBOutlet weak var lbl_nodata: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        constr_headerView_hei_.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
        controller_addNewItems.delegate_lrAddedItmList = self
        controller_addNewItems.delegate_lrDeleteItems = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        controller_addNewItems.getLineRejectionAddedItemsList(dicVal: lr_itemList)

    }
    //MARK:- ButtonACtion
    @IBAction func backToPreviousView(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- Selector Methods
    @objc func editSelectedItems(sender: UIButton)  {
        let vc = storyboard?.instantiateViewController(withIdentifier:  SB_Identifier.EDITADDEDLINEITEMVC.rawValue) as! SS_EditAddedLineItm_ViewController
        vc.mrtTyp_ID = mrtTypID_
        vc.lr_selectedItem = lr_addedItmList.message![sender.tag]
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func deleteSelectedItems(sender: UIButton) {
        SS_Utility.showAlert(str_title: "Alert", str_msg: "Are you sure, you want to delete this item.", alertType: 1, completion: {res in
            if(res == true){
                SS_Utility.showIndicator(vc: self)
                self.controller_addNewItems.deleteAddLineItems(id_: self.lr_addedItmList.message![sender.tag].id!)
            }
        })
        
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

extension SS_ViewLRItems_ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dic_val = lr_addedItmList.message![indexPath.row]
        
        return 160 + SS_Utility.heightForView(text: "\(SS_Utility.checkForDicNullValues(item_val: dic_val.description as Any))", font: font_, width:211)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (lr_addedItmList != nil) ? lr_addedItmList.message!.count : 0 //1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_viewLRI.dequeueReusableCell(withIdentifier: Cell_Identifier.cell_viewLRI.rawValue) as! SS_ViewLRItemCell
        
        let dic_val = lr_addedItmList.message![indexPath.row]
        
        cell.lbl_partNo.text = "\(SS_Utility.checkForDicNullValues(item_val: dic_val.partNo as Any))"
        cell.lbl_descr.text = "\(SS_Utility.checkForDicNullValues(item_val: dic_val.description as Any))"
        cell.lbl_qty.text = "\(SS_Utility.checkForDicNullValues(item_val: dic_val.quantity as Any))"
        cell.lbl_cmts.text = "\(SS_Utility.checkForDicNullValues(item_val: dic_val.comments as Any))"
        
        cell.contrait_lbl_height.constant = SS_Utility.heightForView(text: "\(SS_Utility.checkForDicNullValues(item_val: dic_val.description as Any))", font: font_, width: cell.lbl_descr.frame.width)
        cell.contrait_bgView_height.constant += cell.contrait_lbl_height.constant
        
        cell.btn_edit.isHidden = qcStauts == 1 ? true : false
        cell.btn_edit.tag = indexPath.row
        cell.btn_edit.addTarget(self, action: #selector(editSelectedItems(sender:)), for: .touchUpInside)
        
        cell.btn_delete.isHidden = qcStauts == 1 ? true : false
        cell.btn_delete.tag = indexPath.row
        cell.btn_delete.addTarget(self, action: #selector(deleteSelectedItems(sender:)), for: .touchUpInside)
        
        return cell
    }
}


extension SS_ViewLRItems_ViewController: LR_LineRejectAddedItemsListDelegate{
    func successResponse(dic_response: LR_AddItemsList) {
        SS_Utility.stopIndicator(vc: self)
        lr_addedItmList = dic_response
        
        if (lr_addedItmList.message!.count != 0) {
            table_viewLRI.isHidden = false
            lbl_nodata.isHidden = true
            table_viewLRI.reloadData()
            
        }else{
            table_viewLRI.isHidden = true
            lbl_nodata.isHidden = false
        }
        
    }
    
    
    func errorResponse_lrAddedItemList(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
    
    
}


extension SS_ViewLRItems_ViewController: LR_DeleteAddedItems{
    func successResponse(dic_response: KPT_DeleteAddedItem) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: dic_response.message!, alertType: 0){_ in
            self.controller_addNewItems.getLineRejectionAddedItemsList(dicVal: self.lr_itemList)
        }
    }
    
    func errorResponse_lrDeleteAddItems(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
    
    
}
