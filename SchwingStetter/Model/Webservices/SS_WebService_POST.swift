//
//  SS_WebService_POST.swift
//  SchwingStetter
//
//  Created by TestMac on 08/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation
var isLoginUrl = false
var methNam = methoName1.login_


func postWebServiceWithErrorHandler(str_methodName: String, str_postParam: [String: Any], errorHandler: @escaping (String) -> Void, callBack: @escaping([String: Any]) -> Void) {
    
    //let url_ = isLoginUrl ? BaseURL.dev_login.rawValue : BaseURL.dev_1.rawValue
    var url_ = ""
    switch methNam {
    case methoName1.login_ :
        url_ = BaseURL.live_login.rawValue
    case methoName1.cnc_:
        url_ = BaseURL.live_methods.rawValue
    case .lineRej:
        url_ = BaseURL.live_lineRej.rawValue
    }
    
    let str_param = SS_LoginController.getStringFromDic(dicVal: str_postParam)
    let url_str = URL(string: url_ + str_methodName + str_param.addingPercentEncoding(withAllowedCharacters: CharacterSet(bitmapRepresentation: CharacterSet.urlPathAllowed.bitmapRepresentation))!)
    
    isLoginUrl = false
    
    print("baseurl:- \(url_str!)")
    print("str_postParam:- \(str_postParam)")
    
    var request = URLRequest(url: url_str!)
    //let jsonData = try? JSONSerialization.data(withJSONObject: str_postParam)
    //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    //url_str?.setTemporaryResourceValue("sdd", forKey: .isExcludedFromBackupKey)
    //request.httpBody = jsonData//str_postParam.description.data(using: .utf8)
    
    let  task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard error == nil else {
            //print("return error:- \(error?.localizedDescription ?? "defaul vall")")
            /*showAlert(str_title: "Alert", str_msg: (error?.localizedDescription)!, alertType: 0){_ in
                stopIndicator(vc: getRootVC())
            }*/
            DispatchQueue.main.sync {errorHandler((error?.localizedDescription)!)}
            
            return
        }
        
        guard let content = data else {
            print("not returning data")
            /*showAlert(str_title: "Alert", str_msg: "not returning data", alertType: 0){_ in
                stopIndicator(vc: getRootVC())
            }*/
            DispatchQueue.main.sync {errorHandler("Not returning data.")}
            
            return
        }
        //
        guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers))  else { //[String: Any]
            print("Not containing JSON")
            /*showAlert(str_title: "Alert", str_msg: "No data to show", alertType: 0){_ in
                stopIndicator(vc: getRootVC())
            }*/
            DispatchQueue.main.sync {errorHandler("No data to show")}
            
            return
        }
        
        DispatchQueue.main.sync {
            print("json:- \(json)")
            callBack(json as! [String : Any])
        }
        
    }
    task.resume()
    
}

func postWebService(str_methodName: String, str_postParam: [String: Any], callBack: @escaping([String: Any]) -> Void) {
    
    //let url_ = isLoginUrl ? BaseURL.dev_login.rawValue : BaseURL.dev_1.rawValue
    var url_ = ""
    switch methNam {
    case methoName1.login_ :
        url_ = BaseURL.live_login.rawValue
    case methoName1.cnc_:
        url_ = BaseURL.live_methods.rawValue
    case .lineRej:
        url_ = BaseURL.live_lineRej.rawValue
    }

    let str_param = SS_LoginController.getStringFromDic(dicVal: str_postParam)
    let url_str: URL!
    if (str_methodName == MethodNames.lr_addItems.rawValue){
         url_str = URL(string: url_ + str_methodName)

    }else{
         url_str = URL(string: url_ + str_methodName + str_param.addingPercentEncoding(withAllowedCharacters: CharacterSet(bitmapRepresentation: CharacterSet.urlPathAllowed.bitmapRepresentation))!)
    }
    isLoginUrl = false
    print("url_str:- \(url_str!)")
    var request = URLRequest(url: url_str!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    
   if (str_methodName == MethodNames.lr_addItems.rawValue){
    let jsonData = try? JSONSerialization.data(withJSONObject: str_postParam)
    request.httpBody = jsonData
    }
    
   
    
    
    let  task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard error == nil else {
            DispatchQueue.main.sync {
                SS_Utility.showAlert(str_title: "Alert", str_msg: (error?.localizedDescription)!, alertType: 0){_ in
                    SS_Utility.stopIndicator(vc: SS_Utility.getRootVC())
                }
            }
            return
        }
        
        guard let content = data else {
            print("not returning data")
            /**/
            DispatchQueue.main.sync {
                SS_Utility.showAlert(str_title: "Alert", str_msg: "not returning data", alertType: 0){_ in
                SS_Utility.stopIndicator(vc: SS_Utility.getRootVC())
                }
            }
            return
        }
        //
        guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers))  else { //[String: Any]
            DispatchQueue.main.sync {
                SS_Utility.showAlert(str_title: "Alert", str_msg: "No data to show", alertType: 0){_ in
                    SS_Utility.stopIndicator(vc: SS_Utility.getRootVC())
                }
            }
            return
        }
        print("json:- \(json)")
        DispatchQueue.main.sync {
            callBack(json as! [String : Any])
        }
    }
    task.resume()
    
}
