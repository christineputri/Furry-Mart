import UIKit
import CoreData

protocol controlPetProduct {
   func loadData()
}


class AdminViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, controlPetProduct {
    
    @IBOutlet weak var namaAdmin: UILabel!
    var context: NSManagedObjectContext!
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
    // bikin delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle{
        return.delete
    }
    
    func tableView(_ tableView:UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        tableView.beginUpdates()
        arr.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
          
    @IBOutlet weak var tableViewAdmin: UITableView!
    
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
    
    func loadData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PetProduct")
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            
            for data in result {
                arr.append(dataItem(
                    priceProduct: data.value(forKey: "productPrice") as? Int ?? 1000,
                    titleProduct: data.value(forKey: "productName") as! String,
                    categoryProduct: CategoryPet(rawValue: data.value(forKey: "productCategory") as! CategoryPet.RawValue) ?? CategoryPet.pet,
                    description: data.value(forKey: "productDesc") as! String,
                    imageProduct: data.value(forKey: "productImage") as! String))
            }
            tableViewAdmin.reloadData()
        } catch {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        tableViewAdmin.dataSource = self
        tableViewAdmin.delegate = self
        namaAdmin.text = "Hello, Admin"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        tableViewAdmin.delegate = self
        tableViewAdmin.dataSource = self
        
        loadData()
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        //self.navigationController?.popToRootViewController(animated: true)
        if let nextView = storyboard?.instantiateViewController(identifier: "registerView") {
            let rootView = nextView as! RegisterViewController
            navigationController?.setViewControllers([rootView], animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "edit_cell") as? EditTableDataViewController{
            vc.dataCellTable = arr[indexPath.row]
            vc.updateCallback = { updatedDataItem in
                        // Update your array with the modified data item
                self.arr[indexPath.row] = updatedDataItem

                        // Reload the row after the data has been updated
                        tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
            self.navigationController?.pushViewController(vc, animated: true)
            loadData()
        }
    }
}
