//
//  CustomerViewController.swift
//  MMS_LecProject
//
//  Created by prk on 08/12/23.
//

import UIKit

class CustomerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var totalQuantity: Int = 0
    var totalPrice: Double = 0.0
    
    @IBOutlet weak var namaCustomer: UILabel!
    var nama: String?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductsTableViewCell
        cell.itemTitleProduct.text = arr[indexPath.row].titleProduct
        cell.itemCategoryProduct.text = arr[indexPath.row].categoryProduct.rawValue
        cell.itemDetailProduct.text = arr[indexPath.row].description
        cell.itemPriceProduct.text = "Rp. \(arr[indexPath.row].priceProduct)"
        cell.itemImageProduct.image = UIImage(named: arr[indexPath.row].imageProduct)
        
        return cell
    }
    
    @IBOutlet weak var tableViewCustomer: UITableView!
    var arr: [dataItem] = []
    
    func initData(){
        arr.append(dataItem(priceProduct: 2000000, titleProduct: "Golden Retriever", categoryProduct: CategoryPet.pet, description: "Family Friendly Dog", imageProduct: "golden-retriever"))
        arr.append(dataItem(priceProduct: 70000, titleProduct: "Pedigree", categoryProduct: CategoryPet.food, description: "Dry Food for Dog", imageProduct: "pedigree"))
        arr.append(dataItem(priceProduct: 30000, titleProduct: "Daily Probiotics", categoryProduct: CategoryPet.medicine, description: "For Dogs of All Sizes", imageProduct: "dog-vitamin"))
        arr.append(dataItem(priceProduct: 12000, titleProduct: "Growppy", categoryProduct: CategoryPet.drink, description: "Milk for Dog", imageProduct: "dog-milk"))
        arr.append(dataItem(priceProduct: 27000, titleProduct: "Nail Clipper", categoryProduct: CategoryPet.tools, description: "Pet Nail Clipper", imageProduct: "gunting-kuku"))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        tableViewCustomer.dataSource = self
        tableViewCustomer.delegate = self
        namaCustomer.text = "Hello, User \(nama!)"
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        //self.navigationController?.popToRootViewController(animated: true)
        if let nextView = storyboard?.instantiateViewController(identifier: "rootView") {
            let rootView = nextView as! ViewController
            navigationController?.setViewControllers([rootView], animated: true)
        }
    }
}

