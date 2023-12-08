//
//  RegisterViewController.swift
//  MMS_LecProject
//
//  Created by prk on 07/12/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    var arrUser: [String] = []
    var context: NSManagedObjectContext!

    @IBOutlet weak var nameFieldRegister: UITextField!
    @IBOutlet weak var emailFieldRegister: UITextField!
    @IBOutlet weak var passwordFieldRegister: UITextField!
    @IBOutlet weak var confPassFieldRegister: UITextField!
    
    @IBAction func registerBtn(_ sender: Any) {
        userFetchData()
        
        let username = nameFieldRegister.text
        let email = emailFieldRegister.text
        let password = passwordFieldRegister.text
        let confpass = confPassFieldRegister.text
        
        if username!.isEmpty || email!.isEmpty || password!.isEmpty || confpass!.isEmpty {
            alertAction(title: "Warning", message: "Field must be filled")
        }
    }
    
    @IBAction func moveToLogin(_ sender: Any) {
        if let nextView = storyboard?.instantiateViewController(identifier: "loginView") {
            let loginView = nextView as! LoginViewController
            navigationController?.setViewControllers([loginView], animated: true)
        }
    }
    
    func userFetchData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            for data in result {
                arrUser.append(data.value(forKey: "email") as! String)
            }
        } catch {
            print("Data fetch failed")
        }
    }
    
    func alertAction(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
}
