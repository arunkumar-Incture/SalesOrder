//
//  StockUpdateViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 17/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit


class StockUpdateViewController1: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating ,UIGestureRecognizerDelegate {
    
    struct Cake {
        var name = String()
        var material = String()
    }
    
    
    var cakes = [Cake(name: "Cookies", material: "Material"),
                 Cake(name: "Milk Chocolate", material: "Material"),
                 Cake(name: "Biscuits", material: "Material"),
                 Cake(name: "Wafferrs", material: "Material")]
     var arrCategory = ["Cookies","Milk Chocolate","Biscuits","Wafferrs"]
    let tap = UITapGestureRecognizer.self
    
    var vw = UIView()


    var filteredCakes = [Cake]()
    let searchController = UISearchController(searchResultsController: nil)
    var arrStock = NSMutableArray()
    private var dateCellExpanded: Bool = false

@IBOutlet var tableView: UITableView!
@IBOutlet var btnSave: UIButton!
@IBOutlet var btnSubmit: UIButton!
    
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer(gestureRecognizer:)))
    //yourView.addGestureRecognizer(tapGesture)
    
    
    
    @objc func TapGestureRecognizer(gestureRecognizer: UIGestureRecognizer) {
        //do your stuff here
        print("Gesture")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       tableView.delegate = self
       tableView.dataSource = self
        
        filteredCakes = cakes
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        self.tableView.register(CustomTableViewCell1.self, forCellReuseIdentifier: "cell")
        self.tableView.register(MenuHeaderView.self, forHeaderFooterViewReuseIdentifier: "custom")

        // Do any additional setup after loading the view.
        //tblCustomers.tableFooterView = UIView()

    }

    //Tableview delegates
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            filteredCakes = cakes
        } else {
            // Filter the results
            filteredCakes = cakes.filter { $0.name.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.filteredCakes.count

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 1
        
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell     {
       
        let cell: CustomTableViewCell1 = CustomTableViewCell1(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
     
        cell.textLabel?.textColor = .black
       // cell.textLabel?.text = self.filteredCakes[indexPath.row].name
       // cell.detailTextLabel?.text = self.filteredCakes[indexPath.row].material
        cell.myLabel1.text = "5/11/2018:"
        cell.myLabel2.text = "5/09/2018:"
        cell.myLabel3.text = "5/04/2018:"
        cell.myLabel4.text =  "20/$200"
        cell.myLabel5.text =  "18/$180"
        cell.myLabel6.text =  "34/$400"

        return cell
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  if indexPath.row == 0 {
//            if dateCellExpanded {
//                dateCellExpanded = false
//            } else {
//                dateCellExpanded = true
//            }
            tableView.beginUpdates()
            tableView.endUpdates()
      //  }
    }
    
    
//    private func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        vw.isUserInteractionEnabled = true
//        vw.backgroundColor = UIColor.red
//        vw.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100.0)
//        let lbl = UILabel()
//        lbl.frame = CGRect(x: self.view.frame.size.width-120, y: 10.0, width: 60.0, height: 30.0)
//        vw.addSubview(lbl)
//        lbl.text = "$0.00"
//        lbl.textColor = .green
//        lbl.backgroundColor = .red
//        
//        let tapR : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
//        tapR.delegate = self
////        tapR.numberOfTapsRequired = 1
////        tapR.numberOfTouchesRequired = 1
//        vw.addGestureRecognizer(tapR)
//     
//        return vw
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let v = tableView.dequeueReusableHeaderFooterView(withIdentifier: "custom") as! MenuHeaderView
        v.lblCategory.text = "COOKIES"
        v.lblMaterial.text = "Material"
        v.lblCategory?.textColor = .red
        v.lblCategory?.backgroundColor = .black

        
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        v.addGestureRecognizer(tapRecognizer)
        return v
    }
    
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer)
    {
        
        if dateCellExpanded {
            dateCellExpanded = false

        } else {
            dateCellExpanded = true
        }
       // controller?.view.endEditing(true)
    }
    
    
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      //  if indexPath.row == 0 {
            if dateCellExpanded {
                return 250
            } else {
                return 50
            }
       // }
        //return 50
    }
    
    @IBAction func didActionScanner(_ sender: Any) {
        
        let scanner = ScannerViewController()
        
  //      self.navigationController?.pushViewController(scanner, animated: true)
       // let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VC") as! ViewController
        
        self.present(scanner, animated:true, completion:nil)
        
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
