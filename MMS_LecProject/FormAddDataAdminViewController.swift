//
//  FormAddDataAdminViewController.swift
//  MMS_LecProject
//
//  Created by prk on 08/12/23.
//

import UIKit
import CoreData

class FormAddDataAdminViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    var delegate: controlPetProduct?
    
    var arrPetProduct = [dataItem]()
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var imageProduct: UIImageView!
    var imageTemp = "husky"
    
    @IBAction func addDataToDatabase(_ sender: Any) {
        if(titleTextField.text!.isEmpty && descriptionTextField.text!.isEmpty && (Int(priceTextField.text!) ?? 0 <= 0) && categoryTextField.text!.isEmpty){
            let alert = UIAlertController(title: "Alert", message: "title, category, price, and description field must be filled", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ok", style: .default)
            alert.addAction(alertAction)
            present(alert, animated: true)
        }
        else{
            createData()
            if let nextView = storyboard?.instantiateViewController(identifier: "success_page") {
                let rootView = nextView as! AdminSuccessViewController
                navigationController?.setViewControllers([rootView], animated: true)
            }
        }
    }
    
    func createData() {
        let title = titleTextField.text!
        let description = descriptionTextField.text!
        let price = Int(priceTextField.text ?? "1000")
        let category = categoryTextField.text!
        let image = "husky"
        
        let entity = NSEntityDescription.entity(forEntityName: "PetProduct", in: context)
        let newPetProduct = NSManagedObject(entity: entity!, insertInto: context)
        newPetProduct.setValue(title, forKey: "productName")
        newPetProduct.setValue(description, forKey: "productDesc")
        newPetProduct.setValue(price, forKey: "productPrice")
        newPetProduct.setValue(category, forKey: "productCategory")
        newPetProduct.setValue(image, forKey: "productImage")
        
        do {
            try context.save()
            self.delegate?.loadData()
        } catch {
            print("Data creation failed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageProduct.layer.masksToBounds = false
        self.imageProduct.clipsToBounds = true
        tapGesture()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageProduct.isUserInteractionEnabled = true
        imageProduct.addGestureRecognizer(tap)
    }
    
    @objc func imageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageProduct.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
