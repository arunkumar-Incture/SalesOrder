//
//  SalesOrderListViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 11/06/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit
import Alamofire

class SalesOrderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var btnHome: UIButton!
    var indexPath: IndexPath?
    var myindex:Int = 0
 
    //Get from customer screen
    var strPassCustomerName = String()
    var strPassCustomerID = String()
    //Get from service
    var data = NSMutableArray()
    var userDefaults = UserDefaults()

   // var data = ["Customer  1","Customer 2","Customer 3","Customer 4","Customer 5"]

    
    
    
    @IBAction func didActionHome(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate      = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName:"ApprovalsTableViewCell", bundle: nil), forCellReuseIdentifier: "ACell")
        
        servicecall()
        // Do any additional setup after loading the view.
    }
    
    
     func servicecall()
        {
            let sv = UIViewController.displaySpinner(onView: self.view)
            //Alamofire GET request
            
            let urlString1 =  "https://delfisorestwebnewc22708853.ap1.hana.ondemand.com/DelfiSo_RestWeb_new/rest/orderStatus/"
           //  let param = strPassCustomerID
              let urlString = urlString1 + strPassCustomerID
            
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
                        self.userDefaults.set(self.data, forKey: "orderDetails")
                        self.tableView.reloadData()
                    }
                    else {
                        print("didn't get todo object as JSON from API")
                        if let error = response.result.error {
                            print("Error: \(error)")
                        }
                        return
                    }
                    
            }
       //     self.view.addSubview( self.tblCustomers)
//            self.tableView.isHidden = false
            UIViewController.removeSpinner(spinner: sv)
            
        }
        
        
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if data.count == 0
        {
            let alert = UIAlertController(title: "No data found", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                }}))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 270.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //ApprovalsTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ACell", for: indexPath) as! ApprovalsTableViewCell
        
        if (cell == nil)
        {
            self.tableView.register(UINib(nibName:"ApprovalsTableViewCell", bundle: nil), forCellReuseIdentifier: "ACell")
        }
        
        cell.btnApprove.isHidden = true
        cell.btnReject.isHidden    = true

        cell.lblCustomerInitial.layer.cornerRadius = cell.lblCustomerInitial.frame.width/2
        cell.lblCustomerInitial.layer.masksToBounds = true
     
        cell.lblCustomerValue.text = strPassCustomerName
        //data[indexPath.row]
        cell.lblSoldToAddress.text = ""
        cell.lblShipToAddress.text = ""

        cell.lblOrderAmtValue.text = "$500"// orderAmt[indexPath.row]
        cell.lblExceededAmtValue.text = "$50" //exceededAmt[indexPath.row]
        let str: String = cell.lblCustomerValue.text!
        let CustomerInitial = str.substring(to:str.index(str.startIndex, offsetBy: 1))
        
        print("STR--->\(CustomerInitial)")
        cell.lblCustomerInitial.text = CustomerInitial
        
        print("myindexin cellforrowatindex--->\(myindex)")
        cell.btnApprove.tag = indexPath.row+1
        cell.btnReject.tag = indexPath.row+5
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Status") as! StatusViewController
        
        print("Row \(indexPath.row) selected")
        
        
       
        
        nextViewController.strCustomerNameInStatusVC =  (self.data[indexPath.row] as AnyObject).value(forKey: "customerName") as! String
        
        //  nextViewController.strPassRefPoNoInStatusVC =  (self.data[indexPath.row] as AnyObject).value(forKey: "refPoNo") as! String
        
        //refPoNo
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
 
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        cell.contentView.backgroundColor = UIColor.clear
        let whiteRoundedView : UIView = UIView()
        whiteRoundedView.frame = CGRect(x:0, y:0, width:self.view.frame.size.width,height:265)
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
