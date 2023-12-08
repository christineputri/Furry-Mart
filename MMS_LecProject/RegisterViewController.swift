//import UIKit
//import CoreData
//
//class RegisterViewController: UIViewController {
//
//    var userData: [String] = []
//    var context: NSManagedObjectContext!
//
//    @IBOutlet weak var nameFieldRegister: UITextField!
//    @IBOutlet weak var emailFieldRegister: UITextField!
//    @IBOutlet weak var passwordFieldRegister: UITextField!
//    @IBOutlet weak var confPassFieldRegister: UITextField!
//
//    @IBAction func registerBtn(_ sender: Any) {
//        userFetchData()
//
//        let username = nameFieldRegister.text
//        let email = emailFieldRegister.text
//        let password = passwordFieldRegister.text
//        let confpass = confPassFieldRegister.text
//
//        if username!.isEmpty || email!.isEmpty || password!.isEmpty {
//            alertAction(title: "Warning", message: "Field must be filled")
//        }
//
//        if username!.count <= 2 {
//            alertAction(title: "Warning", message: "Name must be more than 2 characters")
//        }
//
//        if email!.count <= 4 {
//            alertAction(title: "Warning", message: "Email must be more than 4 characters")
//        }
//
//        if !(email!.contains("@") && email!.hasSuffix(".com")) {
//            alertAction(title: "Warning", message: "Email must contain @ and ended with .com")
//        }
//
//        if password!.count <= 5 {
//            alertAction(title: "Warning", message: "Password must be more than 5 characters")
//        }
//
//        do {
//            let valid = try password!.contains(Regex("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{5,}$"))
//
//            if !valid {
//                alertAction(title: "Warning", message: "Password must be at least 1 alphabet and 1 number")
//            }
//        } catch {
//            print("password error")
//        }
//
//        if confpass != password {
//            alertAction(title: "Warning", message: "Password didn't match")
//        }
//
//        let dataSaved = NSEntityDescription.entity(forEntityName: "User", in: context)
//        if (dataSaved != nil) {
//            let newData = NSManagedObject(entity: dataSaved!, insertInto: context)
//            newData.setValue(email, forKey: "email")
//            newData.setValue(username, forKey: "name")
//            newData.setValue(password, forKey: "password")
//        }
//
//        do{
//            try context.save()
//            print("save Success")
//        } catch {
//            print("register error")
//        }
//
//        if let nextView = storyboard?.instantiateViewController(identifier: "loginView") {
//            let loginView = nextView as! LoginViewController
//            navigationController?.setViewControllers([loginView], animated: true)
//        }
//
//    }
//
//    @IBAction func moveToLogin(_ sender: Any) {
//        if let nextView = storyboard?.instantiateViewController(identifier: "loginView") {
//            let loginView = nextView as! LoginViewController
//            navigationController?.setViewControllers([loginView], animated: true)
//        }
//    }
//
//    func userFetchData() {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        do {
//            let result = try context.fetch(request) as! [NSManagedObject]
//            for data in result {
//                userData.append(data.value(forKey: "email") as! String)
//            }
//        } catch {
//            print("Data fetch failed")
//        }
//    }
//
//    func alertAction(title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
//        alertController.addAction(okAction)
//        present(alertController, animated: true, completion: nil)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        context = appDelegate.persistentContainer.viewContext
//    }
//}


import UIKit
import CoreData
import Firebase

class RegisterViewController: UIViewController {

    var userData: [String] = []
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

        if username!.isEmpty || email!.isEmpty || password!.isEmpty {
            alertAction(title: "Warning", message: "Field must be filled")
            return
        }

        if username!.count <= 2 {
            alertAction(title: "Warning", message: "Name must be more than 2 characters")
            return
        }

        if email!.count <= 4 {
            alertAction(title: "Warning", message: "Email must be more than 4 characters")
            return
        }

        if !(email!.contains("@") && email!.hasSuffix(".com")) {
            alertAction(title: "Warning", message: "Email must contain @ and end with .com")
            return
        }

        if password!.count <= 5 {
            alertAction(title: "Warning", message: "Password must be more than 5 characters")
            return
        }

        do {
            let valid = try password!.contains(Regex("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{5,}$"))

            if !valid {
                alertAction(title: "Warning", message: "Password must have at least 1 alphabet and 1 number")
                return
            }
        } catch {
            print("password error")
        }

        if confpass != password {
            alertAction(title: "Warning", message: "Passwords didn't match")
            return
        }

        // Authentication using Firebase
        guard let email = emailFieldRegister.text,
              let password = passwordFieldRegister.text else {
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [self] (firebaseResult, error) in
            if let e = error {
                print("Firebase authentication error: \(e.localizedDescription)")
                // Handle authentication error (e.g., show an alert)
                return
            } else {
                // Authentication successful, continue with your registration logic

                // Store user data in the AppDelegate
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.userData = [
                        "name": username!,
                        "email": email,
                        "password": password
                    ]
                }

                if let dataSaved = NSEntityDescription.entity(forEntityName: "User", in: self.context) {
                    let newData = NSManagedObject(entity: dataSaved, insertInto: self.context)
                    newData.setValue(email, forKey: "email")
                    newData.setValue(username, forKey: "name")
                    newData.setValue(password, forKey: "password")
                }

                do {
                    try self.self.context.save()
                    print("Save Success")
                } catch {
                    print("Register error: \(error.localizedDescription)")
                }

                if let nextView = storyboard?.instantiateViewController(identifier: "loginView") {
                    let loginView = nextView as! LoginViewController
                    navigationController?.setViewControllers([loginView], animated: true)
                }
            }
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
                userData.append(data.value(forKey: "email") as! String)
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

