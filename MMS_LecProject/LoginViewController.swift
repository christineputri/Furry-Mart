//
//  LoginViewController.swift
//  MMS_LecProject
//
//  Created by prk on 07/12/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func moveToRegister(_ sender: Any) {
        if let nextView = storyboard?.instantiateViewController(identifier: "registerView") {
            let registerView = nextView as! RegisterViewController
            navigationController?.setViewControllers([registerView], animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
