//
//  SS_ForgotPwdViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 11/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_ForgotPwdViewController: UIViewController {

    
    @IBOutlet weak var txt_email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_email.setLeftPaddingPoints(5)
        txt_email.setRightPaddingPoints(10)

        // Do any additional setup after loading the view.
    }

    //MARK:- Button ACtionadditional
    @IBAction func resetPwd_clicked(_ sender: Any) {
        if (txt_email.text?.isEmpty)! {
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Email id should not be empty", alertType: 0){_ in
            }
            
        }else if !(SS_Utility.validateTestFields(textField: txt_email)){
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Please enter valid email id.", alertType: 0){_ in
            }
        }else{
            SS_Utility.showIndicator(vc: self)
            let frgController = SS_ForgotPwd_Controller()
            frgController.delegate_forgot = self
            frgController.sentPwdToRegisteredMail(email_: txt_email.text!)
        }
    }
    
    @IBAction func backBtnClicked(){
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

extension SS_ForgotPwdViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension SS_ForgotPwdViewController: ForgotPwdResObjDelegate{
    func successResponse_errObj(forgotObj: SSForgotPwd_Err) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: "Entered incorrect email id.", alertType: 0){_ in
        }
        
    }
    
    func successResponse(forgotObj: SSForgotPwd) {
        SS_Utility.stopIndicator(vc: self)
        if forgotObj.responseCode == 1 {
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Mail has been sent to your registered mail.", alertType: 0){_ in
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: "Kindly enter your registered mail id.", alertType: 0){_ in
            }
        }
    }
    
    func errorResponse(error_: String) {
        SS_Utility.stopIndicator(vc: self)
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_.localizedLowercase, alertType: 0){_ in
        }
    }
    
    
}
