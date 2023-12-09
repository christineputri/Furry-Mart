import UIKit
import CoreData
import Firebase

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

        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                self.alertAction(title: "Login Error", message: error.localizedDescription)
            } else {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                   let userData = appDelegate.userData {
                    print("Logged in with user data:", userData)
                }
            }
            
            if let nextView = self.storyboard?.instantiateViewController(identifier: "adminView") {
                let homeView = nextView as! AdminViewController
                self.navigationController?.setViewControllers([homeView], animated: true)
            }
        }

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
