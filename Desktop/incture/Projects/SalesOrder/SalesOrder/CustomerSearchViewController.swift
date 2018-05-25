//
//  CustomerSearchViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 16/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit


class CustomerSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
   
    
    /*var cakes = [Cake(name: "Customer Name 1"),
                        Cake(name: "Customer Name 2"),
                        Cake(name: "Customer Name 3"),
                        Cake(name: "Customer Name 4"),
                        Cake(name: "Customer Name 5")]*/
    
 

    
    struct Cake {
        var name = String()
        var size = String()
    }
    
    var cakes = [Cake(name: "Customer  1", size: "Small"),
                 Cake(name: "Customer 2", size: "Medium"),
                 Cake(name: "Customer 3", size: "Large"),
                 Cake(name: "Customer 4", size: "Small"),
                 Cake(name: "Customer 5", size: "Medium")]
    
    var filteredCakes = [Cake]()
    let searchController = UISearchController(searchResultsController: nil)

    
   // var arrCustomer = NSMutableArray()
    @IBOutlet var tblCustomers: UITableView!
        
    @IBOutlet var btnHome: UIBarButtonItem!
    //var filteredData = [String]()

   
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
      
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            tblCustomers.tableHeaderView = searchController.searchBar
        }
        
        filteredCakes = cakes
        tblCustomers.delegate = self
           tblCustomers.dataSource = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        
        tblCustomers.tableHeaderView = searchController.searchBar
       
        self.tblCustomers.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            filteredCakes = cakes
        } else {
            // Filter the results
            filteredCakes = cakes.filter { $0.name.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.tblCustomers.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(self.filteredCakes.count)
        return self.filteredCakes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell     {
        // let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myIdentifier")
        
        let cell = self.tblCustomers.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = self.filteredCakes[indexPath.row].name
      
        return cell
        
        
      //  cell.textLabel?.text = self.arrFiltered
        // cell.detailTextLabel?.text = self.filteredCakes[indexPath.row].size
        
       // return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row) selected")
        let a  =  indexPath.row as NSNumber
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VC") as! ViewController
        self.present(nextViewController, animated:true, completion:nil)
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
  
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.contentView.backgroundColor = UIColor.clear
        let whiteRoundedView : UIView = UIView()
        whiteRoundedView.frame = CGRect(x:0, y:0, width:self.view.frame.size.width,height:60)
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        let size = self.view.bounds.size
        let rightInset = size.width > size.height ? size.width : size.height
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, rightInset)
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 40.0
    }
    
 
}

