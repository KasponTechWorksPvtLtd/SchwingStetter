//
//  SS_ForgotPwd_Controller.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 29/11/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit
protocol ForgotPwdResObjDelegate: AnyObject {
    func successResponse(forgotObj: SSForgotPwd)
     func successResponse_errObj(forgotObj: SSForgotPwd_Err)
    func errorResponse(error_: String)
    
}
class SS_ForgotPwd_Controller: UIViewController {

     weak var delegate_forgot: ForgotPwdResObjDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func sentPwdToRegisteredMail(email_: String) {
        methNam = methoName1.login_
        
        postWebService(str_methodName: MethodNames.forgotPwd.rawValue, str_postParam: [Keys_val.email.rawValue: email_]){ item in
            
            /*guard let dicVal = $0[Keys_val.share.Data] as? [Dictionary<String, Any>] else {
             return
             }*/
            
            if !item.isEmpty {
                let decoder_ = JSONDecoder()
                do{
                    let jsonData_ = try JSONSerialization.data(withJSONObject: item, options: [])
                    
                    if(item[Keys_val.Status.rawValue]! as! Int == 200 && item[Keys_val.ResponseCode.rawValue]! as! Int == 0 ){
                        let forgotErrResObj = try decoder_.decode(SSForgotPwd_Err.self, from: jsonData_)
                        self.delegate_forgot?.successResponse_errObj(forgotObj: forgotErrResObj)
                    }else{
                        let forgotResponseObj = try decoder_.decode(SSForgotPwd.self, from: jsonData_)
                        self.delegate_forgot?.successResponse(forgotObj: forgotResponseObj)
                    }
                  
                    
                }catch let err_{
                    self.delegate_forgot?.errorResponse(error_: err_.localizedDescription)
                }
                
                
            }else{
                self.delegate_forgot?.errorResponse(error_: "There is no data to show.")
                //let resObj = $0[Keys_val.share.Data]
                
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
