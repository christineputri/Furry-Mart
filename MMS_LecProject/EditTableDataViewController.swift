//
//  EditTableDataViewController.swift
//  MMS_LecProject
//
//  Created by prk on 08/12/23.
//

import UIKit
import CoreData

class EditTableDataViewController: UIViewController {
    
    @IBOutlet weak var titleUpdateData: UITextField!
    @IBOutlet weak var descUpdateData: UITextField!
    @IBOutlet weak var priceUpdateData: UITextField!
    @IBOutlet weak var categoryUpdateData: UITextField!
    @IBOutlet weak var imageUpdateData: UIImageView!
    
    var dataCellTable: dataItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("data dari prepare: \(String(describing: dataCellTable))")
        titleUpdateData.text = dataCellTable?.titleProduct ?? "Golden Retriever"
        descUpdateData.text = dataCellTable?.description ?? "pet"
        priceUpdateData.text = String(dataCellTable?.priceProduct ?? 1000)
        categoryUpdateData.text = dataCellTable?.categoryProduct.rawValue ?? CategoryPet.pet.rawValue
    }
    
    @IBAction func onSavedBtn(_ sender: Any) {
        // Memeriksa apakah semua bidang telah diisi
                guard let title = titleUpdateData.text, !title.isEmpty,
                      let desc = descUpdateData.text, !desc.isEmpty,
                      let priceTextField = priceUpdateData.text, let priceTextField = Double(priceTextField),
                      let category = categoryUpdateData.text, !category.isEmpty,
                      let _ = imageUpdateData.image else {
                    // Jika ada bidang yang belum diisi, tampilkan pesan kesalahan atau tindakan yang sesuai
                    showAlert(message: "Pease")
                    return
                }
                
                // Semua bidang telah diisi, lanjut ke Admin Success View Controller
                if let nextView = storyboard?.instantiateViewController(identifier: "success_page") {
                    let rootView = nextView as! AdminSuccessViewController
                    navigationController?.setViewControllers([rootView], animated: true)
                }
            }
            
            // Metode untuk menampilkan pesan kesalahan
            private func showAlert(message: String) {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
            
    }

