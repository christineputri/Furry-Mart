//
//  AdminSuccessViewController.swift
//  MMS_LecProject
//
//  Created by prk on 08/12/23.
//

import UIKit

class AdminSuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backHomeBtn(_ sender: Any) {
        if let nextView = self.storyboard?.instantiateViewController(identifier: "adminView") {
            let homeView = nextView as! AdminViewController
            self.navigationController?.setViewControllers([homeView], animated: true)
        }    }
}
