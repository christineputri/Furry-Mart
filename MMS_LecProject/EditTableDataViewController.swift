import UIKit
import CoreData

class EditTableDataViewController: UIViewController {
    
    @IBOutlet weak var titleUpdateData: UITextField!
    @IBOutlet weak var descUpdateData: UITextField!
    @IBOutlet weak var priceUpdateData: UITextField!
    @IBOutlet weak var categoryUpdateData: UITextField!
    @IBOutlet weak var imageUpdateData: UIImageView!
    
    var dataCellTable: dataItem?
    var updateCallback: ((dataItem) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("data dari prepare: \(String(describing: dataCellTable))")
        titleUpdateData.text = dataCellTable?.titleProduct ?? "Golden Retriever"
        descUpdateData.text = dataCellTable?.description ?? "pet"
        priceUpdateData.text = String(dataCellTable?.priceProduct ?? 1000)
        categoryUpdateData.text = dataCellTable?.categoryProduct.rawValue ?? CategoryPet.pet.rawValue
    }
    
    @IBAction func onSavedBtn(_ sender: Any) {
        guard let title = titleUpdateData.text, !title.isEmpty,
              let desc = descUpdateData.text, !desc.isEmpty,
              let priceTextField = priceUpdateData.text, let price = Int(priceTextField),
              let category = categoryUpdateData.text, !category.isEmpty else {
            showAlert(message: "Error data saved")
            return
        }
        
        // Update properties of dataCellTable
        dataCellTable?.titleProduct = title
        dataCellTable?.description = desc
        dataCellTable?.priceProduct = Int(price)
        dataCellTable?.categoryProduct = CategoryPet(rawValue: category) ?? .pet
        dataCellTable?.imageProduct = "golden-retreiver"
        
        //        if let nextView = storyboard?.instantiateViewController(identifier: "success_page") {
        //            let rootView = nextView as! AdminSuccessViewController
        //            navigationController?.setViewControllers([rootView], animated: true)
        //        }
        // Call the update callback with the updated data
        updateCallback?(dataCellTable!)
        
    }
            
            // Metode untuk menampilkan pesan kesalahan
            private func showAlert(message: String) {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
            
    }

