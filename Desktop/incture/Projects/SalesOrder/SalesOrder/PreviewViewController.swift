//
//  PreviewViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 01/06/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,
UITextFieldDelegate {
    let kHeaderSectionTag: Int = 6900;

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var viewNetValue: UIView!
    
    @IBOutlet var btnHome: UIButton!
    
    var lblMaterial           = UILabel()
    var txtQtyValue         = UITextField()
    var lblDivider             = UILabel()
    var lblQty                   = UILabel()
    var lblPriceValue        = UILabel()
    var arrStep  = NSMutableArray()
    var searchActive : Bool = false
    var filtered:[String] = []
    var data:[String] = []
    @IBOutlet var lblNetvalue: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnSubmit: UIButton!
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    
    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = []
    
    //Getting value from stock update screen
    var arrGetStockUpdate:NSArray!
    var listOfDatesPreviousTransaction:NSArray  = []
    var listOfPreviousTransaction:NSArray  = []
    var listOfTotalPrice:NSArray  = []
    var listOfUnitPrice:NSArray  = []

    
    @IBAction func didActionHome(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource      = self
        
        print("arrGetStockUpdate-->\(arrGetStockUpdate)")
        listOfPreviousTransaction = (arrGetStockUpdate.value(forKey: "listOfPreviousTransaction")) as! NSArray
        
        print("listOfPreviousTransaction--->\(arrGetStockUpdate.value(forKey: "listOfPreviousTransaction"))")
        
        listOfDatesPreviousTransaction = (listOfPreviousTransaction.value(forKey: "transactionDate")) as! NSArray
        
        listOfTotalPrice = (arrGetStockUpdate.value(forKey: "totalPrice")) as! NSArray
        
        print("listOfTotalPrice--->\(arrGetStockUpdate.value(forKey: "totalPrice"))")
        
        listOfUnitPrice = (arrGetStockUpdate.value(forKey: "unitPrice" ))as! NSArray
        print("listOfUnitPrice--->\(arrGetStockUpdate.value(forKey: "unitPrice"))")
        
        
        
        
        
        viewNetValue.layer.cornerRadius = 5.0
        sectionNames = [ "Cookies","Milk Chocolates","Biscuits", "Waffers"];
        sectionItems   = [["5/11/2018","5/09/2018","5/04/2018"],["5/11/2018","5/09/2018","5/04/2018"],["5/11/2018","5/09/2018","5/04/2018"],["5/11/2018","5/09/2018","5/04/2018"]];
        // Do any additional setup after loading the view.
        
        self.tableView.register(UINib(nibName:"SalesOrderCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "TCell")
  self.tableView!.tableFooterView = UIView()
    }
    func hexStringToUIColor (hex:String) -> UIColor
    {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    @IBAction func didActionSubmit(_ sender: Any)
    {
        let str = "Ref.No :4356376536" as String
        // create the alert
        
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//Tableview delegate
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        if arrGetStockUpdate.count > 0
        {
            tableView.backgroundView = nil
            return self.arrGetStockUpdate.count
            // return 1
            
        }
        else
        {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.expandedSectionHeaderNumber == section)
        {
           
            let arrayOfItems = self.listOfDatesPreviousTransaction[section] as! NSArray
            return arrayOfItems.count;
            // return 1
        }
        else
        {
            return 0;
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        
        
        
        //        if (self.sectionNames.count != 0)
        //        {
        //            if(searchActive)
        //            {
        //
        //                return self.filtered[section] as? String
        //
        //   }
        //            else{
        return (arrGetStockUpdate[section] as AnyObject).value(forKey: "subCategoryName") as? String
        // return self.arrGetStockUpdate[section] as? String
        //   }
        
        //}
        // return ""
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
        
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        let headerFrame = self.view.frame.size
        
        
        lblMaterial = UILabel(frame: CGRect(x: 20, y: 50, width: 120, height: 20));
        header.addSubview(lblMaterial)
        lblMaterial.backgroundColor = .clear
        
        lblMaterial.text = ((arrGetStockUpdate[section] as AnyObject).value(forKey: "subCategoryType") as! String)
        lblMaterial.font = UIFont(name: "HelveticaNeue", size: 14.0)!
        
        
        txtQtyValue = UITextField(frame: CGRect(x: self.view.frame.size.width-120, y: 20, width: 40, height: 25));
        let TotPrice:Int = ((arrGetStockUpdate[section] as AnyObject).value(forKey: "totalPrice") as! Int)
        let unitPrice:Int = ((arrGetStockUpdate[section] as AnyObject).value(forKey: "unitPrice") as! Int)
        let Qty:Int = TotPrice / unitPrice
        
        txtQtyValue.text = String(Qty)
        txtQtyValue.isUserInteractionEnabled = false
        //        let totPrice:Int = listOfTotalPrice[section] as! Int
        //        let unitPrice:Int = listOfUnitPrice[section] as!Int
        //        let Qty:Int = totPrice / unitPrice
        //        print("QTY--->\(Qty)")
        //
        
        
        
        txtQtyValue.textColor = .black
        txtQtyValue.textAlignment = .right
        txtQtyValue.backgroundColor = .white
        txtQtyValue.font = UIFont(name: "HelveticaNeue-Bold", size: 12.0)!
        txtQtyValue.delegate = self
        txtQtyValue.tag = (section*10)+100
        header.addSubview(txtQtyValue)
        
        
        //setting bottom
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: txtQtyValue.frame.size.height - width, width:  txtQtyValue.frame.size.width, height: txtQtyValue.frame.size.height)
        border.borderWidth = width
        txtQtyValue.layer.addSublayer(border)
        txtQtyValue.layer.masksToBounds = true
        txtQtyValue.keyboardType = .default
        lblDivider  = UILabel(frame: CGRect(x: txtQtyValue.frame.origin.x +
            txtQtyValue.frame.size.width, y: 22, width: 20, height: 20));
        header.addSubview(lblDivider)
        
        lblDivider.text = "/$"
        lblDivider.textAlignment = .right
        lblDivider.font = UIFont(name: "HelveticaNeue", size: 12.0)!
        lblQty = UILabel(frame: CGRect(x: self.view.frame.size.width-100, y: 50, width: 90, height: 20));
        lblQty.text = "Qty/Price"
        lblQty.font = UIFont(name: "HelveticaNeue", size: 11.0)!
        
        header.addSubview(lblQty)
        
        lblPriceValue = UILabel(frame: CGRect(x: lblDivider.frame.origin.x + lblDivider.frame.size.width, y: 22, width: 40, height: 20));
        
        // lblPriceValue.text = "100"
        // var str =  txtQtyValue.text as! String
        //        let currency = "/ $"
        //        let myint = Int(txtQtyValue.text!)
        //        let myint1 = myint! * 10
        //        let strV =  String(myint1)
        //         str = currency + strV
        //   lblPriceValue.text = ""
        
//        let TotPrice:Int = ((arrGetStockUpdate[section] as AnyObject).value(forKey: "totalPrice") as! Int)
        
        lblPriceValue.text = String(TotPrice)
        lblPriceValue.textColor  = .black//hexStringToUIColor(hex: "#5AC38D")
        lblPriceValue.backgroundColor = .white
        lblPriceValue.font = UIFont(name: "HelveticaNeue-Bold", size: 12.0)!
        lblPriceValue.textAlignment = .left
        lblPriceValue.tag = (section*10)+1000
        header.addSubview(lblPriceValue)
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 90.0
        }
        else
        {
            return 40.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SalesOrderCustomTableViewCell
        
        //   let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as UITableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TCell", for: indexPath) as! SalesOrderCustomTableViewCell
        
        if (cell == nil)
        {
            
            tableView.register(UINib(nibName:"SalesOrderCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "TCell")
        }
        self.tableView.separatorColor = .clear
        cell.isUserInteractionEnabled = false
        
        if (indexPath.row == 0)
        {
            cell.lblDate.isHidden = false
            cell.img.isHidden = false
            cell.lblQty.isHidden = false
            cell.lblPrice.isHidden = false
            
            
            
            cell.lblDescription.isHidden = false
            cell.lblDescribtionValue.isHidden = false
            cell.lblUOM.isHidden = false
            cell.lblUOMValue.isHidden = false
            cell.lblUnitPrice.isHidden = false
            cell.lblUnitPriceValue.isHidden = false
            cell.lblTax.isHidden = false
            cell.lblTaxValue.isHidden = false
            
            cell.img.frame         =  CGRect(x: 15.0, y: 78.0, width: 15.0, height: 15.0)
            cell.lblDate.frame    =  CGRect(x: 40.0, y: 75.0, width: 70.0, height: 21.0)
            cell.lblQty.frame      =  CGRect(x: 278.0, y: 75.0, width: 30.0, height: 21.0)
            cell.lblDivider.frame =  CGRect(x: 309.0, y: 75.0, width: 15.0, height: 21.0)
            cell.lblPrice.frame    =  CGRect(x: 317.0, y: 75.0, width: 32.0, height: 21.0)
            cell.lblImgConnector.frame  =  CGRect(x: 21.0, y: 93.0, width: 2.0, height: 15.0)
            cell.lblImgConnector.isHidden = false
            
        }
        else if (indexPath.row == 2)
        {
            //            cell.lblDate.isHidden = false
            //            cell.img.isHidden = false
            //            cell.lblQty.isHidden = false
            //            cell.lblPrice.isHidden = false
            
            
            cell.lblDescription.isHidden = true
            cell.lblDescribtionValue.isHidden = true
            cell.lblUOM.isHidden = true
            cell.lblUOMValue.isHidden = true
            cell.lblUnitPrice.isHidden = true
            cell.lblUnitPriceValue.isHidden = true
            cell.lblTax.isHidden = true
            cell.lblTaxValue.isHidden = true
            
            
            
            cell.img.frame         =  CGRect(x: 15.0, y: 15.0, width: 15.0, height: 15.0)
            cell.lblDate.frame    =  CGRect(x: 40.0, y: 10.0, width: 70.0, height: 21.0)
            cell.lblQty.frame      =  CGRect(x: 278.0, y: 10.0, width: 30.0, height: 21.0)
            cell.lblDivider.frame =  CGRect(x: 309.0, y: 10.0, width: 15.0, height: 21.0)
            cell.lblPrice.frame    =  CGRect(x: 317.0, y: 10.0, width: 32.0, height: 21.0)
            //  cell.lblImgConnector.frame  =  CGRect(x: 21.0, y: 32.0, width: 2.0, height: 28.0)
            cell.lblImgConnector.isHidden = true
            
        }
        else
        {
            //            cell.lblDate.isHidden = false
            //            cell.img.isHidden = false
            //            cell.lblQty.isHidden = false
            //            cell.lblPrice.isHidden = false
            
            cell.lblDescription.isHidden = true
            cell.lblDescribtionValue.isHidden = true
            cell.lblUOM.isHidden = true
            cell.lblUOMValue.isHidden = true
            cell.lblUnitPrice.isHidden = true
            cell.lblUnitPriceValue.isHidden = true
            cell.lblTax.isHidden = true
            cell.lblTaxValue.isHidden = true
            
            cell.img.frame         =  CGRect(x: 15.0, y: 19.0, width: 15.0, height: 15.0)
            cell.lblDate.frame    =  CGRect(x: 40.0, y: 17.0, width: 70.0, height: 21.0)
            cell.lblQty.frame      =  CGRect(x: 278.0, y: 17.0, width: 30.0, height: 21.0)
            cell.lblDivider.frame =  CGRect(x: 309.0, y: 17.0, width: 15.0, height: 21.0)
            cell.lblPrice.frame    =  CGRect(x: 317.0, y: 17.0, width: 32.0, height: 21.0)
            cell.lblImgConnector.frame  =  CGRect(x: 21.0, y: 39.0, width: 2.0, height: 15.0)
            cell.lblImgConnector.isHidden = false
            //  cell.isUserInteractionEnabled = false
            
        }
////        let section = self.sectionItems[indexPath.section] as! NSArray
////        let qtyarray = ["20","18","34"] as NSArray
////        let pricearray = ["200","180","400"] as NSArray
////        
//        cell.lblDate.text = section[indexPath.row] as? String
//        cell.lblQty.text   = qtyarray[indexPath.row] as? String
//        cell.lblPrice.text   = pricearray[indexPath.row] as? String
        
        
        
        let DateValue  = ((self.listOfPreviousTransaction[indexPath.section] as AnyObject)) as! NSArray
        let dateString:String = ((DateValue[indexPath.row] as AnyObject).value(forKey: "transactionDate") as! String)
        
        let TotalString:Int = ((DateValue[indexPath.row] as AnyObject).value(forKey: "totalPrice") as! Int)
        
        let UnitString:Int = ((DateValue[indexPath.row] as AnyObject).value(forKey: "unitPrice") as! Int)
        
        
        
        let totPrice:Int = TotalString
        let unitPrice:Int = UnitString
        let Qty:Int = totPrice / unitPrice

        print("QTY--->\(Qty)")
        
        cell.lblDate.text     = dateString
        cell.lblQty.text       =  String(Qty)  //arrQty [indexPath.row] as? String
        cell.lblPrice.text    =  String(TotalString)
        
        print("cell.lblDate.text--->\(String(describing: cell.lblDate.text))")
        print("cell.lblQty.text--->\(String(describing: cell.lblQty.text))")
        print("cell.lblPrice.text --->\(String(describing: cell.lblPrice.text ))")

        
        
        
        
        
        cell.isUserInteractionEnabled = false
        
        //        cell.lblDate1.text = section[1] as? String
        //        cell.lblDate2.text = section[2] as? String
        
        cell.backgroundColor = .white
        
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
        
        if (self.expandedSectionHeaderNumber == -1)
        {
            self.expandedSectionHeaderNumber = section
            //  tableView.sectionHeaderHeight = 120.0
            tableViewExpandSection(section, imageView: eImageView!)
            lblPriceValue.resignFirstResponder()
        }
        else
        {
            if (self.expandedSectionHeaderNumber == section)
            {
                tableViewCollapeSection(section, imageView: eImageView!)
            }
            else
            {
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
        
        if (sectionData.count == 0)
        {
            return;
        }
        else {
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
