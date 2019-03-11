//
//  SS_DefaultLoaderViewController.swift
//  SchwingStetter
//
//  Created by Ramesh Ponnuvel on 08/11/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit

class SS_DefaultLoaderViewController: UIViewController {

    
    @IBOutlet weak var activityIndi = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activityIndi?.startAnimating()
        
    }
    
     func startAnimation() {
        activityIndi?.startAnimating()
    }
    
     func stopAnimation() {
        activityIndi?.stopAnimating()
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
