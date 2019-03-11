//
//  SS_MaterialIssue_Controller.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 22/11/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

protocol MIA_MaterialTypesDelegate: AnyObject {
    func successResponse(dic_response: MIA_MaterialTypes)
    func errorResponse_materialType(error_: String)
}

protocol MIA_DrumPartNumDelegate: AnyObject {
    func successResponse(dic_response: MIA_Drum_ParNum)
    func errorResponse_drumPartNum(error_: String)
}

protocol MIA_DrumWONumDelegate: AnyObject {
    func successResponse(dic_response: MIA_Drum_WONum)
    func errorResponse_drumWONum(error_: String)
}

protocol MIA_MixerPartNumDelegate: AnyObject {
    func successResponse(dic_response: MIA_Mixer_PartNum)
    func errorResponse_mixerPartNum(error_: String)
}

protocol MIA_MixerWONumDelegate: AnyObject {
    func successResponse(dic_response: MIA_Mixer_WONum)
    func errorResponse_mixerWONum(error_: String)
}

protocol MIA_MountWONumDelegate: AnyObject {
    func successResponse(dic_response: MIA_Mount_WONum)
    func errorResponse_mountWONum(error_: String)
}

protocol MIA_MaterialListDelegate: AnyObject {
    func successResponse(dic_response: MIA_Material_List)
    func errorResponse_mrtList(error_: String)
}

protocol MIA_MaterialAcknDelegate: AnyObject {
    func successResponse(dic_response: MIA_Material_Acknowledge)
    func errorResponse_mrtAckn(error_: String)
}


class SS_MaterialIssue_Controller: UIViewController {

    weak var delegate_materialType: MIA_MaterialTypesDelegate?
    
    weak var delegate_drumPartNum: MIA_DrumPartNumDelegate?
    weak var delegate_drumWONum: MIA_DrumWONumDelegate?
    
    weak var delegate_mixerPartNum: MIA_MixerPartNumDelegate?
    weak var delegate_mixerWONum: MIA_MixerWONumDelegate?
    
    weak var delegate_mountWONum: MIA_MountWONumDelegate?
    
    weak var delegate_mrtList: MIA_MaterialListDelegate?
    
    weak var delegate_mrtAckn: MIA_MaterialAcknDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    //MARK:- To get Material Types
    func getMaterialTypes() {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.mia_mrtTyp_drPN_mouWON_mList.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.mia_sc_matIssFor.rawValue]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let matTypeObj = try decoder_.decode(MIA_MaterialTypes.self, from: jsonData)
                    self.delegate_materialType?.successResponse(dic_response: matTypeObj)
                }catch let err_ {
                    self.delegate_materialType?.errorResponse_materialType(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_materialType?.errorResponse_materialType(error_: "Try again later")
            }
        }
    }
    
    //MARK:- To get Drum Part num and Model num
    func getDrumPartNum(tagVal_: Int) {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.mia_mrtTyp_drPN_mouWON_mList.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.mia_sc_getmixervalue.rawValue, Keys_val.id_.rawValue: tagVal_]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let drumPrtNumObj = try decoder_.decode(MIA_Drum_ParNum.self, from: jsonData)
                    self.delegate_drumPartNum?.successResponse(dic_response: drumPrtNumObj)
                }catch let err_ {
                    self.delegate_drumPartNum?.errorResponse_drumPartNum(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_drumPartNum?.errorResponse_drumPartNum(error_: "Try again later")
            }
        }
    }
    
    //MARK:- To get Drum Working Order Number
    func getDrumWONum(tagVal_: Int) {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.mia_drum_woNum.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.get.rawValue, Keys_val.id_.rawValue: tagVal_]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let drumWONumObj = try decoder_.decode(MIA_Drum_WONum.self, from: jsonData)
                    self.delegate_drumWONum?.successResponse(dic_response: drumWONumObj)
                }catch let err_ {
                    self.delegate_drumWONum?.errorResponse_drumWONum(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_drumWONum?.errorResponse_drumWONum(error_: "Try again later")
            }
        }
    }
    
    //MARK:- To get Mixer Part num and Model num
    func getMixerPartNum() {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.mia_mixer_partNum.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.mia_sc_getmixassprt.rawValue]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let mixerPrtNumObj = try decoder_.decode(MIA_Mixer_PartNum.self, from: jsonData)
                    self.delegate_mixerPartNum?.successResponse(dic_response: mixerPrtNumObj)
                }catch let err_ {
                    self.delegate_mixerPartNum?.errorResponse_mixerPartNum(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_mixerPartNum?.errorResponse_mixerPartNum(error_: "Try again later")
            }
        }
    }
    

    //MARK:- To get Mixer Working Order Number
    func getMixerWONum(tagVal_: Int) {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.mia_mixer_woNum.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.get.rawValue, Keys_val.id_.rawValue: tagVal_]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let mixerWONumObj = try decoder_.decode(MIA_Mixer_WONum.self, from: jsonData)
                    self.delegate_mixerWONum?.successResponse(dic_response: mixerWONumObj)
                }catch let err_ {
                    self.delegate_mixerWONum?.errorResponse_mixerWONum(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_mixerWONum?.errorResponse_mixerWONum(error_: "Try again later")
            }
        }
    }
    
    //MARK:- To get Mounting Working Order Number
    func getMountWONum() {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.mia_mrtTyp_drPN_mouWON_mList.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.mia_sc_getmount_bom.rawValue]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let mountWONumObj = try decoder_.decode(MIA_Mount_WONum.self, from: jsonData)
                    self.delegate_mountWONum?.successResponse(dic_response: mountWONumObj)
                }catch let err_ {
                    self.delegate_mountWONum?.errorResponse_mountWONum(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_mountWONum?.errorResponse_mountWONum(error_: "Try again later")
            }
        }
    }
    
    //MARK:- To get Material List
    func getMaterialList(mrtTypeID: Int, mrtWONumId: Int) {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.mia_mrtTyp_drPN_mouWON_mList.rawValue, str_postParam: [Keys_val.switchcase.rawValue: Keys_val.mia_sc_getMtrList.rawValue, Keys_val.basedon.rawValue: mrtTypeID, Keys_val.id_.rawValue: mrtWONumId]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let mrtListObj = try decoder_.decode(MIA_Material_List.self, from: jsonData)
                    self.delegate_mrtList?.successResponse(dic_response: mrtListObj)
                }catch let err_ {
                    self.delegate_mrtList?.errorResponse_mrtList(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_mrtList?.errorResponse_mrtList(error_: "Try again later")
            }
        }
    }
    
    //MARK:- To submit Material Acknowledgement Status
    func submitMaterialAcknStatus(mrtStatusID: Int, mrtWONumId: Int) {
        methNam = methoName1.cnc_
        postWebService(str_methodName: MethodNames.mia_material_ackn.rawValue, str_postParam: [Keys_val.empID.rawValue: SingleTone.share.login.data![0].userid!, Keys_val.id_.rawValue: mrtWONumId, Keys_val.status_.rawValue: mrtStatusID]){
            if !$0.isEmpty {
                do{
                    let decoder_ = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let mrtAcknObj = try decoder_.decode(MIA_Material_Acknowledge.self, from: jsonData)
                    self.delegate_mrtAckn?.successResponse(dic_response: mrtAcknObj)
                }catch let err_ {
                    self.delegate_mrtAckn?.errorResponse_mrtAckn(error_: err_.localizedDescription)
                }
            }else{
                self.delegate_mrtAckn?.errorResponse_mrtAckn(error_: "Try again later")
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


class SS_MaterialAckn_TableCell: UITableViewCell {
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_woNum: UILabel!
    @IBOutlet weak var lbl_totalQty: UILabel!
    @IBOutlet weak var lbl_issuedQty: UILabel!
    @IBOutlet weak var lbl_shiftEngStus: UILabel!
    @IBOutlet weak var lbl_storeStus: UILabel!
    
}
