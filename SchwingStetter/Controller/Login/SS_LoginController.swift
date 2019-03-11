//
//  SS_LoginController.swift
//  
//
//  Created by TestMac on 31/10/18.
//

import Foundation
import UIKit

protocol LoginResponseDelegate: AnyObject {
    func successResponse(loginObj: Login)
    func errorResponse(error_: String)
    
}

class SS_LoginController {
    
    weak var delegate_login: LoginResponseDelegate?
    
   static let str_fcm = ""
    
   static func getDictionary(txtUsn: String, txtPwd: String) -> [String: Any] {
        let appDelegate_ = UIApplication.shared.delegate as! AppDelegate
        
        if let fcmToken = appDelegate_.fcmToken_ {
            return [Keys_val.username.rawValue: txtUsn, Keys_val.password.rawValue: txtPwd, Keys_val.fcmkey.rawValue: fcmToken, Keys_val.imei.rawValue: SS_Utility.getDeviceToken().replacingOccurrences(of: "-", with: ""), Keys_val.deviceType_.rawValue: 2] as [String: Any]
        }else{
            return [Keys_val.username.rawValue: txtUsn, Keys_val.password.rawValue: txtPwd, Keys_val.fcmkey.rawValue: str_fcm, Keys_val.imei.rawValue: SS_Utility.getDeviceToken().replacingOccurrences(of: "-", with: ""), Keys_val.deviceType_.rawValue: 2] as [String: Any]
        }
       
    }
    
    static func getStringFromDic(dicVal: [String: Any]) -> String{
        
        var str_val = ""
        var isFirstTime = true
        for item in dicVal {
            str_val += isFirstTime ? "\(item.key)=\(item.value)" : "&\(item.key)=\(item.value)"
            isFirstTime = false
        }
        
       /* if (isLoginUrl) {
            for item in dicVal {
                str_val += "&\(item.key)=\(item.value)"
            }
        }else{
            for item in dicVal {
                str_val += "?\(item.key)=\(item.value)"
            }
        }*/
        
        str_val = str_val == "=" ? "" : str_val
        print("str_val:- \(str_val)")
        return str_val
    }
    
     func userLogin(txt_usn_: String, txt_pwd_: String){
        methNam = methoName1.login_

        postWebService(str_methodName: MethodNames.login.rawValue, str_postParam: SS_LoginController.getDictionary(txtUsn: txt_usn_, txtPwd: txt_pwd_)){

            /*guard let dicVal = $0[Keys_val.share.Data] as? [Dictionary<String, Any>] else {
                return
            }*/

            if !$0.isEmpty {
                let decoder_ = JSONDecoder()
                do{
                    let jsonData_ = try JSONSerialization.data(withJSONObject: $0, options: [])
                    let loginResponseObj = try decoder_.decode(Login.self, from: jsonData_)
                     SingleTone.share.login = loginResponseObj
                    self.delegate_login?.successResponse(loginObj: loginResponseObj)
                }catch let err_{
                    self.delegate_login?.errorResponse(error_: err_.localizedDescription)
                }
                
             
            }else{
                self.delegate_login?.errorResponse(error_: "There is no data to show.")
                //let resObj = $0[Keys_val.share.Data]
          
            }
            
        }
    }
}
