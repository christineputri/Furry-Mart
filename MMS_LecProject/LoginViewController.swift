import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    var userData: [userdata] = []
    var context: NSManagedObjectContext!

    @IBOutlet weak var emailFieldLogin: UITextField!
    @IBOutlet weak var passwordFieldLogin: UITextField!
    @IBAction func loginBtn(_ sender: Any) {
        userFetchData()
        
        let email = emailFieldLogin.text
        let password = passwordFieldLogin.text
        
        if email!.isEmpty || password!.isEmpty {
            alertAction(title: "Warning", message: "Field must be filled")
        }
        
        for user in userData {
            if (user.email != email || user.password != password){
                alertAction(title: "Invalid Credential", message: "Email or Password is wrong")
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
    
    func userFetchData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do{
            let results = try context.fetch(request) as! [NSManagedObject]
            for data in results{
                userData.append(userdata(
                    name: data.value(forKey: "name") as! String,
                    email: data.value(forKey: "email") as! String,
                    password: data.value(forKey: "password") as! String))
            }
            print("fetching successful")
        }catch{
            print("fetching failed")
        }
    }
        
        
    func alertAction(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
