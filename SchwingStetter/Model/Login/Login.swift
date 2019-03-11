//
//  Login.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 09/11/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation

/*class Login : NSObject, NSCoding{
    
    var apiToken : String!
    var asmbAssyid : Int!
    var asmbCreatedAt : Int!
    var asmbLevel : Int!
    var asmbOperationCode : Int!
    var asmbSessionid : Int!
    var asmbTimeRequired : Int!
    var asmbUserid : Int!
    var asmbWorkStation : Int!
    var asmbWorkStatus : Int!
    var createdAt : Int!
    var email : String!
    var fabLevel : Int!
    var fabid : Int!
    var name : String!
    var operationCode : Int!
    var roleName : String!
    var sessionid : Int!
    var timeRequired : Int!
    var userRole : Int!
    var userid : Int!
    var workStation : Int!
    var workStatus : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        apiToken = dictionary[Keys_val.share.api_token] as? String
        asmbAssyid = dictionary[Keys_val.share.asmb_assyid] as? Int
        asmbCreatedAt = dictionary[Keys_val.share.asmb_created_at] as? Int
        asmbLevel = dictionary[Keys_val.share.asmb_level] as? Int
        asmbOperationCode = dictionary[Keys_val.share.asmb_operation_code] as? Int
        asmbSessionid = dictionary[Keys_val.share.asmb_sessionid] as? Int
        asmbTimeRequired = dictionary[Keys_val.share.asmb_time_required] as? Int
        asmbUserid = dictionary[Keys_val.share.asmb_userid] as? Int
        asmbWorkStation = dictionary[Keys_val.share.asmb_work_station] as? Int
        asmbWorkStatus = dictionary[Keys_val.share.asmb_work_status] as? Int
        createdAt = dictionary[Keys_val.share.created_at] as? Int
        email = dictionary[Keys_val.share.email] as? String
        fabLevel = dictionary[Keys_val.share.fab_level] as? Int
        fabid = dictionary[Keys_val.share.fabid] as? Int
        name = dictionary[Keys_val.share.name] as? String
        operationCode = dictionary[Keys_val.share.operation_code] as? Int
        roleName = dictionary[Keys_val.share.role_name] as? String
        sessionid = dictionary[Keys_val.share.sessionid] as? Int
        timeRequired = dictionary[Keys_val.share.time_required] as? Int
        userRole = dictionary[Keys_val.share.user_role] as? Int
        userid = dictionary[Keys_val.share.userid] as? Int
        workStation = dictionary[Keys_val.share.work_station] as? Int
        workStatus = dictionary[Keys_val.share.work_status] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if apiToken != nil{
            dictionary[Keys_val.share.api_token] = apiToken
        }
        if asmbAssyid != nil{
            dictionary[Keys_val.share.asmb_assyid] = asmbAssyid
        }
        if asmbCreatedAt != nil{
            dictionary[Keys_val.share.asmb_created_at] = asmbCreatedAt
        }
        if asmbLevel != nil{
            dictionary[Keys_val.share.asmb_level] = asmbLevel
        }
        if asmbOperationCode != nil{
            dictionary[Keys_val.share.asmb_operation_code] = asmbOperationCode
        }
        if asmbSessionid != nil{
            dictionary[Keys_val.share.asmb_sessionid] = asmbSessionid
        }
        if asmbTimeRequired != nil{
            dictionary[Keys_val.share.asmb_time_required] = asmbTimeRequired
        }
        if asmbUserid != nil{
            dictionary[Keys_val.share.asmb_userid] = asmbUserid
        }
        if asmbWorkStation != nil{
            dictionary[Keys_val.share.asmb_work_station] = asmbWorkStation
        }
        if asmbWorkStatus != nil{
            dictionary[Keys_val.share.asmb_work_status] = asmbWorkStatus
        }
        if createdAt != nil{
            dictionary[Keys_val.share.created_at] = createdAt
        }
        if email != nil{
            dictionary[Keys_val.share.email] = email
        }
        if fabLevel != nil{
            dictionary[Keys_val.share.fab_level] = fabLevel
        }
        if fabid != nil{
            dictionary[Keys_val.share.fabid] = fabid
        }
        if name != nil{
            dictionary[Keys_val.share.name] = name
        }
        if operationCode != nil{
            dictionary[Keys_val.share.operation_code] = operationCode
        }
        if roleName != nil{
            dictionary[Keys_val.share.role_name] = roleName
        }
        if sessionid != nil{
            dictionary[Keys_val.share.sessionid] = sessionid
        }
        if timeRequired != nil{
            dictionary[Keys_val.share.time_required] = timeRequired
        }
        if userRole != nil{
            dictionary[Keys_val.share.user_role] = userRole
        }
        if userid != nil{
            dictionary[Keys_val.share.userid] = userid
        }
        if workStation != nil{
            dictionary[Keys_val.share.work_station] = workStation
        }
        if workStatus != nil{
            dictionary[Keys_val.share.work_status] = workStatus
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        apiToken = aDecoder.decodeObject(forKey: Keys_val.share.api_token) as? String
        asmbAssyid = aDecoder.decodeObject(forKey: Keys_val.share.asmb_assyid) as? Int
        asmbCreatedAt = aDecoder.decodeObject(forKey: Keys_val.share.asmb_created_at) as? Int
        asmbLevel = aDecoder.decodeObject(forKey: Keys_val.share.asmb_level) as? Int
        asmbOperationCode = aDecoder.decodeObject(forKey: Keys_val.share.asmb_operation_code) as? Int
        asmbSessionid = aDecoder.decodeObject(forKey: Keys_val.share.asmb_sessionid) as? Int
        asmbTimeRequired = aDecoder.decodeObject(forKey: Keys_val.share.asmb_time_required) as? Int
        asmbUserid = aDecoder.decodeObject(forKey: Keys_val.share.asmb_userid) as? Int
        asmbWorkStation = aDecoder.decodeObject(forKey: Keys_val.share.asmb_work_station) as? Int
        asmbWorkStatus = aDecoder.decodeObject(forKey: Keys_val.share.asmb_work_status) as? Int
        createdAt = aDecoder.decodeObject(forKey: Keys_val.share.created_at) as? Int
        email = aDecoder.decodeObject(forKey: Keys_val.share.email) as? String
        fabLevel = aDecoder.decodeObject(forKey: Keys_val.share.fab_level) as? Int
        fabid = aDecoder.decodeObject(forKey: Keys_val.share.fabid) as? Int
        name = aDecoder.decodeObject(forKey: Keys_val.share.name) as? String
        operationCode = aDecoder.decodeObject(forKey: Keys_val.share.operation_code) as? Int
        roleName = aDecoder.decodeObject(forKey: Keys_val.share.role_name) as? String
        sessionid = aDecoder.decodeObject(forKey: Keys_val.share.sessionid) as? Int
        timeRequired = aDecoder.decodeObject(forKey: Keys_val.share.time_required) as? Int
        userRole = aDecoder.decodeObject(forKey: Keys_val.share.user_role) as? Int
        userid = aDecoder.decodeObject(forKey: Keys_val.share.userid) as? Int
        workStation = aDecoder.decodeObject(forKey: Keys_val.share.work_station) as? Int
        workStatus = aDecoder.decodeObject(forKey: Keys_val.share.work_status) as? Int
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if apiToken != nil{
            aCoder.encode(apiToken, forKey: Keys_val.share.api_token)
        }
        if asmbAssyid != nil{
            aCoder.encode(asmbAssyid, forKey: Keys_val.share.asmb_assyid)
        }
        if asmbCreatedAt != nil{
            aCoder.encode(asmbCreatedAt, forKey: Keys_val.share.asmb_created_at)
        }
        if asmbLevel != nil{
            aCoder.encode(asmbLevel, forKey: Keys_val.share.asmb_level)
        }
        if asmbOperationCode != nil{
            aCoder.encode(asmbOperationCode, forKey: Keys_val.share.asmb_operation_code)
        }
        if asmbSessionid != nil{
            aCoder.encode(asmbSessionid, forKey: Keys_val.share.asmb_sessionid)
        }
        if asmbTimeRequired != nil{
            aCoder.encode(asmbTimeRequired, forKey: Keys_val.share.asmb_time_required)
        }
        if asmbUserid != nil{
            aCoder.encode(asmbUserid, forKey: Keys_val.share.asmb_userid)
        }
        if asmbWorkStation != nil{
            aCoder.encode(asmbWorkStation, forKey: Keys_val.share.asmb_work_station)
        }
        if asmbWorkStatus != nil{
            aCoder.encode(asmbWorkStatus, forKey: Keys_val.share.asmb_work_status)
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: Keys_val.share.created_at)
        }
        if email != nil{
            aCoder.encode(email, forKey: Keys_val.share.email)
        }
        if fabLevel != nil{
            aCoder.encode(fabLevel, forKey: Keys_val.share.fab_level)
        }
        if fabid != nil{
            aCoder.encode(fabid, forKey: Keys_val.share.fabid)
        }
        if name != nil{
            aCoder.encode(name, forKey: Keys_val.share.name)
        }
        if operationCode != nil{
            aCoder.encode(operationCode, forKey: Keys_val.share.operation_code)
        }
        if roleName != nil{
            aCoder.encode(roleName, forKey: Keys_val.share.role_name)
        }
        if sessionid != nil{
            aCoder.encode(sessionid, forKey: Keys_val.share.sessionid)
        }
        if timeRequired != nil{
            aCoder.encode(timeRequired, forKey: Keys_val.share.time_required)
        }
        if userRole != nil{
            aCoder.encode(userRole, forKey: Keys_val.share.user_role)
        }
        if userid != nil{
            aCoder.encode(userid, forKey: Keys_val.share.userid)
        }
        if workStation != nil{
            aCoder.encode(workStation, forKey: Keys_val.share.work_station)
        }
        if workStatus != nil{
            aCoder.encode(workStatus, forKey: Keys_val.share.work_status)
        }
    }
}*/

//MARK:- LOGIN
struct Login: Codable {
    let status: Int?
    let responseMessage: String?
    let data: [Datum]?
    let responseCode: Int?
    let methodName: String?
    let additionalData: Int?
    
    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case responseMessage = "ResponseMessage"
        case data = "Data"
        case responseCode = "ResponseCode"
        case methodName
        case additionalData = "AdditionalData"
    }
    
    init() {
        let datum_1 = [Datum(userid: "-1", imgUploadURL: "", id: "", name: "", email: "", userRole: "", roleName: "", apiToken: "", createdAt: 0, fabid: 0, sessionid: 0, workStatus: 0, operationCode: 0, workStation: 0, timeRequired: 0, fabLevel: 0, asmbUserid: 0, asmbAssyid: 0, asmbSessionid: 0, asmbWorkStatus: 0, asmbCreatedAt: 0, asmbOperationCode: 0, asmbWorkStation: 0, asmbTimeRequired: 0, asmbLevel: 0)]
        
        /*self = Login(status: 0, responseMessage: "", data: datum_1, responseCode: 0, methodName: "", additionalData: 0)*/
        status = 0
        responseMessage = ""
        data = datum_1
        responseCode = 0
        methodName = ""
        additionalData = 0
        
    }
    
}

struct Datum: Codable {
    let userid: String?
    let imgUploadURL: String?
    let id, name, email, userRole: String?
    let roleName, apiToken: String?
    let createdAt, fabid, sessionid, workStatus: Int?
    let operationCode, workStation, timeRequired, fabLevel: Int?
    let asmbUserid, asmbAssyid, asmbSessionid, asmbWorkStatus: Int?
    let asmbCreatedAt, asmbOperationCode, asmbWorkStation, asmbTimeRequired: Int?
    let asmbLevel: Int?
    
    enum CodingKeys: String, CodingKey {
        case userid
        case imgUploadURL = "img_upload_url"
        case id, name, email
        case userRole = "user_role"
        case roleName = "role_name"
        case apiToken = "api_token"
        case createdAt = "created_at"
        case fabid, sessionid
        case workStatus = "work_status"
        case operationCode = "operation_code"
        case workStation = "work_station"
        case timeRequired = "time_required"
        case fabLevel = "fab_level"
        case asmbUserid = "asmb_userid"
        case asmbAssyid = "asmb_assyid"
        case asmbSessionid = "asmb_sessionid"
        case asmbWorkStatus = "asmb_work_status"
        case asmbCreatedAt = "asmb_created_at"
        case asmbOperationCode = "asmb_operation_code"
        case asmbWorkStation = "asmb_work_station"
        case asmbTimeRequired = "asmb_time_required"
        case asmbLevel = "asmb_level"
    }
    
    /*let userid: Int?
    let imgUploadURL: String?
    let id, name, email, userRole: String?
    let roleName, apiToken: String?
    let createdAt, fabid, sessionid, workStatus: Int?
    let operationCode, workStation, timeRequired, fabLevel: Int?
    let asmbUserid, asmbAssyid, asmbSessionid, asmbWorkStatus: Int?
    let asmbCreatedAt, asmbOperationCode, asmbWorkStation, asmbTimeRequired: Int?
    let asmbLevel: Int?
    
    enum CodingKeys: String, CodingKey {
        case userid
        case imgUploadURL = "img_upload_url"
        case id, name, email
        case userRole = "user_role"
        case roleName = "role_name"
        case apiToken = "api_token"
        case createdAt = "created_at"
        case fabid, sessionid
        case workStatus = "work_status"
        case operationCode = "operation_code"
        case workStation = "work_station"
        case timeRequired = "time_required"
        case fabLevel = "fab_level"
        case asmbUserid = "asmb_userid"
        case asmbAssyid = "asmb_assyid"
        case asmbSessionid = "asmb_sessionid"
        case asmbWorkStatus = "asmb_work_status"
        case asmbCreatedAt = "asmb_created_at"
        case asmbOperationCode = "asmb_operation_code"
        case asmbWorkStation = "asmb_work_station"
        case asmbTimeRequired = "asmb_time_required"
        case asmbLevel = "asmb_level"
    }*/
    
}





