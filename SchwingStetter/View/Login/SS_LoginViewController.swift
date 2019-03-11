//
//  SS_LoginViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 09/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_LoginViewController: UIViewController {

    
    @IBOutlet weak var txt_usn: UITextField!
    @IBOutlet weak var txt_pwd: UITextField!
    @IBOutlet weak var scroll_login: UIScrollView!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_visible: UIButton!

    var dicVal = [String: Any]()
    var str_teo = "someVal"
    
    var str_one: String{
        get{
            return str_teo
        }
        set{
            str_teo = newValue
        }
    }
    var str_val:  String? = "HI"

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // shiftengg@schwingstetterindia.com
       // Admin@123
        
        txt_usn.setLeftPaddingPoints(5)
        txt_usn.setRightPaddingPoints(10)
        txt_pwd.setLeftPaddingPoints(5)
        txt_pwd.setRightPaddingPoints(35)
        
        //str_val = "dfdf"
        print(str_val)
        // Do any additional setup after loading the view.
        
        /* print("str_one:- \(str_one)  \(str_teo) ")
        str_one = "testing"
        print("str_one_After:- \(str_one)  \(str_teo)")

        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.allLibrariesDirectory, FileManager.SearchPathDomainMask.userDomainMask, false)
        print("paths:- \(paths)")*/
        
        enumTestingString(strVal: testingString.string3.hashValue)
        if ((txt_usn.text?.isEmpty)! || (txt_pwd.text?.isEmpty)!) {
            btn_login.isUserInteractionEnabled = false
            btn_login.layer.opacity = 0.5}
    }

    override func viewWillAppear(_ animated: Bool) {
        /*if SingleTone.share.login.data!.count > 0 {
            print("SingleTone.share.login:- \(SingleTone.share.login.data![0].email!)")
        }*/

    }
    
    func enumTestingString(strVal: Int) {
        print("strVal:- \(strVal)")
    }
    
    //MARK:- Login Buttion Action
    
    @IBAction func loginBtnClicked(){
        if(SS_Utility.validateTestFields(textField: txt_usn) && SS_Utility.validateTestFields(textField: txt_pwd)){
          SS_Utility.showIndicator(vc: self)
            isLoginUrl = true
            self.txt_pwd.resignFirstResponder()
            let loginController = SS_LoginController()
            loginController.delegate_login = self
            loginController.userLogin(txt_usn_: txt_usn.text!, txt_pwd_: txt_pwd.text!)
           
        }else{
            if(txt_usn.text?.isEmpty)!{
                SS_Utility.showAlert(str_title: "Alert", str_msg: "Username should not be empty", alertType: 0, completion: {_ in
                    SS_Utility.stopIndicator(vc: self)
                })
            }  else if(!SS_Utility.validateTestFields(textField: txt_usn)){
                SS_Utility.showAlert(str_title: "Alert", str_msg: "Please enter valid email id.", alertType: 0, completion: {_ in
                    SS_Utility.stopIndicator(vc: self)
                })
            } else if(txt_pwd.text?.isEmpty)!{
                SS_Utility.showAlert(str_title: "Alert", str_msg: "Password should not be empty", alertType: 0, completion: {_ in
                    SS_Utility.stopIndicator(vc: self)
                })
            }
        }
    }
    
    @IBAction func forgotPwdCliked(){
        let vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.FORGOTPWDVC.rawValue) as! SS_ForgotPwdViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnVisibleClicked(sender: UIButton){
        
        if (btn_visible.isSelected) {
            btn_visible.isSelected = false
            txt_pwd.isSecureTextEntry = true
            btn_visible.setImage(#imageLiteral(resourceName: "visible"), for: UIControlState.normal)
            
        }else{
            btn_visible.isSelected = true
            txt_pwd.isSecureTextEntry = false
            btn_visible.setImage(#imageLiteral(resourceName: "blind"), for: UIControlState.normal)
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


extension SS_LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_usn{
            txt_pwd.becomeFirstResponder()
        }else if(textField == txt_pwd){
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let rect = textField.convert(textField.bounds, to: scroll_login)
        var pt = rect.origin
        pt.x = 0
        pt.y -= 100
        self.scroll_login?.setContentOffset(pt, animated: true)
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let rect = textField.convert(textField.bounds, to: scroll_login)
        var pt = rect.origin
        pt.x = 0
        pt.y = 0
        self.scroll_login?.setContentOffset(pt, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //if ((txt_usn.text?.isEmpty)! || (txt_pwd.text?.isEmpty)!) {
        if(range.location == 0)  {
            btn_login.isUserInteractionEnabled = false
            btn_login.layer.opacity = 0.5
        }else{
            btn_login.isUserInteractionEnabled = true
            btn_login.layer.opacity = 1
        }
        
        return true
    }
}


extension SS_LoginViewController: LoginResponseDelegate {
    
    func successResponse(loginObj: Login) {
        SS_Utility.stopIndicator(vc: self)
        if (loginObj.responseCode == 1) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: SB_Identifier.DASHBOARDVC.rawValue) as! SS_Dashboard_ViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            SS_Utility.showAlert(str_title: "Alert", str_msg: loginObj.responseMessage!, alertType: 0, completion: {_ in
                
            })
            //"Kindly enter valid username and password"
        }
    }
    
    func errorResponse(error_: String) {
        SS_Utility.showAlert(str_title: "Alert", str_msg: error_, alertType: 0, completion: {_ in
            SS_Utility.stopIndicator(vc: self)
            
        })
        //convertStringToDictionary(text: resObj as! String)![Keys_val.share.Message] as! String
    }
    
    
}
