//
//  ApprovalsViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 31/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class ApprovalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var btnHome: UIButton!
    var indexPath: IndexPath?

    var myindex:Int = 0
    var data = ["Customer  1","Customer 2","Customer 3","Customer 4","Customer 5"]

    var orderAmt = ["$900","$1000","$1200","$800","$500"]
    
    var exceededAmt = ["$100","$200","$30","$80","$100"]

    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate      = self
        tableView.dataSource = self
    self.tableView.register(UINib(nibName:"ApprovalsTableViewCell", bundle: nil), forCellReuseIdentifier: "ACell")

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        
      

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
        
        cell.btnApprove.isUserInteractionEnabled = true
        cell.lblCustomerInitial.layer.cornerRadius = cell.lblCustomerInitial.frame.width/2
         cell.lblCustomerInitial.layer.masksToBounds = true
        cell.lblCustomerValue.text = data[indexPath.row]
        cell.lblOrderAmtValue.text = orderAmt[indexPath.row]
        cell.lblExceededAmtValue.text = exceededAmt[indexPath.row]

        let str: String = cell.lblCustomerValue.text!
        let first4 = str.substring(to:str.index(str.startIndex, offsetBy: 1))

        print("STR--->\(first4)")
          cell.lblCustomerInitial.text = first4
        print("myindexin cellforrowatindex--->\(myindex)")
        cell.btnApprove.tag = indexPath.row+1
        cell.btnReject.tag = indexPath.row+5

        cell.btnApprove.addTarget(self, action: #selector(didActionApprove), for:.touchUpInside)
        cell.btnReject.addTarget(self, action: #selector(didActionReject), for: .touchUpInside)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        
     
    return cell
        
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ACell", for: indexPath) as! ApprovalsTableViewCell
//        myindex = indexPath.row
//        print("myindexin cellforrowDidselect--->\(myindex)")
//
//    }
    
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
    
  

    @objc func didActionApprove(sender: UIButton)
    {
        print("Approved")
         myindex = (sender.tag) - 1
       print("myindex==>\(myindex)")

        data.remove(at: myindex)
        orderAmt.remove(at: myindex)
        exceededAmt.remove(at: myindex)
        print("DATA==>\(data)")
        
        let alert = UIAlertController(title: "Approved", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
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
        tableView.reloadData()
    }
   
    @objc func didActionReject(sender: UIButton)  {
        print("Rejected")
         myindex = (sender.tag) - 5
        print("myindex==>\(myindex)")

        data.remove(at: myindex)
        orderAmt.remove(at: myindex)
        exceededAmt.remove(at: myindex)
        print("DATA==>\(data)")
        
        let alert = UIAlertController(title: "Rejected", message: "", preferredStyle: UIAlertControllerStyle.alert)
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

        tableView.reloadData()
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
