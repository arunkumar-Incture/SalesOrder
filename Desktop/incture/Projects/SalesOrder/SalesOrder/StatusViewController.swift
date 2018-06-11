//
//  StatusViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 31/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var searchbar: UISearchBar!
    
    @IBOutlet var btnHome: UIButton!
    
    @IBOutlet var btnProfile: UIButton!
    
    @IBOutlet var lblOrderNOValue: UILabel!
    
    @IBOutlet var lblCustName: UILabel!
    var searchActive : Bool = false
    var filtered:[String] = []
    
    var strCustomerNameInStatusVC = String()
    var strPassCustomerIDInStatusVC = String()
  //  var strPassRefPoNoInStatusVC = String()

    var arrOrder:NSArray = ["Order Submit", "Order Approve by Harry","Order Approve by Peter","Order Approve by John","Order Create"]
    
    var arrDate:NSArray = ["5/18/2018", "5/18/2018","5/18/2018","5/18/2018","5/18/2018"]

    var arrApprover:NSArray = ["Completed", "Processing","Not Yet","Not Yet","Not Yet"]

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchbar.delegate = self; tableView.register(UINib(nibName:"StatusTableViewCell", bundle: nil), forCellReuseIdentifier: "Status")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    //SEARCHBAR
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchActive = true;
        searchbar.showsCancelButton = true;
        return true
    }
    //    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    //    {
    //        searchActive = true;
    //        searchbar.showsCancelButton = true;
    //
    //    }
    
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchActive = false;
        self.view.endEditing(true)
        searchbar.showsCancelButton = false;
        self.searchbar.endEditing(true)
        self.searchbar.resignFirstResponder()
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.searchbar.endEditing(true)
        self.searchbar.resignFirstResponder()
        self.searchbar.endEditing(true)
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        
        //filtered = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            //return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
    //    }
        
        tableView.reloadData()
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return arrOrder.count
    }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 130.0;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Status", for: indexPath) as! StatusTableViewCell
        
        if (cell == nil)
        {
            tableView.register(UINib(nibName:"StatusTableViewCell", bundle: nil), forCellReuseIdentifier: "Status")
        }
        self.tableView.separatorColor = .gray
        cell.isUserInteractionEnabled = false
      
        if (indexPath.row == 0)
        {
            cell.contentView.alpha = 1.0
            cell.lblimgConnector.isHidden = false
                 // .darkgreen
        }
        else if (indexPath.row == 1)
        {
            cell.lblimgConnector.isHidden = false
            cell.contentView.alpha = 0.4
            cell.lblCompleted.textColor = .gray
        }
            else if (indexPath.row == 4)
        {
            cell.lblimgConnector.isHidden = true
            cell.contentView.alpha = 0.4
            cell.lblCompleted.textColor = .red
        }
        else {
            cell.contentView.alpha = 0.4
            cell.lblimgConnector.isHidden = false
            cell.lblCompleted.textColor = .red
        }
        cell.lblOrderSubmit.text = (arrOrder[indexPath.row] as! String)
        cell.lblDate.text = (arrDate[indexPath.row] as! String)
        cell.lblCompleted.text = (arrApprover[indexPath.row] as! String)

    
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        cell.contentView.backgroundColor = UIColor.clear
        let whiteRoundedView : UIView = UIView()
        whiteRoundedView.frame = CGRect(x:0, y:0, width:self.view.frame.size.width,height:120)
        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
