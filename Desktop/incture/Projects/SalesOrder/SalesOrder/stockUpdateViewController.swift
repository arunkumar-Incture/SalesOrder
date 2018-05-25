//
//  StockUpdateViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 25/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class stockUpdateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate
{
    
    let kHeaderSectionTag: Int = 6900;
    
    var lblMaterial              = UILabel()
    var lbStockIN               = UILabel()
    var lbStockINQTY        = UILabel()
    var lblStockOUT          = UILabel()
    var lbStockOUTQTY    = UILabel()
    var lblDivider                = UILabel()
    var lblQty                      = UILabel()
    var lblQtyValue             = UILabel()
    
    var btnStockINMinus      = UIButton()
    var btnStockINPlus         = UIButton()
    var btnStockOUTMinus   = UIButton()
    var btnStockOUTPlus      = UIButton()
   

    @IBOutlet weak var tableView: UITableView!
    
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate      = self
        tableView.dataSource = self
        
        sectionNames = [ "Cookies", "Milk chocolates","Biscuits", "Waffers" ];
        
        sectionItems   =   [ ["5/11/2018                                                     Qty:20",
                            "5/09/2018                                                    Qty:18",
                            "5/0/2018                                                      Qty:34"],
                           ["5/11/2018                                                     Qty:20",
                            "5/09/2018                                                    Qty:18",
                            "5/0/2018                                                      Qty:34"],
                           ["5/11/2018                                                     Qty:20",
                            "5/09/2018                                                    Qty:18",
                            "5/0/2018                                                      Qty:34"],["5/11/2018                                                     Qty:20",
                                                                                                     "5/09/2018                                                    Qty:18",
                                                                                                     "5/0/2018                                                      Qty:34"]];
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        self.tableView!.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func didActionSubmit(_ sender: Any) {
        
        var str = "Ref.No :4356376536" as String
        // create the alert
//        let alert = UIAlertController(title: "Success", message: str, preferredStyle: UIAlertControllerStyle.alert)
//
//        // add the actions (buttons)
//        alert.addAction(UIAlertAction(title: "Create Sales Order", style: UIAlertActionStyle.default, handler: nil))
//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
//
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
//
        
        let alert = UIAlertController(title: "Success", message: str, preferredStyle: UIAlertControllerStyle.alert)
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
    
    
   
    @IBAction func didActionFilter(_ sender: UIButton) {
        
    }
    
    //    override func didReceiveMemoryWarning()
//    {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    // MARK: - Tableview Methods
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if sectionNames.count > 0
        {
            tableView.backgroundView = nil
            return sectionNames.count
        }
        else {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = "Retrieving data.\nPlease wait."
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)!
            messageLabel.sizeToFit()
            self.tableView.backgroundView = messageLabel;
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section)
        {
            let arrayOfItems = self.sectionItems[section] as! NSArray
            return arrayOfItems.count;
        }
        else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (self.sectionNames.count != 0)
        {
            return self.sectionNames[section] as? String
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 80.0;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        //recast your view as a UITableViewHeaderFooterView
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = .white
        
        header.layer.borderColor = UIColor.gray.cgColor
        header.layer.masksToBounds = true
        header.layer.borderWidth = 1.0
        //header.textLabel?.textColor = UIColor.black
        
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        let headerFrame = self.view.frame.size
        
        lblMaterial = UILabel(frame: CGRect(x: 20, y: 50, width: 70, height: 20));
        header.addSubview(lblMaterial)
        lblMaterial.backgroundColor = .clear
        lblMaterial.text = "Material"
        lblMaterial.font = UIFont(name: "HelveticaNeue", size: 14.0)!
        
        lbStockIN = UILabel(frame: CGRect(x: lblMaterial.frame.origin.x+lblMaterial.frame.size.width+70, y: 50, width: 70, height: 20));
        lbStockIN.text = "Stock IN"
        lbStockIN.textColor = .black
        lbStockIN.textAlignment = .center
        lbStockIN.backgroundColor = .white
        lbStockIN.font = UIFont(name: "HelveticaNeue", size: 13.0)!
        header.addSubview(lbStockIN)
        
        btnStockINMinus = UIButton(frame: CGRect(x: lblMaterial.frame.origin.x+lblMaterial.frame.size.width+70, y: 18, width: 15, height: 15));
        btnStockINMinus.setTitle("-", for: UIControlState.normal)
        btnStockINMinus.setTitleColor(.gray, for: UIControlState.normal)
        btnStockINMinus.addTarget(self, action: #selector(didActionMinus), for: .touchUpInside)
        header.addSubview(btnStockINMinus)
        
        lbStockINQTY = UILabel(frame: CGRect(x: btnStockINMinus.frame.origin.x+btnStockINMinus.frame.size.width+2, y: 15, width: 25, height: 25));
        lbStockINQTY.text = "100"
        lbStockINQTY.textColor = .black
        lbStockINQTY.textAlignment = .center
        lbStockINQTY.backgroundColor = .white
        lbStockINQTY.font = UIFont(name: "HelveticaNeue", size: 12.0)!
        header.addSubview(lbStockINQTY)
        
        btnStockINPlus = UIButton(frame: CGRect(x: lbStockINQTY.frame.origin.x+lbStockINQTY.frame.size.width+2, y: 18, width: 15, height: 15));
        btnStockINPlus.setTitle("+", for: UIControlState.normal)
        btnStockINPlus.setTitleColor(.gray, for: UIControlState.normal)
        
        btnStockINPlus.addTarget(self, action: #selector(didActionPlus), for: .touchUpInside)
        header.addSubview(btnStockINPlus)
        
        
        lblStockOUT = UILabel(frame: CGRect(x: lbStockIN.frame.origin.x+lbStockIN.frame.size.width+10, y: 50, width: 70, height: 20));
        lblStockOUT.text = "Stock OUT"
        lblStockOUT.textAlignment = .center
        
        lblStockOUT.textColor = .black
        lblStockOUT.backgroundColor = .white
        lblStockOUT.font = UIFont(name: "HelveticaNeue", size: 13.0)!
        header.addSubview(lblStockOUT)
        
        btnStockOUTMinus = UIButton(frame: CGRect(x: lblStockOUT.frame.origin.x, y: 18, width: 15, height: 15));
        btnStockOUTMinus.setTitle("-", for: UIControlState.normal)
        btnStockOUTMinus.setTitleColor(.gray, for: UIControlState.normal)
        
        btnStockOUTMinus.addTarget(self, action: #selector(didActionOUTMinus), for: .touchUpInside)
        header.addSubview(btnStockOUTMinus)
        
        lbStockOUTQTY = UILabel(frame: CGRect(x: lbStockIN.frame.origin.x+lbStockIN.frame.size.width+30, y: 15, width: 25, height: 25));
        lbStockOUTQTY.text = "100"
        lbStockOUTQTY.textColor = .black
        lbStockOUTQTY.textAlignment = .center
        lbStockOUTQTY.backgroundColor = .white
        lbStockOUTQTY.font = UIFont(name: "HelveticaNeue", size: 12.0)!
        header.addSubview(lbStockOUTQTY)
        
        btnStockOUTPlus = UIButton(frame: CGRect(x: lbStockIN.frame.origin.x+lbStockIN.frame.size.width+60, y: 18, width: 15, height: 15));
        btnStockOUTPlus.setTitle("+", for: UIControlState.normal)
        btnStockOUTPlus.setTitleColor(.gray, for: UIControlState.normal)
        
        btnStockOUTPlus.addTarget(self, action: #selector(didActionOutPlus), for: .touchUpInside)
        header.addSubview(btnStockOUTPlus)
        
        lblQty = UILabel(frame: CGRect(x: lblStockOUT.frame.origin.x+lblStockOUT.frame.size.width+10, y: 50, width: 40, height: 20));
        lblQty.text = "Qty"
        lblQty.textColor = .black
        lblQty.backgroundColor = .white
        lblQty.font = UIFont(name: "HelveticaNeue", size: 13.0)!
        lblQty.textAlignment = .center
        header.addSubview(lblQty)
        
        lblQtyValue = UILabel(frame: CGRect(x: lblQty.frame.origin.x, y: 15, width: 40, height: 20));
        lblQtyValue.text = "200"
        lblQtyValue.textColor = .black
        lblQtyValue.backgroundColor = .white
        lblQtyValue.font = UIFont(name: "HelveticaNeue", size: 14.0)!
        lblQtyValue.textAlignment = .center
        header.addSubview(lblQtyValue)
        
        // let btnQtyReduce
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 50, width: 18, height: 18));
        theImageView.image = UIImage(named: "chevron-down")
        theImageView.tag = kHeaderSectionTag + section
        header.addSubview(theImageView)
        
        // make headers touchable
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(stockUpdateViewController.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as UITableViewCell
        let section = self.sectionItems[indexPath.section] as! NSArray
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.text = section[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Expand / Collapse Methods
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section, imageView: eImageView!)
            } else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
    
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView)
    {
        let sectionData = self.sectionItems[section] as! NSArray
        
        self.expandedSectionHeaderNumber = -1;
        if (sectionData.count == 0) {
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.tableView!.beginUpdates()
            self.tableView!.deleteRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
    
    func tableViewExpandSection(_ section: Int, imageView: UIImageView)
    {
        let sectionData = self.sectionItems[section] as! NSArray
        
        if (sectionData.count == 0)
        {
            self.expandedSectionHeaderNumber = -1;
            return;
        }
        else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            self.tableView!.beginUpdates()
            self.tableView!.insertRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
    
    @objc func didActionMinus()
    {
       
    }
    @objc func didActionPlus()
    {
        
    }
    
    @objc func didActionOUTMinus()
    {
        
    }
    @objc func didActionOutPlus()
    {
        
    }
    
//    private func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
//    {
//        print("\(buttonIndex)")
//        switch (buttonIndex){
//
//        case 0:
//            print("Cookies")
//        case 1:
//            println("Milk Chocolates")
//        case 2:
//            println("Delete")
//        default:
//            println("Default")
//            //Some code here..
//
//        }
//    }
    
    
}

