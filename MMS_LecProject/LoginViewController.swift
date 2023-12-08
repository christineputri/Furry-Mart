//import UIKit
//import CoreData
//
//class LoginViewController: UIViewController {
//
//    var userData: [userdata] = []
//    var context: NSManagedObjectContext!
//
//    @IBOutlet weak var emailFieldLogin: UITextField!
//    @IBOutlet weak var passwordFieldLogin: UITextField!
//    @IBAction func loginBtn(_ sender: Any) {
//        userFetchData()
//
//        let email = emailFieldLogin.text
//        let password = passwordFieldLogin.text
//
//        if email!.isEmpty || password!.isEmpty {
//            alertAction(title: "Warning", message: "Field must be filled")
//        }
//
//        for user in userData {
//            if (user.email != email || user.password != password){
//                alertAction(title: "Invalid Credential", message: "Email or Password is wrong")
//            }
//        }
//    }
//
//    @IBAction func moveToRegister(_ sender: Any) {
//        if let nextView = storyboard?.instantiateViewController(identifier: "registerView") {
//            let registerView = nextView as! RegisterViewController
//            navigationController?.setViewControllers([registerView], animated: true)
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        context = appDelegate.persistentContainer.viewContext
//    }
//
//    func userFetchData(){
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        do{
//            let results = try context.fetch(request) as! [NSManagedObject]
//            for data in results{
//                userData.append(userdata(
//                    name: data.value(forKey: "name") as! String,
//                    email: data.value(forKey: "email") as! String,
//                    password: data.value(forKey: "password") as! String))
//            }
//            print("fetching successful")
//        }catch{
//            print("fetching failed")
//        }
//    }
//
//
//    func alertAction(title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
//        alertController.addAction(okAction)
//        present(alertController, animated: true, completion: nil)
//    }
//}


import UIKit
import Firebase
import CoreData

class LoginViewController: UIViewController {

    var userData: [String] = []
    var context: NSManagedObjectContext!

    @IBOutlet weak var emailFieldLogin: UITextField!
    @IBOutlet weak var passwordFieldLogin: UITextField!
    
    
//    handle = Auth.auth().addStateDidChangeListener { auth, user in
//      // ...
//    }

    @IBAction func loginBtn(_ sender: Any) {
        let email = emailFieldLogin.text
        let password = passwordFieldLogin.text

        if email!.isEmpty || password!.isEmpty {
            alertAction(title: "Warning", message: "Field must be filled")
            return
        }

//        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
//            guard let self = self else { return }
//
//            if let error = error {
//                self.alertAction(title: "Login Error", message: error.localizedDescription)
//            } else {
//                if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
//                   let userData = appDelegate.userData {
//                    // Use userData as needed, for example, pass it to another view controller
//                    print("Logged in with user data:", userData)
//                }
//
//                // Navigate to the main app screen or perform any other necessary action
//            }
//        }
    }

    @IBAction func moveToRegister(_ sender: Any) {
        if let nextView = storyboard?.instantiateViewController(identifier: "registerView") {
            let registerView = nextView as! RegisterViewController
            navigationController?.setViewControllers([registerView], animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
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
}
