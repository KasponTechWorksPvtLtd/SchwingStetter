//
//  SS_CNCApprove_ViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 19/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_CNCApprove_ViewController: UIViewController {
    
    
    @IBOutlet weak var table_cncAppr: UITableView!
    var ary_cnc_dicRes: CNCSegment! //[[String: Any]]()
    @IBOutlet weak var lbl_nodata: UILabel!
 @IBOutlet weak var constr_headerView_hei: NSLayoutConstraint!
    @IBOutlet weak var txt_prtNum: UITextField!
    let cncController = SS_CNCApprove_Controller()
    var ary_prtNo = [String]()
 let dropDownView = SS_Dropdown_ViewController()
    @IBOutlet weak var view_bg: UIView!
    var partNoObj: CNCPartNum!
    var partNo_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.table_cncAppr.estimatedRowHeight = 100
        self.table_cncAppr.rowHeight = UITableViewAutomaticDimension
        self.table_cncAppr.tableFooterView = UIView()
        
        /*ary_cnc_dicRes.append([Keys_val.share.date_: "23/09/2018", Keys_val.share.empID: "421", Keys_val.share.rmPartNum: "80177565"])
        ary_cnc_dicRes.append([Keys_val.share.date_: "23/09/2018", Keys_val.share.empID: "425", Keys_val.share.rmPartNum: "80155665"])
        ary_cnc_dicRes.append([Keys_val.share.date_: "23/09/2018", Keys_val.share.empID: "428", Keys_val.share.rmPartNum: "80122455"])*/
        constr_headerView_hei.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
        getCNCPNum()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func getCNCPNum() {
        SS_Utility.showIndicator(vc: self)
        cncController.delegate_CNCPartNo = self
        cncController.getCNCPartNumber()
    }
    
    //MARK:- ButtonAction
    
    @IBAction func homeBtnClicked(){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func searchCNCApprovalList(sender: UIButton){
        SS_Utility.showIndicator(vc: self)
        cncController.delegate_CNC = self
        cncController.getCNCApprovalList(partNo_Id_: partNo_id)
        
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

extension SS_CNCApprove_ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let val = ary_cnc_dicRes{
              return val.message!.count //3
        }else{
            return 0
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_cncAppr.dequeueReusableCell(withIdentifier: Cell_Identifier.cell_cncApprove.rawValue) as! SS_CNCApproveCell
        let dic = ary_cnc_dicRes.message![indexPath.row]
        
        cell.lbl_date.text = dic.createdAt //dic[Keys_val.share.date_] as? String
        cell.lbl_empID.text = "\(dic.userid!)" //[Keys_val.share.empID] as? String
        cell.lbl_rmPartNum.text = "\(dic.rawPartno!)"  //(dic[Keys_val.share.rmPartNum] as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.CNCAPPROVALEDITVC.rawValue) as! SS_EditCNCAppr_ViewController
        vc.dic_message = ary_cnc_dicRes.message![indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension SS_CNCApprove_ViewController: CNCPartNoDelegate{
    func successResponse(dic_response: CNCPartNum) {
        SS_Utility.stopIndicator(vc: self)

        if dic_response.message!.count  > 0 {
            partNoObj = dic_response
            ary_prtNo = dic_response.message!.map({ $0.rawPartno! })
            ary_prtNo.insert("ALL", at: 0)
        }
    }
    
    func errorResponse_cncPrtNo(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}

extension SS_CNCApprove_ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dropDownView.removeDropdownFromSuperView(vc: self)
        
        switch textField {
        
        case txt_prtNum:
            textField.resignFirstResponder()
            dropDownView.addDropdownView(selectedView: txt_prtNum, ary_data: ary_prtNo, customView: view_bg, mainView: self.view, vc: self)
            
        default:
            break
        }
        
    }
}

extension SS_CNCApprove_ViewController: DropdownDelegate{
    func selectedIndexWithItem(index: Int, item: String, tagVal: Int) {
        txt_prtNum.text = item
        partNo_id = index == 0 ? "ALL" : "\(partNoObj.message![index].id!)"
        dropDownView.removeDropdownFromSuperView(vc: self)

    }
    
    
}

extension SS_CNCApprove_ViewController: CNCApproveDelegate {
  
    func successResponse(dic_response: CNCSegment) {
        SS_Utility.stopIndicator(vc: self)
        ary_cnc_dicRes = dic_response
        
        guard (ary_cnc_dicRes != nil) else{
            return
        }
        if (ary_cnc_dicRes.message?.count != 0) {
            lbl_nodata.isHidden = true
            table_cncAppr.isHidden = false
            table_cncAppr.reloadData()

        }else{
            lbl_nodata.isHidden = false
            table_cncAppr.isHidden = true
        }
    }
    
    func errorResponse_cncList(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}
