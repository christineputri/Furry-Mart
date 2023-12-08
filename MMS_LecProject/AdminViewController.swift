import UIKit
import CoreData

protocol controlGameProduct {
   func loadData()
}


class AdminViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, controlGameProduct {
    
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
    
    @IBOutlet weak var tableViewAdmin: UITableView!
    
    var arr: [dataItem] = []
    
    func initData(){
        arr.append(dataItem(priceProduct: 2000, titleProduct: "Mobile Legend", categoryProduct: CategoryGame.FPS, description: "Family Friendly Game", imageProduct: "mobile_legend"))
        arr.append(dataItem(priceProduct: 5000, titleProduct: "Mobile Legend", categoryProduct: CategoryGame.FPS, description: "Family Friendly Game", imageProduct: "mobile_legend"))
        arr.append(dataItem(priceProduct: 7000, titleProduct: "Mobile Legend", categoryProduct: CategoryGame.FPS, description: "Family Friendly Game", imageProduct: "mobile_legend"))
        arr.append(dataItem(priceProduct: 27000, titleProduct: "Mobile Legend", categoryProduct: CategoryGame.FPS, description: "Family Friendly Game", imageProduct: "mobile_legend"))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func loadData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameProduct")
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            
            for data in result {
                arr.append(dataItem(priceProduct: data.value(forKey: "productPrice") as! Int, titleProduct: data.value(forKey: "productName") as! String, categoryProduct: CategoryGame(rawValue: data.value(forKey: "productCategory") as! CategoryGame.RawValue) ?? CategoryGame.adventure, description: data.value(forKey: "productDesc") as! String, imageProduct: data.value(forKey: "productImage") as! String))
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
        namaAdmin.text = "Hello, Admin \(nama!)"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        tableViewAdmin.delegate = self
        tableViewAdmin.dataSource = self
        
        loadData()
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        //self.navigationController?.popToRootViewController(animated: true)
        if let nextView = storyboard?.instantiateViewController(identifier: "rootView") {
            let rootView = nextView as! ViewController
            navigationController?.setViewControllers([rootView], animated: true)
        }
    }
}
