//
//  SS_EditCNCAppr_ViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 19/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_EditCNCAppr_ViewController: UIViewController {

    
    @IBOutlet weak var table_editCncAppr: UITableView!
     @IBOutlet weak var constr_headerView_hei: NSLayoutConstraint!
    
    var ary_editCnc_dicRes: CNCSegmentDetails! // = [[String: Any]]()
    var dic_message: Message!
    var ary_secData = [String]()
     let cncController = SS_CNCApprove_Controller()
   // var bg: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //assert(bg != UIBackgroundTaskInvalid)
        // Do any additional setup after loading the view.
        
        ary_secData = ["Model", "Segment Qty", "Category", "Weight"]
        
        /*ary_editCnc_dicRes.append([Keys_val.share.drumModel : "6C2", Keys_val.share.segmentQty: "1", Keys_val.share.coneCateg: "CONE2", Keys_val.share.seg_weight: "22.0"])
        ary_editCnc_dicRes.append([Keys_val.share.drumModel : "SLM2", Keys_val.share.segmentQty: "2", Keys_val.share.coneCateg: "CONE2", Keys_val.share.seg_weight: "24.0"])
        ary_editCnc_dicRes.append([Keys_val.share.drumModel : "3M3", Keys_val.share.segmentQty: "1", Keys_val.share.coneCateg: "CONE2", Keys_val.share.seg_weight: "30.0"])*/
       
        constr_headerView_hei.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
        
        
        cncController.delegate_CNCSelectedList = self
        cncController.delegate_CNCSegSubmit = self
        
        cncController.getSelectedCNCApproveDetails(rwPartNum: "\(dic_message.alternateUniqueValue!)")
        
    }
    
    //MARK:- Selector Action
    @objc func acceptClicked() {
        guard (dic_message.id != nil) else {
            return
        }
        
        SS_Utility.showAlertWithTextField(str_title: "Alert", str_msg: "Kindly select the number of raw material plates", alertType: 0, tagVal: 0, vc: self, completion: {
            if($0 == true && !$1.isEmpty){
                self.cncController.approveSelectedCNCSegment(numOfPrts: Int($1)!, alternateUniqueId: self.dic_message.alternateUniqueValue!, status: 0)
                
              //  self.cncController.approveSelectedCNCSegment(numOfPrts: Int($1)!, prtNumID: Int(self.dic_message.partNo!)!, usrId: self.dic_message.userid!, created: self.dic_message.createdAt!, status: 0)//id!
            }
        })
        
        
        //self.cncController.approveSelectedCNCSegment(prtNumID: self.dic_message.id!, status: 0)
    }
    
    @objc func rejectedClicked() {
        //self.dismiss(animated: true, completion: nil)
        SS_Utility.showAlert(str_title: "Alert", str_msg: "Click ok to reject", alertType: 0){_ in
           // self.cncController.approveSelectedCNCSegment(numOfPrts: 0, prtNumID: self.dic_message.id!, usrId: self.dic_message.userid!, created: self.dic_message.createdAt!, status: 1)
            self.cncController.approveSelectedCNCSegment(numOfPrts: 0, alternateUniqueId: self.dic_message.alternateUniqueValue!, status: 1)
        }
    }

    
    //MARK:- Button Action
    @IBAction func backBtnClicked(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
        
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

extension SS_EditCNCAppr_ViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        let count = text.count + string.count - range.length
        print("textCount:- \(count)")
        return count <= 3
    }
}

extension SS_EditCNCAppr_ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let float_tableWidth = table_editCncAppr.frame.size.width
        let vw = UIView() //frame: CGRect(x: 0, y: 0, width: float_tableWidth, height: 30)
        //vw.backgroundColor = UIColor.red
        
        let lbl_drum = UILabel(frame: CGRect(x: 0, y: 0, width: float_tableWidth/4, height: 21))
        lbl_drum.font = UIFont.systemFont(ofSize: 15)
        lbl_drum.textAlignment = .center
        lbl_drum.text = ary_secData[0]
        
        let lbl_seg = UILabel(frame: CGRect(x: lbl_drum.frame.size.width, y: 0, width: float_tableWidth/4, height: 37))
        lbl_seg.numberOfLines = 0
        lbl_seg.font = UIFont.systemFont(ofSize: 15)
        lbl_seg.textAlignment = .center
        lbl_seg.text = ary_secData[1]
        
        let lbl_coneSeg = UILabel(frame: CGRect(x: (lbl_seg.frame.origin.x + float_tableWidth/4), y: 0, width: float_tableWidth/4, height: 21))
        lbl_coneSeg.font = UIFont.systemFont(ofSize: 15)
        lbl_coneSeg.textAlignment = .center
        lbl_coneSeg.text = ary_secData[2]
        
        let lbl_segWeight = UILabel(frame: CGRect(x: (lbl_coneSeg.frame.origin.x + float_tableWidth/4), y: 0, width: float_tableWidth/4, height: 21))
        lbl_segWeight.font = UIFont.systemFont(ofSize: 15)
        lbl_segWeight.textAlignment = .center
        lbl_segWeight.text = ary_secData[3]
        
//        var aru_subViews = [UIView]()
//        aru_subViews = [lbl_drum, lbl_seg, lbl_coneSeg]
        
       /* let conts_hei = NSLayoutConstraint(item: lbl_drum, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
        let conts_width = NSLayoutConstraint(item: lbl_drum, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)

        
        view.addConstraints([conts_hei, conts_width])*/
        
//        NSLayoutConstraint(item: vw, attribute: .trailing, relatedBy: .equal, toItem: table_editCncAppr, attribute: .trailing, multiplier: 1, constant: 10).isActive = true
//
//        NSLayoutConstraint(item: vw, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
//
//        NSLayoutConstraint(item: vw, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
//
//        NSLayoutConstraint(item: vw, attribute: .height, relatedBy: .equal, toItem: view, attribute: .notAnAttribute, multiplier: 1, constant: 131).isActive = true
        
        vw.addSubview(lbl_drum)
        vw.addSubview(lbl_seg)
        vw.addSubview(lbl_coneSeg)
        vw.addSubview(lbl_segWeight)

        //lbl_drum.translatesAutoresizingMaskIntoConstraints = false
//
//        vw.addConstraint(NSLayoutConstraint(item: lbl_drum, attribute: .leading, relatedBy: .equal, toItem: vw, attribute: .leading, multiplier: 1, constant: 0))
//        vw.addConstraint(NSLayoutConstraint(item: lbl_drum, attribute: .trailing, relatedBy: .equal, toItem: lbl_seg, attribute: .leading, multiplier: 1, constant: 0))
//        vw.addConstraint(NSLayoutConstraint(item: lbl_drum, attribute: .width, relatedBy: .equal, toItem: vw, attribute: .leading, multiplier: 1, constant: 0))
//        vw.addConstraint(NSLayoutConstraint(item: lbl_drum, attribute: .height, relatedBy: .equal, toItem: vw, attribute: .leading, multiplier: 1, constant: 0))
        
//        vw.addConstraint(NSLayoutConstraint(item: lbl_segWeight, attribute: .leading, relatedBy: .equal, toItem: vw, attribute: .trailing, multiplier: 1, constant: 0))
//        vw.addConstraint(NSLayoutConstraint(item: lbl_segWeight, attribute: .trailing, relatedBy: .equal, toItem: lbl_coneSeg, attribute: .trailing, multiplier: 1, constant: 0))
//        vw.addConstraint(NSLayoutConstraint(item: lbl_segWeight, attribute: .width, relatedBy: .equal, toItem: vw, attribute: .trailing, multiplier: 1, constant: 0))
//        vw.addConstraint(NSLayoutConstraint(item: lbl_segWeight, attribute: .height, relatedBy: .equal, toItem: vw, attribute: .trailing, multiplier: 1, constant: 0))
        
        
        
        
        
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  (ary_editCnc_dicRes.message!.mixerdata?.count)! <= indexPath.row ? 230 :  75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ary_editCnc_dicRes != nil) ? (ary_editCnc_dicRes.message!.mixerdata?.count)! + 1 : 0
        //return ary_editCnc_dicRes.message!.count + 1 //3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdent = (ary_editCnc_dicRes.message!.mixerdata?.count)! <= indexPath.row ? Cell_Identifier.cell_editCncApprove_1.rawValue : Cell_Identifier.cell_editCncApprove.rawValue
        print("cellIdent:- \(cellIdent) indexp:- \(indexPath.row) cnt:- \((ary_editCnc_dicRes.message!.mixerdata?.count)! <= indexPath.row)")
        let cell = table_editCncAppr.dequeueReusableCell(withIdentifier: cellIdent) as! SS_EditCNCApproveCell
        
        if(cellIdent ==  Cell_Identifier.cell_editCncApprove.rawValue){
            let dic = ary_editCnc_dicRes.message!.mixerdata![indexPath.row]

            cell.lbl_drumModel.text = "\(SS_Utility.checkForDicNullValues(item_val: dic.drumModel as Any))"
            cell.lbl_segmentQty.text = "\(SS_Utility.checkForDicNullValues(item_val: dic.noOfPlateSegment as Any))"
            cell.lbl_coneCateg.text = "\(SS_Utility.checkForDicNullValues(item_val: dic.drumModel as Any))"
            cell.lbl_segWt.text = "\(SS_Utility.checkForDicNullValues(item_val: dic.wtPerSegment as Any))"

        }else{
            let dic = ary_editCnc_dicRes.message!
            cell.lbl_segWeight.text = "\(SS_Utility.checkForDicNullValues(item_val: dic.totalSegmentWeight as Any))"
            cell.lbl_rmWeight.text = "\(SS_Utility.checkForDicNullValues(item_val: dic.rmWeight as Any))"
            cell.lbl_scrap.text = "\(SS_Utility.checkForDicNullValues(item_val: dic.scrapPercentage as Any))"
            
            cell.btn_accept.addTarget(self, action: #selector(acceptClicked), for: .touchUpInside)
            cell.btn_reject.addTarget(self, action: #selector(rejectedClicked), for: .touchUpInside)
        }
        
        
        return cell
    }
    
    
}

extension SS_EditCNCAppr_ViewController: CNCApproveDetailsDelegate{
    
    func successResponse(dic_response: CNCSegmentDetails) {
        ary_editCnc_dicRes = dic_response
        table_editCncAppr.reloadData()
    }
    
    func errorResponse_cncDetails(error_: String) {
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}

extension SS_EditCNCAppr_ViewController: CNCSegmentSubmitDelegate{
    func successResponse(dic_response: CNCSegmentSubmit) {
        if dic_response.code == 201 {
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Successfully updated", alertType: 0){_ in
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Not updated", alertType: 0){_ in
                self.dismiss(animated: true, completion: nil)

            }
        }
    }
    
    func errorResponse_cncSubmit(error_: String) {
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0){_ in
        }
    }
}
