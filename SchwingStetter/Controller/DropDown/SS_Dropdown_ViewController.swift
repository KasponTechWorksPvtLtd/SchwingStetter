//
//  SS_Dropdown_ViewController.swift
//  SchwingStetter
//
//  Created by TestMac on 16/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

protocol DropdownDelegate: class {
    func selectedIndexWithItem(index: Int, item: String, tagVal: Int)
}


class SS_Dropdown_ViewController: UIViewController {

    
    weak var delegate: DropdownDelegate? = nil
    
    @IBOutlet weak var table_dropdown: UITableView!
    @IBOutlet weak var image_dropdown: UIImageView!
    @IBOutlet weak var lbl_nodata: UILabel!

    
    var ary_data: Array = [String]()
    var tagVal_ = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

     func addDropdownView(selectedView: UITextField,ary_data: [String], customView: UIView, mainView: UIView, vc: UIViewController){
        
        let cus_frm = customView.convert(selectedView.frame, to: mainView)
        
        let ddVC = SS_Utility.getStoryboardInstance().instantiateViewController(withIdentifier: SB_Identifier.DROPDOWNVC.rawValue) as! SS_Dropdown_ViewController
        ddVC.delegate = vc as? DropdownDelegate
        ddVC.ary_data = ary_data
        ddVC.tagVal_ = selectedView.tag
        ddVC.view.frame = CGRect(x: vc.view.frame.origin.x, y: vc.view.frame.origin.y, width: vc.view.frame.size.width, height: vc.view.frame.size.height)
        ddVC.table_dropdown.frame = CGRect(x: cus_frm.origin.x, y: cus_frm.origin.y  + 45, width: cus_frm.size.width, height: 200)
        ddVC.image_dropdown.frame = CGRect(x: cus_frm.origin.x, y: cus_frm.origin.y + 20, width: cus_frm.size.width, height: 250)
        ddVC.lbl_nodata.frame = CGRect(x: cus_frm.origin.x + 20, y: cus_frm.origin.y + 75, width: cus_frm.size.width - 30, height: 45)
        if(ary_data.count != 0){
            ddVC.table_dropdown.isHidden = false
            ddVC.lbl_nodata.isHidden = true
        }else{
            ddVC.table_dropdown.isHidden = true
            ddVC.lbl_nodata.isHidden = false
        }
        
        vc.view.addSubview(ddVC.view)
        vc.addChildViewController(ddVC)
    }
    
     func removeDropdownFromSuperView(vc: UIViewController){
        for item in vc.view.subviews {
            if(item.tag == TagVal.share.dropdownVC){
                item.removeFromSuperview()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("touches:- \(touches) \n event:- \(event!)")
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
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

extension SS_Dropdown_ViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  table_dropdown.dequeueReusableCell(withIdentifier: Cell_Identifier.cell_dropdown.rawValue) as! SS_Dropdown_TableCell
        //cell.lbl_title.sizeToFit()
        cell.lbl_title.text = ary_data[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedIndexWithItem(index: indexPath.row, item: ary_data[indexPath.row], tagVal: tagVal_)
    }
}

class SS_Dropdown_TableCell: UITableViewCell {
    @IBOutlet weak var lbl_title: UILabel!
    
}



