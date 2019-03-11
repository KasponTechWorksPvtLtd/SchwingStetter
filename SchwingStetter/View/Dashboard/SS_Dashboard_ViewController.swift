//
//  SS_Dashboard_ViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 09/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_Dashboard_ViewController: UIViewController {
    var str_1 :String = "first"

    @IBOutlet weak var colle_dash: UICollectionView!
    @IBOutlet weak var constr_headerView_hei: NSLayoutConstraint!
    
    let ary_details = ["Production plan", "CNC Approvals", "Material Acknowledgement", "Line Rejection", "Drum Clearance", "Snag / Delay / Rework details"]//"Dashboard", "Mounting completion"
    let ary_images = [ #imageLiteral(resourceName: "Production"),#imageLiteral(resourceName: "CNCApprove"), #imageLiteral(resourceName: "MaterialAcknow"), #imageLiteral(resourceName: "LineRejected"), #imageLiteral(resourceName: "Drum_Cleara"), #imageLiteral(resourceName: "Rework"), #imageLiteral(resourceName: "Mounting")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        /*print("str_1:- \(str_1), strrt:- \(strrt)")
        
        str_1 = strrt
        print("str_1:- \(str_1), strrt:- \(strrt)")
        
        strrt = "Third"
        print("str_1:- \(str_1), strrt:- \(strrt)")
        
        let aryInt = [5, 6, 7, 8, 9]
        print("aryIteration:- \(aryInt)")*/
        
        
        constr_headerView_hei.constant = SS_Utility.getHeaderHeightBasedoniPhoneModel()
       
    }

  
    //MARK:- Button ACtion
    
    @IBAction func backBtnClicked(){
        SS_Utility.showAlert(str_title: "Alert", str_msg: "Click ok to logout", alertType: 1, completion: {res in
            if(res == true){
                SingleTone.share.login = Login()
                self.navigationController?.popViewController(animated: true)
            }
        })
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


extension SS_Dashboard_ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
             return CGSize(width: colle_dash.frame.width / 3-(40/3), height: colle_dash.frame.width / 3)
        }
        else
        {
            // Iphone
             return CGSize(width: colle_dash.frame.width / 2-15, height: colle_dash.frame.width / 2-15)
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ary_details.count //9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colle_dash?.dequeueReusableCell(withReuseIdentifier: Cell_Identifier.cell_dashboard.rawValue, for: indexPath) as! SS_Dashboard_CollCell
        cell.lbl_nme.text = ary_details[indexPath.row]
        cell.img_icon.image = ary_images[indexPath.row]
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.cornerRadius = 8.0
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var vc = UIViewController()
        switch indexPath.item {
        /*case 0:
            SS_Utility.showAlert(str_title: "Message", str_msg: "Under Development", alertType: 0, completion: {_ in
                if !SingleTone.share.login.data!.isEmpty {
                    print("SingleTone.share.login:- \(SingleTone.share.login.data![0].email!)")
                }

           })*/
            
        case 0:
            vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.PRODUCPLANVC.rawValue) as! SS_ProdPlan_ViewController
        case 1:
            vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.CNCAPPROVALVC.rawValue) as! SS_CNCApprove_ViewController

        case 2:
            vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.MATERIALSTATUSVC.rawValue) as! SS_MaterialStatus_ViewController

        case 3:
            vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.LINEREJECTVC.rawValue) as! SS_LineReject_ViewController
            
        case 4:
            vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.DRUMCLEARANCEVC.rawValue) as! SS_DrumClear_ViewController

        case 5:
            vc = storyboard?.instantiateViewController(withIdentifier: SB_Identifier.DELAYSNAGVC.rawValue) as! SS_SnagDelayRework_ViewController

        case 6:
            SS_Utility.showAlert(str_title: "Message", str_msg: "Under Development", alertType: 0, completion: {_ in
                
            })
        default:
            SS_Utility.showAlert(str_title: "Message", str_msg: "Under Development", alertType: 0, completion: {_ in
                
            })
            
        }
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension SS_Dashboard_ViewController {
    
    var strrt: String{
        get{
            return "second"
        }
        set{
            str_1 = newValue
        }
    }
}
