//
//  SS_LineRejection_Controller.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 20/12/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

protocol LR_MaterialIssForDelegate {
    func successResponse(dic_response: MIA_MaterialTypes)
    func errorResponse_matIssFor(error_: String)
}

protocol LR_DrumPartNumDelegate: AnyObject {
    func successResponse(dic_response: MIA_Drum_ParNum)
    func errorResponse_drumPartNum(error_: String)
}

protocol LR_WorkOrdNumDelegate: AnyObject {
    func successResponse(dic_response: LR_WorkOrdNum)
    func errorResponse_workOrdNum(error_: String)
}

protocol LR_MixerPartNumDelegate: AnyObject {
    func successResponse(dic_response: MIA_Mixer_PartNum)
    func errorResponse_mixerPartNum(error_: String)
}

protocol LR_WorkStationDelegate: AnyObject {
    func successResponse(dic_response: LR_WorkStation)
    func errorResponse_lrWrkSta(error_: String)
}


protocol LR_ListItemsDelegate {
    func successResponse(dic_response: LR_ListItems)
    func errorResponse_lineRejItem(error_: String)
}

protocol LR_DeleteListDelegate {
    func successResponse(dic_response: KPT_DeleteList)
    func errorResponse_deleteList(error_: String)
}

class SS_LineRejection_Controller: UIViewController {

    var delegate_lrMtrIssFor: LR_MaterialIssForDelegate!
    var delegate_lrDrum_partNo: LR_DrumPartNumDelegate!
    var delegate_lrWorkOrdNum: LR_WorkOrdNumDelegate!
    var delegate_lrMixer_partNo: LR_MixerPartNumDelegate!
    var delegate_lrWrkSta: LR_WorkStationDelegate!
    var delegate_lrListItems: LR_ListItemsDelegate!
    var delegate_lrDeleteList: LR_DeleteListDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- Add Item Validation
    
    func isValidTextField(txt1_: UITextField, txt2_: UITextField, txt3_: UITextField, txt4_: UITextField, mrtTypId_: Int) -> Bool {
        //if(!(txt_mtrIssuFor.text != "") && !(txt_part.text != "") && !(txt_wonum.text != "") && !(txt_workStation.text != ""))
        switch mrtTypId_ {
        case 1, 2:
            return !(txt1_.text?.isEmpty)! && !(txt2_.text?.isEmpty)! && !(txt3_.text?.isEmpty)! && !(txt4_.text?.isEmpty)!
        case 3:
            return !(txt1_.text?.isEmpty)! && !(txt2_.text?.isEmpty)! && !(txt3_.text?.isEmpty)!
        default:
            return false
        }
    }
    //MARK:- To Get Material Types
    func showMaterialIssueFor()  {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_materialIssFor.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.mia_sc_matIssFor.rawValue ]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let matTypeObj = try decoder_.decode(MIA_MaterialTypes.self, from: jsonData)
                    self.delegate_lrMtrIssFor?.successResponse(dic_response: matTypeObj)
                }catch let err_ {
                    self.delegate_lrMtrIssFor?.errorResponse_matIssFor(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrMtrIssFor?.errorResponse_matIssFor(error_: "Try again later")
            }

        }
    }
   
    //MARK:- To Get Drum Part Number
    func getDrumPartNumber(mtrIssType_id: Int)  {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_drumPartNo.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.mia_sc_getmixervalue.rawValue, Keys_val.id_.rawValue: mtrIssType_id ]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let matTypeObj = try decoder_.decode(MIA_Drum_ParNum.self, from: jsonData)
                    self.delegate_lrDrum_partNo?.successResponse(dic_response: matTypeObj)
                }catch let err_ {
                    self.delegate_lrDrum_partNo?.errorResponse_drumPartNum(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrDrum_partNo?.errorResponse_drumPartNum(error_: "Try again later")
            }
        }
    }
    
    
    //MARK:- To Get Work Order Number
    func getWorkOrderNumber(mtrIssType_id: Int, partNum_id: Int)  {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_workOrdNo.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.get.rawValue, Keys_val.id_.rawValue: partNum_id, Keys_val.basedon.rawValue: mtrIssType_id]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let lrWONumObj = try decoder_.decode(LR_WorkOrdNum.self, from: jsonData)
                    self.delegate_lrWorkOrdNum?.successResponse(dic_response: lrWONumObj)
                }catch let err_ {
                    self.delegate_lrWorkOrdNum?.errorResponse_workOrdNum(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrWorkOrdNum?.errorResponse_workOrdNum(error_: "Try again later")
            }
        }
    }
    
    //MARK:- To Get Mixer Part Number
    func getMixerPartNumber(mtrIssType_id: Int)  {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_drumPartNo.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.mia_sc_getmixervalue.rawValue, Keys_val.id_.rawValue: mtrIssType_id ]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let matTypeObj = try decoder_.decode(MIA_Mixer_PartNum.self, from: jsonData)
                    self.delegate_lrMixer_partNo?.successResponse(dic_response: matTypeObj)
                }catch let err_ {
                    self.delegate_lrMixer_partNo?.errorResponse_mixerPartNum(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrMixer_partNo?.errorResponse_mixerPartNum(error_: "Try again later")
            }
        }
    }
    
    //MARK:- Get Line Rejection Work Station
    func getLineRejectionWorkStation(mtrIssType_id: Int)  {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_workStation.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.lr_workStation.rawValue, Keys_val.lr_issFor.rawValue: mtrIssType_id]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let lr_wrkStaObj = try decoder_.decode(LR_WorkStation.self, from: jsonData)
                    self.delegate_lrWrkSta?.successResponse(dic_response: lr_wrkStaObj)
                }catch let err_ {
                    self.delegate_lrWrkSta?.errorResponse_lrWrkSta(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrWrkSta?.errorResponse_lrWrkSta(error_: "Try again later")
            }
        }
    }
    
    //MARK:- To Get Line Rejection List Items
    func getLineRejectionListItems(woNum_id: Int, mtrIssType_id: Int)  {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_listItems.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.lr_getLineItems.rawValue, Keys_val.id_.rawValue: woNum_id, Keys_val.basedon.rawValue: mtrIssType_id]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let lr_listItemsObj = try decoder_.decode(LR_ListItems.self, from: jsonData)//SS_Utility.replaceNullValues(data_: jsonData)
                    self.delegate_lrListItems?.successResponse(dic_response: lr_listItemsObj)
                }catch let err_ {
                    self.delegate_lrListItems?.errorResponse_lineRejItem(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrListItems?.errorResponse_lineRejItem(error_: "Try again later")
            }
        }
    }

    //MARK:- To Delete Line Rejection List
    func deleteLineRejectionList(id_: Int)  {
        methNam = methoName1.lineRej
        postWebService(str_methodName: MethodNames.lr_delete.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.lr_deleteList.rawValue, Keys_val.id_.rawValue: id_]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let lr_deleteListObj = try decoder_.decode(KPT_DeleteList.self, from: jsonData)//SS_Utility.replaceNullValues(data_: jsonData)
                    self.delegate_lrDeleteList?.successResponse(dic_response: lr_deleteListObj)
                }catch let err_ {
                    self.delegate_lrDeleteList?.errorResponse_deleteList(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_lrDeleteList?.errorResponse_deleteList(error_: "Try again later")
            }
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


class SS_LineRejCell: UITableViewCell {
    @IBOutlet weak var lbl_woNO: UILabel!
    @IBOutlet weak var lbl_prtNO: UILabel!
    @IBOutlet weak var lbl_lineRejItms: UILabel!
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var lbl_reqBy: UILabel!
    @IBOutlet weak var lbl_qcStus: UILabel!
    @IBOutlet weak var lbl_sapStus: UILabel!
    @IBOutlet weak var lbl_qcRewrkDetls: UILabel!
    @IBOutlet weak var lbl_qcCmmts: UILabel!
    @IBOutlet weak var lbl_action: UILabel!

    
}
