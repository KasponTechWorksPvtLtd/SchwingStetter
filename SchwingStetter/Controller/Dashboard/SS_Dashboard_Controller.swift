//
//  SS_Dashboard_Controller.swift
//  SchwingStetter
//
//  Created by TestMac on 16/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_Dashboard_Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

class SS_Dashboard_CollCell: UICollectionViewCell{
    @IBOutlet weak var view_bg: UIView!
    @IBOutlet weak var img_icon: UIImageView!
    @IBOutlet weak var lbl_nme: UILabel!
    
}
