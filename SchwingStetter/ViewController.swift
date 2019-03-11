//
//  ViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 08/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img_dyn: UIImageView!
    @IBOutlet weak var lbl_dyn: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
      
        print("launch screen")
        //www.sclftp.com/theme/Assets/Img/Logo/harita_White_logo.png
                let userdefaul_ = UserDefaults.standard
                userdefaul_.set("", forKey: "DynamicLogo")
                //var img_dynamic = UIImageView()
                //img_dynamic.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                //img_dynamic.contentMode  = .scaleAspectFill
                if let img_data = userdefaul_.data(forKey: "DynamicLogo") {
                    img_dyn.image = UIImage(data: img_data)
                }else{
                   img_dyn = UIImageView(image: #imageLiteral(resourceName: "logo2"))
                    lbl_dyn.text = "TVS Clyton"
                }
        
       
    
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.splashTimeOut(sender:)), userInfo: nil, repeats: false)

        
        /*getWebservice(str_methodName: MethodNames.share.companyList, callBack: {
            guard let content = $0["companies"] else{
                return
            }
            print("dicVal:- \(content)")
           
            })
        
        getWebservice(str_methodName: MethodNames.share.recordList, callBack: {
            guard let content = $0["notice_list"] else{
                return
            }
            print("dicVal:- \(content)")
          
        })
        
        getWebservice(str_methodName: MethodNames.share.movieList, callBack: {
            guard let content = $0["movie_list"] else{
                return
            }
            print("dicVal:- \(content)")
      
        })
        
        getWebservice(str_methodName: MethodNames.share.movieList){obj_1 in
            guard let content = obj_1["movie_list"] else{
                return
            }
            print("dicVal:- \(content)")
            
        }*/
        
        
    }

    @objc func splashTimeOut(sender : Timer){
        let vc_login = self.storyboard?.instantiateViewController(withIdentifier: SB_Identifier.LOGINVC.rawValue) as! SS_LoginViewController
      //  AppDelegate.sharedInstance().window?.rootViewController = vc_login
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }


}


