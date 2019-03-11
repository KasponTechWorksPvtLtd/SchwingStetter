//
//  Constants.swift
//  SchwingStetter
//
//  Created by TestMac on 08/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation

enum BaseURL: String {
    
    case live_methods = "http://52.35.246.28/schwingstetter/schwing_backends_V5/public/index.php/api/"
    
   // case live_methods = "http://52.35.246.28/ssipl_backend/public/index.php/api/"
    case live_login = "http://52.35.246.28/schwing_backends_V5/api_mobile/technician.php?methodname="
    
    
    
    static var live_lineRej: BaseURL{
        return live_methods
    }
    
        /*
     "http://52.35.246.28/ssiplbeta/schwing_back/public/api/" "http://52.35.246.28/ssipl_backend/public/index.php/api/"
     case dev_prodview = "http://52.35.246.28/schwingstetter/schwing_backends_V5/public/index.php/api/"
     case dev_cnc = "http://192.168.1.85:8080/schwing_back_1/public/index.php/api/"
     */
    
}

enum methoName1: String{         
    case login_
    case cnc_
   case lineRej

}

/*struct MethodNames {
    static let share = MethodNames()

    let login = "get_validate_user&"
    let production_view = "getproductionplan?"
    let production_edit = "addmixerplanning?"
    let cncApproveSegment = "cncsegment?"
    let snag_operationcode = "operationcode?"
    let snag_delaysnagrework = "delaysnagrework?"
    let snag_delayrework = "delayrework?"
    
    
}*/

/*struct SB_Identifier {
    static let share = SB_Identifier()
    
    let LOGINVC = "LOGINVC"
    let FORGOTPWDVC = "FORGOTPWDVC"
    let DASHBOARDVC = "DASHBOARDVC"
    let PRODUCPLANVC = "PRODUCPLANVC"
    let EDITPPVC = "EDITPPVC"
    let DROPDOWNVC = "DROPDOWNVC"
    let DRUMCLEARANCEVC = "DRUMCLEARANCEVC"
    let LINEREJECTVC = "LINEREJECTVC"
    let MATERIALSTATUSVC = "MATERIALSTATUSVC"
    let CNCAPPROVALVC = "CNCAPPROVALVC"
    let CNCAPPROVALEDITVC = "CNCAPPROVALEDITVC"
    let DELAYSNAGVC = "DELAYSNAGVC"
    let DEFAULTLOADERVC = "DEFAULTLOADERVC"
    
    
}*/

/*struct Cell_Identifier {
    static let share = Cell_Identifier()
    
    let cell_dashboard = "CELLDASHBOARD"
    let cell_prodPlan = "CELLPRODUCTPLAN"
    let cell_dropdown = "CELLDROPDOWN"
    let cell_cncApprove = "CELLCNCAPPROVE"
    let cell_editCncApprove = "CELLEDITCNCAPPROVE"
    let cell_editCncApprove_1 = "CELLEDITCNCAPPROVE_1"
    let cell_delaySnag = "CELLDELAYSNAG"
    
    
}*/

/*struct Keys_val {
    static let share = Keys_val()
    
    let workingOrder = "workingOrder"
    let mixerAssembly = "mixerAssembly"
    let portNum = "portNum"
    let priority = "priority"
    let plannedSchedule = "plannedSchedule"
    let date_ = "date"
    let empID = "empID"
    let rmPartNum = "rmPartNum"
    let drumModel = "drumModel"
    let segmentQty = "segmentQty"
    let coneCateg = "coneCateg"
    let cone = "cone"
    let description = "description"
    let seg_weight = "segmentWeight"
    let username = "username"
    let password = "password"
    let fcmkey = "fcmkey"
    let imei = "imei"
    let ResponseCode = "ResponseCode"
    let Status = "Status"
    let status_ = "status"
    let ResponseMessage = "ResponseMessage"
    let Data = "Data"
    let Message = "Message"
    let AdditionalData = "AdditionalData"
    let methodName = "methodName"
    let api_token = "api_token"
    let asmb_assyid = "asmb_assyid"
    let asmb_created_at = "asmb_created_at"
    let asmb_level = "asmb_level"
    let asmb_operation_code = "asmb_operation_code"
    let asmb_sessionid = "asmb_sessionid"
    let asmb_time_required = "asmb_time_required"
    let asmb_userid = "asmb_userid"
    let asmb_work_station = "asmb_work_station"
    let asmb_work_status = "asmb_work_status"
    let created_at = "created_at"
    let email = "email"
    let fab_level = "fab_level"
    let fabid = "fabid"
    let name = "name"
    let operation_code = "operation_code"
    let role_name = "role_name"
    let sessionid = "sessionid"
    let time_required = "time_required"
    let user_role = "user_role"
    let userid = "userid"
    let work_station = "work_station"
    let work_status = "work_status"
    let switchcase = "switchcase"
    let get = "get"//data
    let message_ = "message"
    let edit = "edit"
    let id_ = "id"
    let workorderno = "workorderno"
    let modelno = "modelno"
    let partno = "part_no"
    let fromdate = "fromdate"
    let todate = "todate"
    let getdrumdetails = "getdrumdetails"
    let approvalorreject = "approvalorreject"
    let basedon = "basedon"
    let type = "type"
    let workstation = "workstation"
    let processtype = "processtype"
    let code = "code"
    

}*/

enum SB_Identifier: String {
    
    case LOGINVC = "LOGINVC"
    case FORGOTPWDVC = "FORGOTPWDVC"
    case DASHBOARDVC = "DASHBOARDVC"
    case PRODUCPLANVC = "PRODUCPLANVC"
    case EDITPPVC = "EDITPPVC"
    case DROPDOWNVC = "DROPDOWNVC"
    case DRUMCLEARANCEVC = "DRUMCLEARANCEVC"
    case LINEREJECTVC = "LINEREJECTVC"
    case ADDNEWITEMSVC = "ADDNEWITEMSVC"
    case EDITADDEDLINEITEMVC = "EDITADDEDLINEITEMVC"
    case EDITLINEREJVC = "EDITLINEITEMVC"
    case MATERIALSTATUSVC = "MATERIALSTATUSVC"
    case SUBMITMTRACKNOVC = "SUBMITMTRACKNOVC"
    case CNCAPPROVALVC = "CNCAPPROVALVC"
    case CNCAPPROVALEDITVC = "CNCAPPROVALEDITVC"
    case DELAYSNAGVC = "DELAYSNAGVC"
    case DEFAULTLOADERVC = "DEFAULTLOADERVC"
    case VIEWLINEREJITEMSVC = "VIEWLRIVC"
    
}

enum MethodNames: String {
    
    case login = "get_validate_user&"
    case forgotPwd = "get_forgotpassword&"
    case production_view = "getproductionplan?"
    case production_edit = "addmixerplanning?" //mia_mixer_woNum
    case cncSegmentList = "cncsegment?"
    case cncSegmentSubmit = "request_approval?"
    case snag_operationcode = "operationcode?"
    case snag_delaysnagrework = "delaysnagrework?"
    case snag_delayrework = "delayrework?"
    case drumClr_list = "get_drum_clearance"
    case drumClr_srnNum = "get_drum_serial_no?"
    case drumClr_submis_rej = "revertdrumspare?"//"revertspare?"
    //case mia_materailType, mia_drum_partNum, mia_mount_woNum, mia_material_list = "materailpicking?"
    case mia_mrtTyp_drPN_mouWON_mList = "materailpicking?"
    case mia_drum_woNum = "drumwogeneration?"
    case mia_mixer_partNum = "getdetails?"
    case mia_material_ackn = "materialacknowledge?"
    case lr_listItems = "linerejection"//?
    static var lr_materialIssFor: MethodNames {
       return mia_mrtTyp_drPN_mouWON_mList
    }
    static var lr_drumPartNo: MethodNames {
        return mia_mrtTyp_drPN_mouWON_mList
    }
    static var lr_workOrdNo: MethodNames {
        return lr_listItems
    }
    static var lr_workStation: MethodNames {
        return lr_listItems
    }
    static var lr_partDescrip: MethodNames {
        return lr_listItems
    }
    static var lr_addItems: MethodNames {
        return lr_listItems
    }
    static var lr_addItemsList: MethodNames {
        return lr_listItems
    }
    static var lr_updateEditedItems: MethodNames {
        return lr_listItems
    }
    static var lr_updateLineRej: MethodNames {
        return lr_listItems
    }
    static var lr_delete: MethodNames {
        return lr_listItems
    }
    static var mia_mixer_woNum: MethodNames {
        get{
            return production_edit
        }
    }
}

enum Cell_Identifier: String {
    
    case cell_dashboard = "CELLDASHBOARD"
    case cell_prodPlan = "CELLPRODUCTPLAN"
    case cell_dropdown = "CELLDROPDOWN"
    case cell_cncApprove = "CELLCNCAPPROVE"
    case cell_editCncApprove = "CELLEDITCNCAPPROVE"
    case cell_editCncApprove_1 = "CELLEDITCNCAPPROVE_1"
    case cell_delaySnag = "CELLDELAYSNAG"
    case cell_materialList = "CELLMATERIALLIST"
    case cell_lineRejection = "CELLLINEREJECTION"
    case cell_lrAddNewItems = "CELLLINEREJADDNEWITEMS"
    case cell_viewLRI = "CELLVIEWLINEREJ"
}

enum Keys_val: String {
    
    case workingOrder = "workingOrder"
    case mixerAssembly = "mixerAssembly"
    case portNum = "portNum"
    case priority = "priority"
    case plannedSchedule = "plannedSchedule"
    case deviceType_ = "device_type"
    case date_ = "date"
    case empID = "empID"
    case rmPartNum = "rmPartNum"
    case drumModel = "drumModel"
    case segmentQty = "segmentQty"
    case coneCateg = "coneCateg"
    case cone = "cone"
    case description = "description"
    case seg_weight = "segmentWeight"
    case username = "username"
    case password = "password"
    case fcmkey = "fcmkey"
    case imei = "imei"
    case ResponseCode = "ResponseCode"
    case Status = "Status"
    case status_ = "status"
    case ResponseMessage = "ResponseMessage"
    case Data = "Data"
    case Message = "Message"
    case AdditionalData = "AdditionalData"
    case methodName = "methodName"
    case api_token = "api_token"
    case asmb_assyid = "asmb_assyid"
    case asmb_created_at = "asmb_created_at"
    case asmb_level = "asmb_level"
    case asmb_operation_code = "asmb_operation_code"
    case asmb_sessionid = "asmb_sessionid"
    case asmb_time_required = "asmb_time_required"
    case asmb_userid = "asmb_userid"
    case asmb_work_station = "asmb_work_station"
    case asmb_work_status = "asmb_work_status"
    case created_at = "created_at"
    case email = "email"
    case fab_level = "fab_level"
    case fabid = "fabid"
    case name = "name"
    case operation_code = "operation_code"
    case role_name = "role_name"
    case sessionid = "sessionid"
    case time_required = "time_required"
    case user_role = "user_role"
    case userid = "userid"
    case work_station = "work_station"
    case work_status = "work_status"
    case switchcase = "switchcase"
    case get = "get"//data
    case message_ = "message"
    case edit = "edit"
    case id_ = "id"
    case noOfPlates = "no_of_plates"
    case workorderno = "workorderno"
    case modelno = "modelno"
    case partno = "part_no"
    case alternativePartNumber = "alternate_unique_value"
    case partno_ = "partno"
    case cnc_partNo = "getpartno"
    case fromdate = "fromdate"
    case todate = "todate"
    case getdrumdetails = "getdrumdetails"
    case approvalorreject = "approvalorreject"
    case basedon = "basedon"
    case type = "type"
    case workstation = "workstation"
    case processtype = "processtype"
    case code = "code"
    case cncCreatedDate = "createdat"
    case drum_model = "drum_model"
    case drumpart_no = "drumpart_no"
    case drum_serial_no = "drum_serial_no"
    case mia_sc_matIssFor = "material_issued_for"
    case mia_sc_getmixervalue = "getmixervalue"
    case mia_sc_getmixassprt = "getmixerassemblypart"
    case mia_sc_getmount_bom = "getmounting_bom"
    case mia_sc_getMtrList = "getmaterialdetails"
    case lr_matIssFor = "marterialIssueFor"
    case lr_prtNum = "partNumber"
    case lr_woNum = "workOrderNumber"
    case lr_wrkSta = "workStation"
    case quantity = "quantity"
    case comments = "comments"
    case lr_addNew_itemDetails = "lineitems"//"lineRejItemDetails"
    case lr_getLineItems = "getlineitems"
    case lr_workStation = "getworkstation"
    case lr_issFor = "issuedfor"
    case lr_partDescr = "getdescription"
    case lr_add_mrtIssFor = "materialissuefor"
    case lr_add_woNum = "wonumber"
    case lr_add_woNum_ = "wo_number"
    case lr_getitmList = "getlinerejectionitems"
    case lr_addItems = "insert"
    case lr_reqBy = "requested_by"
    case lr_wo_Num = "workorder_no"
    case lr_updateLineRej = "editlinerejection"
    case lr_deleteList = "delete"
    case lr_deleteItems = "deletelineitems"
    case pp_getList = "getproductiondetails"
    static var lr_add_wrkStation: Keys_val {  return workstation }
    static var lr_add_partno: Keys_val {  return partno  }
    
}

struct TagVal {
    static let share = TagVal()
    let dropdownVC = 775
}

class SingleTone {
    static let share = SingleTone()
    
    //var login = Login(fromDictionary: ["" : ""])
    var login =  Login()
}

enum testingString {
    case string1
    case string2
    case string3
}

//707070 => Ash
//1DB788 => Green
//EB3939 => Red
