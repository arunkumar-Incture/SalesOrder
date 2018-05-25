//
//  FilterViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 20/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var arrCategory = NSMutableArray()
    
    @IBOutlet var tblCustomers: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tblCustomers.delegate = self
        self.tblCustomers.dataSource = self
      
        arrCategory = ["Milk Chocolate","Milk Waffer","Cookies"]
        tblCustomers.frame = CGRect(x:10 , y:30 , width:self.view.frame.width , height:500)
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = CustomTableViewCell()
        (style: UITableViewCellStyle.default, reuseIdentifier: "myIdentifier")
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor.clear
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.textLabel?.text = (arrCategory.object(at: indexPath.row) as! String)
        return cell
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
