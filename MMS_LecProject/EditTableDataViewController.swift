//
//  EditTableDataViewController.swift
//  MMS_LecProject
//
//  Created by prk on 08/12/23.
//

import UIKit

class EditTableDataViewController: UIViewController {
    
    @IBOutlet weak var titleUpdateData: UITextField!
    @IBOutlet weak var descUpdateData: UITextField!
    @IBOutlet weak var priceUpdateData: UITextField!
    @IBOutlet weak var categoryUpdateData: UITextField!
    @IBOutlet weak var imageUpdateData: UIImageView!
    @IBAction func onSavedBtn(_ sender: Any) {
        
    }
    var dataCellTable: dataItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("data dari prepare: \(String(describing: dataCellTable))")
        titleUpdateData.text = dataCellTable?.titleProduct ?? "Mobile Legend"
        descUpdateData.text = dataCellTable?.description ?? "game FPS"
        priceUpdateData.text = String(dataCellTable?.priceProduct ?? 1000)
        categoryUpdateData.text = dataCellTable?.categoryProduct.rawValue ?? CategoryGame.FPS.rawValue
    }
}
