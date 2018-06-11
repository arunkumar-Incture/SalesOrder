//
//  CustomerSearchViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 16/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit
import SQLite3
import Alamofire

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class CustomerSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
  

    struct Cake {
        var name = String()
        var size = String()
    }
    

    var data = NSMutableArray()//["Customer  1","Customer 2","Customer 3","Customer 4","Customer 5","Customer 6","Customer 7"]
    var oldData = NSMutableArray() 
   // var filtered:[String] = []
    var txtLabel = String()
    var txtBillLabel = String()

  
    var searchActive : Bool = false

    var arrResponse = NSMutableArray()
    @IBOutlet var tblCustomers: UITableView!
    @IBOutlet var searchbar: UISearchBar!
    @IBOutlet var btnHome: UIButton!
    //var filteredData = [String]()
   var stringTag = NSString()
   var stringTitle = NSString()
   var screenSize = CGSize(width:0,height:0)
    @IBOutlet var lblTitle: UILabel!
    
    var db: OpaquePointer?
    
    
    var userDefaults = UserDefaults()
   // let sv  =   UIViewController.removeSpinner(spinner: UIView)

    override func viewDidLoad()
    {
        super.viewDidLoad()
        screenSize=UIScreen.main.bounds.size
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = true
        
   /*     let  fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("SalesOrder.sqlite")
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        //creating table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Customer (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        //creating a statement
        var stmt: OpaquePointer?
        var str = "Customer1"
        //the insert query
        let queryString = "INSERT INTO Customer (name) VALUES (str)"
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
 */

        lblTitle.text = stringTitle as String
        tblCustomers.delegate       = self
        tblCustomers.dataSource   = self
        searchbar.delegate             = self

        searchbar.layer.borderColor = UIColor.red.cgColor
        
        definesPresentationContext = true
        self.tblCustomers.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
      
        let  lblNointernet = UILabel()
        //self.view.addSubview( self.tblCustomers)
tblCustomers.removeFromSuperview()
        if Connectivity.isConnectedToInternet {
            print("Yes! internet is available.")
            self.tblCustomers.isHidden = true
            lblNointernet.isHidden = true
          //let sv  = UIViewController.displaySpinner(onView: self.view)
            // do some tasks..
        }
        else{
            lblNointernet.frame = CGRect (x: 20, y: self.view.frame.size.height/2, width: 250, height: 50)
            self.view.addSubview(lblNointernet)
            lblNointernet.text = "Please connect your device to internet"
          //  self.tblCustomers.isHidden = false
            lblNointernet.isHidden = false

        }
   servicecall()
                

    }
    
    func servicecall()
    {
        let sv = UIViewController.displaySpinner(onView: self.view)
        //Alamofire GET request
        
        let urlString =  "https://delfisorestwebnewc22708853.ap1.hana.ondemand.com/DelfiSo_RestWeb_new/rest/valueHelp/getCustomerDetails/salesRep1"
        
        Alamofire.request(urlString)
            .responseJSON { response in
                // check for errors
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /todos/1")
                    print(response.result.error!)
                    return
                    
                }
                
                // make sure we got some JSON since that's what we expect
                if let json = response.result.value as? [String: Any] {
                    print("json-->: \(json)")
                    //self.data = json["data"] as! NSMutableArray
                    self.data = NSMutableArray(array:json["data"] as! NSArray)
                    print("DATA-->: \(self.data)")
                    self.userDefaults = UserDefaults.standard
                    self.userDefaults.set(self.data, forKey: "CustomerDetails")
                    self.tblCustomers.reloadData()
                }
                else {
                    print("didn't get todo object as JSON from API")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                
        }
        self.view.addSubview( self.tblCustomers)
        self.tblCustomers.isHidden = false
          UIViewController.removeSpinner(spinner: sv)

    }
    
 //SEARCHBAR
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchActive = true;
        searchbar.showsCancelButton = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    {
        searchActive = false;
        searchbar.showsCancelButton = false;
        self.view.endEditing(true)
        searchbar.resignFirstResponder()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool{
        searchbar.resignFirstResponder()
        searchbar.endEditing(true)
        return true
    }
    
    
     func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        searchActive = false;
        self.view.endEditing(true)
        searchbar.showsCancelButton = false;
        self.searchbar.endEditing(true)
        self.searchbar.resignFirstResponder()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        oldData=self.data
        let arrSearch=NSMutableArray()
        for i in 0..<self.data.count {
            let catogryName:String=(self.data[i] as AnyObject).value(forKey: "customerName") as! String
            if catogryName.range(of: searchbar.text!)  != nil {
                arrSearch.add(self.data[i])
            }
        }
        self.data=arrSearch
        
        if searchBar.text == ""{
            self.data=oldData
            // tableView.reloadData()
            searchBar.resignFirstResponder()
            
        }
        tblCustomers.reloadData()
        self.searchbar.resignFirstResponder()
        self.searchbar.endEditing(true)
    }

    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
//    {
//
//        filtered = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
//
//        tblCustomers.reloadData()
//
//    }
    
    private func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText == ""{
            self.data=oldData
            tblCustomers.reloadData()
            searchBar.resignFirstResponder()
        }
        //filtered = data.filter({ (text) -> Bool in
//            let tmp: NSString = text as! NSString
//            //let range = tmp.rangeOfString(searchText, options: NSString.CompareOptions.CaseInsensitiveSearch)
//
//            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
//            return range.location != NSNotFound
//        }) as! [String]

//        if(filtered.count == 0)
//        {
//            searchActive = false;
//            view.endEditing(true)
//
//
//        }
//        else
//        {
//            searchActive = true;
//            //filtered = data.filter({$0 == searchBar.text})
//
//        }
        //tblCustomers.reloadData()
    }

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        if(searchActive)
//        {
//            return filtered.count
//        }
        return data.count;
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .clear
       
//        if(searchActive)
//        {
//            cell.textLabel?.text = filtered[indexPath.row]
//            txtLabel = ""
//            txtBillLabel = ""
//            txtLabel = (filtered[indexPath.row] as NSString) as String
//            txtBillLabel = (filtered[indexPath.row] as NSString) as String
//
//        }
//        else
//        {
            cell.textLabel?.text = (data[indexPath.row] as AnyObject).value(forKey: "customerName") as! String
            txtBillLabel = ""
         //   txtBillLabel = (data[indexPath.row] as NSString) as String
       // }
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return cell
    }

    
    @IBAction func didActionHome(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
       
        if stringTag.isEqual(to: "3")
        {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BC") as! BillingViewController
            //let a = String(indexPath.row+1)
            nextViewController.stringCustomerName = (self.data[indexPath.row] as AnyObject).value(forKey: "customerName") as! String
            self.navigationController?.pushViewController(nextViewController, animated: true)
         
        }
        
        else if stringTag.isEqual(to: "2")
        {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SO") as! SalesOrderViewController
            
                print("Row \(indexPath.row) selected")
            
                nextViewController.str =  (self.data[indexPath.row] as AnyObject).value(forKey: "customerName") as! String
                
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        else if stringTag.isEqual(to: "4")
        {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SOL") as! SalesOrderListViewController
            
            print("Row \(indexPath.row) selected")
          
            nextViewController.strPassCustomerName =  (self.data[indexPath.row] as AnyObject).value(forKey: "customerName") as! String
            nextViewController.strPassCustomerID = (self.data[indexPath.row] as AnyObject).value(forKey: "customerId") as! String
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        else
        {
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VC") as! stockUpdateViewController
            
//            if (searchActive) {
//                var strC = txtLabel as String
//                // var strC = "Hello"
//                //let range1 = (strC.characters.index((strC.startIndex), offsetBy: 9))..<(strC.endIndex)
//                strC = filtered[indexPath.row]
//                nextViewController.str = strC as String
//                print(strC)
//            }
//
//            else{
            
                print("Row \(indexPath.row) selected")
                
          
               nextViewController.str = (self.data[indexPath.row] as AnyObject).value(forKey: "customerName") as! String
              
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
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
    

    
 
}

