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
        navigateToAwal()
    }
    
    private func navigateToAwal() {
            if let ViewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") {
                navigationController?.pushViewController(ViewController, animated: true)
            }
        }
}
