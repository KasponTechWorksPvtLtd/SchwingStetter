//
//  Utility.swift
//  SchwingStetter
//
//  Created by TestMac on 08/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import Foundation
import UIKit



class SS_Utility {
    
    //MARK:- CurrentDate
    static func getCurrentDateAndTime() -> String{
        let date_ = Date()
        let formatter_ = DateFormatter()
        formatter_.dateFormat = "yyyy-MM-dd" // HH:mm:ss
        return formatter_.string(from: date_)
    }
    
    //MARK:- Validating Textfields
    static func validateTestFields(textField: UITextField) -> Bool{
        var isValid = false
        
        switch textField.tag {
        case 1001:
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            isValid = emailTest.evaluate(with: textField.text) && !(textField.text?.isEmpty)!
        case 1002:
            return !(textField.text?.isEmpty)!
        default:
            isValid = false
        }
        
        return isValid
    }
    
    //MARK:- To Get iPhone Model
    static func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
    //MARK:- Get Header Height Based on iPhone Model
    static func getHeaderHeightBasedoniPhoneModel() -> CGFloat {
        //return SS_Utility.modelIdentifier() == SS_Utility.Device_Type_.iPhoneX.rawValue || SS_Utility.modelIdentifier() == SS_Utility.Device_Type_.iPhoneXR.rawValue ? 120 : 60
        let ary_deviceTypes = ["iPhone10,3", "iPhone10,6", "iPhone11,8", "iPhone11,6", "iPhone11,2", "iPhone11,4"]
        let isBool = ary_deviceTypes.contains(SS_Utility.modelIdentifier())
        return  isBool ? 90 : 60
        
    }
    //MARK:- Custome Alert Views
    static func showAlert(str_title: String, str_msg: String, alertType: Int, completion: @escaping (Bool) -> Void){
        let alert = UIAlertController(title: str_title, message: str_msg, preferredStyle: .alert)
        let action_ok = UIAlertAction(title: "OK", style: .default) { (alert_) in
            
            DispatchQueue.main.async {
                completion(true)
            }
            
        }
        
        let action_cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            completion(false)
        }
        if (alertType == 0) {
            alert.addAction(action_ok)
        }else{
            alert.addAction(action_ok)
            alert.addAction(action_cancel)
        }
        
        getRootVC().present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWithTextField(str_title: String, str_msg: String, alertType: Int,tagVal: Int, vc: UIViewController, completion: @escaping ((Bool, String)) -> Void){
        let alert = UIAlertController(title: str_title, message: str_msg, preferredStyle: .alert)
        let action_ok = UIAlertAction(title: "OK", style: .default) { (alert_) in
            
            guard let txtField = alert.textFields?[0] else {
                return
            }
            DispatchQueue.main.async {
                completion((true, txtField.text ?? ""))
            }
            
        }
        
        let action_cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            completion((false, ""))
        }
        
        alert.addTextField { (txtField) in
            txtField.delegate = (vc as! UITextFieldDelegate)
            txtField.keyboardType = .numberPad
            txtField.placeholder = "Select Number of RM plates"
            
        }
        if (alertType == 0) {
            alert.addAction(action_ok)
        }else{
            alert.addAction(action_ok)
            alert.addAction(action_cancel)
        }
        
        getRootVC().present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK:-
    static func getRootVC() -> UIViewController {
        
        guard var topVC = UIApplication.shared.keyWindow?.rootViewController else {
            return UIViewController()
        }
        while let  presentedVC = topVC.presentedViewController{
            topVC = presentedVC
        }
        
        return topVC
    }
    
    
    static func getStoryboardInstance() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func getDeviceToken() -> String{
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    static func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    static func showIndicator(vc: UIViewController){
        let indicator = getStoryboardInstance().instantiateViewController(withIdentifier: SB_Identifier.DEFAULTLOADERVC.rawValue) as! SS_DefaultLoaderViewController
        indicator.startAnimation()
        indicator.view.tag = 102
        vc.view.addSubview(indicator.view)
    }
    
    
    static func stopIndicator(vc: UIViewController){
        if let view = vc.view.viewWithTag(102){
            print("view1:- \(view)")
            view.removeFromSuperview()
        }
        
    }

    static func checkForDicNullValues(item_val: Any) -> Any {
        if let str1 = item_val as? String {
            return str1
        }else if let int1 = item_val as? Int {
            return int1
        }else if let int2 = item_val as? Double {
            return int2
        }else{
            return ""
        }
    }
    
    static func replaceNullValues(data_: Data) -> Data{
        var data_finalObj = Data()
        do{
            var json = try JSONSerialization.jsonObject(with: data_, options: []) as? [String : Any]
            if let aryOfDic = json![Keys_val.message_.rawValue] as? [[String: Any]]{
                var ary_dic = [[String: Any]]()
                for dicVal in aryOfDic {
                    var dic_ = [String: Any]()
                    
                    for item_ in dicVal {
                        if (item_.value is NSNull){
                            dic_[item_.key] = ""
                        }else{
                            dic_[item_.key] = item_.value
                        }
                    }
                    ary_dic.append(dic_)
                }
                json![Keys_val.message_.rawValue] = ary_dic
                data_finalObj = try JSONSerialization.data(withJSONObject: json!, options: [])
            }
            
        }catch (let erro_){
            print("\(erro_)")
        }
        return data_finalObj
    }
    
    static func MrtAckn_StoreStus(tagVal: Int) -> String {
        switch tagVal {
        case 1 : return Enum_MaterialStatusName.Material_Issued.rawValue//"Material Issued"
        case 2 : return Enum_MaterialStatusName.Partialy_issued.rawValue//"Partialy issued"
        case 3 : return Enum_MaterialStatusName.Material_damaged.rawValue//"Material damaged"
        default: return ""
        }
    }
    
    
    
    enum Enum_MaterialStatusName: String {
        case Material_Issued = "Material Issued"
        case Partialy_issued = "Partialy issued"
        case Material_damaged = "Material damaged"
        
       static  func returnMtrStatusTag(mrtStusNme: String) -> Int {
            switch mrtStusNme {
            case Enum_MaterialStatusName.Material_Issued.rawValue:
                return 1
            case Enum_MaterialStatusName.Partialy_issued.rawValue:
                return 2
            case Enum_MaterialStatusName.Material_damaged.rawValue:
                return 3
            default:
                break
            }
            return 0
        }
    }
    
    /*enum Device_Type_: String {
        case iPhoneX = "iPhone10,3"
        case iPhoneX_ = "iPhone10,6"
        case iPhoneXR = "iPhone11,8"
        case iPhoneXS = "iPhone11,6"
        case iPhoneXSMax = "iPhone11,2"
        case iPhoneXS_ = "iPhone11,4"
    }*/
    
    
    enum DrumClearance: String {
        case Spare = "Spare"
        case Assembly = "Assembly"
    }
    
    
    enum MaterialNameBasedOnID: String {
        case Drum = "Drum Model"
        case Mixer = "Mixer Assembly"
        case Mounting = "Mounting Model"
    }
    
    static func materialIssueNme(mrtID_: Int) -> String  {
        switch mrtID_ {
        case 1:
            return MaterialNameBasedOnID.Drum.rawValue
        case 2:
            return MaterialNameBasedOnID.Mixer.rawValue
        case 3:
            return MaterialNameBasedOnID.Mounting.rawValue
        default:
            return ""
        }
    }
    
    static func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude)) 
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}





extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector, tag_: Int) -> UIToolbar {
        //NSSearchPathForDirectoriesInDomains(<#T##directory: FileManager.SearchPathDirectory##FileManager.SearchPathDirectory#>, <#T##domainMask: FileManager.SearchPathDomainMask##FileManager.SearchPathDomainMask#>, <#T##expandTilde: Bool##Bool#>)
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
        doneButton.tag = tag_
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        //var str_ = "hi"
        //print("str_:- \(str_)")
        return toolBar
    }
    
}

extension UIDatePicker{
    func customDatePickerType(mySelector: Selector) -> UIDatePicker {
        let datePickView: UIDatePicker = UIDatePicker()
        datePickView.datePickerMode = .date
        datePickView.addTarget(self, action: mySelector, for: .allEvents)//valueChanged
        
        return datePickView
    }
}


@IBDesignable
class Custom_RoundedView: UIView {
    @IBInspectable var cus_cornerRadius: Double {
        get{
            return Double(self.layer.frame.width / 2.0)
        }
        set{
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
}

@IBDesignable
class Custom_RoundedBtn: UIButton {
    @IBInspectable var cus_cornerRadius: Double {
        get{
            return Double(self.layer.frame.width / 2.0)
        }
        set{
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
}

@IBDesignable
class Custom_RoundedImage: UIImageView {
    @IBInspectable var cus_boarderWidth: Double{
        get{
            return Double(self.layer.frame.width / 2.0)
        }
        set{
            self.layer.borderColor = UIColor.green.cgColor
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
}
