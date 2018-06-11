//
//  SalesOrderViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 25/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class SalesOrderViewController: UIViewController , UITableViewDelegate , UITableViewDataSource,UITextFieldDelegate, UIActionSheetDelegate,UISearchBarDelegate {
    
    let kHeaderSectionTag: Int = 6900;
    
    var lblMaterial           = UILabel()
    var txtQtyValue         = UITextField()
    var lblDivider             = UILabel()
    var lblQty                   = UILabel()
    var lblPriceValue        = UILabel()
    var arrStep  = NSMutableArray()
   
    var searchActive : Bool = false
    var filtered:[String] = []
    var data:[String] = []


    var str = String()

    @IBOutlet var viewNetValue: UIView!
    
    @IBOutlet var lblNetvalue: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var btnPreview: UIButton!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    
    @IBOutlet var searchbar: UISearchBar!
    
    @IBOutlet var lblSalesorderwithDate: UILabel!
    
    @IBOutlet var imgBackgroundForAlert: UIImageView!
    
    @IBOutlet var viewSuccess: UIView!
    
    @IBOutlet var lblReferenceNo: UILabel!

    @IBOutlet var btnClose: UIButton!

    @IBOutlet var lblSuccess: UILabel!
    
    
    //Getting value from stock update screen
    var arrGetStockUpdate:NSArray!
    var listOfDatesPreviousTransaction:NSArray  = []
    var listOfPreviousTransaction:NSArray  = []
    var listOfTotalPrice:NSArray  = []
    var listOfUnitPrice:NSArray  = []

    @IBAction func didActionClose(_ sender: Any)
    {
        viewSuccess.isHidden = true
        viewSuccess.isUserInteractionEnabled = true
        imgBackgroundForAlert.isHidden = true
    }
    
    
    @IBAction func didActionPreview(_ sender: Any)
    {
        
        if arrGetStockUpdate != nil
        {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PV") as! PreviewViewController
        nextViewController.arrGetStockUpdate = arrGetStockUpdate as! NSArray
        print("nextViewController.arrGetStockUpdate-->\(nextViewController.arrGetStockUpdate)")
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        else
        {
            
            imgBackgroundForAlert.isHidden = false
            let alert = UIAlertController(title: "Update Sales order to preview", message: "", preferredStyle: .alert)
            
         //   alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
        //        self.didActionHome((Any).self)
       //     }))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            imgBackgroundForAlert.isHidden = true
            self.present(alert, animated: true)
            
        }
    }
    
    
    @IBAction func didActionCancel(_ sender: Any)
    {
        imgBackgroundForAlert.isHidden = false
        let alert = UIAlertController(title: "Do you Want to cancel?", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.didActionHome((Any).self)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        imgBackgroundForAlert.isHidden = true
        self.present(alert, animated: true)
    
    }
    
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = []
    var subCategoryName:NSArray  = []
    var subCategoryType:NSArray  = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("arrGetStockUpdate-->\(arrGetStockUpdate)")
     
        if arrGetStockUpdate != nil
        {
            listOfPreviousTransaction = (arrGetStockUpdate.value(forKey: "listOfPreviousTransaction")) as! NSArray
            
            print("listOfPreviousTransaction--->\(arrGetStockUpdate.value(forKey: "listOfPreviousTransaction"))")
            
            listOfDatesPreviousTransaction = (listOfPreviousTransaction.value(forKey: "transactionDate")) as! NSArray
            
            listOfTotalPrice = (arrGetStockUpdate.value(forKey: "totalPrice")) as! NSArray
            
            print("listOfTotalPrice--->\(arrGetStockUpdate.value(forKey: "totalPrice"))")
            
            listOfUnitPrice = (arrGetStockUpdate.value(forKey: "unitPrice" ))as! NSArray
            print("listOfUnitPrice--->\(arrGetStockUpdate.value(forKey: "unitPrice"))")
            
            subCategoryName = (arrGetStockUpdate.value(forKey: "subCategoryName")) as! NSArray
            print("1subCategoryName--->\(arrGetStockUpdate.value(forKey: "subCategoryName"))")
            
            subCategoryType = (arrGetStockUpdate.value(forKey: "subCategoryType")) as! NSArray
            self.view.addSubview(tableView)
            tableView.delegate       = self
            tableView.dataSource  = self
            searchbar.delegate =  self

            print("filtered-->\(filtered)")
            filtered = subCategoryName as! [String]
            data = subCategoryName as! [String]
        self.tableView.register(UINib(nibName:"SalesOrderCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "TCell")
            
            self.tableView!.tableFooterView = UIView()
        }
       else {
        
      tableView.removeFromSuperview()
        
        }
      
        viewNetValue.layer.cornerRadius = 5.0
        sectionNames = [ "Cookies","Milk Chocolates","Biscuits", "Waffers"];
        sectionItems   = [["5/11/2018","5/09/2018","5/04/2018"],["5/11/2018","5/09/2018","5/04/2018"],["5/11/2018","5/09/2018","5/04/2018"],["5/11/2018","5/09/2018","5/04/2018"]];
        arrStep   = NSMutableArray()
        arrStep   = ["0","0","0","0"]

      /*  sectionItems   =   [ ["5/11/2018                                       Qty:20",
                              "5/09/2018                                             Qty:18",
                              "5/04/2018                                             Qty:34"],
                             ["5/11/2018                                             Qty:20",
                              "5/09/2018                                             Qty:18",
                              "5/04/2018                                             Qty:34"],
                             ["5/11/2018                                             Qty:20",
                              "5/09/2018                                             Qty:18",
                              "5/04/2018                                             Qty:34"],
                             ["5/11/2018                                            Qty:20",
                                                                                                        "5/09/2018                                                    Qty:18",
                                                                                                        "5/04/2018                                                      Qty:34"]];
        */
       //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cells")
        //SalesOrderCustomTableViewCell
      
        lblTitle.text = "Sales Order - Customer " + str
//        btnPreview.layer.borderWidth = 1.0
//        btnPreview.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let totLabel:Int = 0

        if(totLabel > 500)
        {
            viewNetValue.backgroundColor = hexStringToUIColor(hex: "#E81100")
        }
        else
        {
            viewNetValue.backgroundColor = hexStringToUIColor(hex: "#5AC38D")
        }
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
        
        if arrGetStockUpdate != nil
        {
            viewSuccess.isHidden = false
            viewSuccess.isUserInteractionEnabled = true
            imgBackgroundForAlert.isHidden = false
        }
        else
        {
            
            imgBackgroundForAlert.isHidden = false
            let alert = UIAlertController(title: "Update Sales order to Submit", message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            imgBackgroundForAlert.isHidden = true
            self.present(alert, animated: true)
            
            
        }
    }
    
    @IBAction func didActionHome(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func didActionFilter(_ sender: UIButton)
    {
        //str
        let alert = UIAlertController(title: "Filter", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        let AllButton = UIAlertAction(title: "All", style: .default, handler: { (action) -> Void in
            print("All")
            
        
         //   self.sectionNames = ["Cookies","Milk Chocolates","Biscuits", "Waffers"];
         //   self.tableView.reloadData()
            
        })
        

//        let sendButton = UIAlertAction(title: "Cookies", style: .default, handler: { (action) -> Void in
//            print("Cookies")
//       //     self.sectionNames = [ "Cookies", "Cookies" ];
//         //   self.tableView.reloadData()
//
//        })
//
//        let  deleteButton = UIAlertAction(title: "Milk Chocolates", style: .default, handler: { (action) -> Void in
//            print("Milk Chocolates")
//        //    self.sectionNames = [ "Milk Chocolates", "Milk Chocolates","Milk Chocolates" ];
//         //   self.tableView.reloadData()
//
//        })
//
//        let cancelButton = UIAlertAction(title: "Biscuits", style: .default, handler: { (action) -> Void in
//            print("Biscuits")
//          //  self.sectionNames = [ "Biscuits"];
//         //   self.tableView.reloadData()
//
//        })
//
//        let WaffersButton = UIAlertAction(title: "Waffers", style: .default, handler: { (action) -> Void in
//            print("Waffers")
//           //  self.sectionNames = ["","","",""]
//            //self.sectionNames = [ "Waffers", "Waffers","Waffers", "Waffers" ];
//          //  self.tableView.reloadData()
//
//        })
        
        let cancelsButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel")
        })
        alert.addAction(AllButton)
//        alert.addAction(sendButton)
//        alert.addAction(deleteButton)
//        alert.addAction(cancelButton)
//        alert.addAction(WaffersButton)
        alert.addAction(cancelsButton)
        self.navigationController!.present(alert, animated: true, completion: nil)
        
    }
    
    
 
     //var count: Int = 1
    
    @IBAction func didActionPreviousSalesOrder(_ sender: Any)
    {

    //        lblSalesorderwithDate.text = "Previous Sales Order - 5/11/2018"
  //        self.sectionNames = [ "Cookies","Milk Chocolates" ];
//        self.tableView.reloadData()

    }
    var votesDisplay: UILabel!
    var counter = 1

    @IBAction func didActionNextSalesOder(_ sender: (Any))
    {
     //   votesDisplay.text = " \(counter++)"
        
        //f (votesDisplay.text == 1){
//        lblSalesorderwithDate.text = "Previous Sales Order - 5/09/2018"
//
//            self.sectionNames = [ "Cookies", "Waffers","Biscuits" ];
//            self.tableView.reloadData()
      //  }
       
    }
    


    
    
    

    //SEARCHBAR
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchActive = true;
        searchbar.showsCancelButton = true;
        return true
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
        
        filtered = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
        
    }
    
    

    
    
    // MARK: - Tableview Methods
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section)
        {
      // let arrayOfItems = self.arrGetStockUpdate[section] as! NSArray
            
            if self.arrGetStockUpdate != nil{
            let arrayOfItems = self.listOfDatesPreviousTransaction[section] as! NSArray
            return arrayOfItems.count;
            }
    // return 1
        }
        else
        {
            return 0;
        }
          return 0;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
       

        
      if (self.arrGetStockUpdate.count != 0)
      {
//            if(searchActive)
//            {
//
//                return self.filtered[section] as? String
//
        return (arrGetStockUpdate[section] as AnyObject).value(forKey: "subCategoryName") as? String

      }
            else{
             // return self.arrGetStockUpdate[section] as? String
      //  }
  return ""
        }
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
       
        if arrGetStockUpdate != nil{
        let TotPrice:Int = ((arrGetStockUpdate[section] as AnyObject).value(forKey: "totalPrice") as! Int)
        let unitPrice:Int = ((arrGetStockUpdate[section] as AnyObject).value(forKey: "unitPrice") as! Int)
            let Qty:Int = TotPrice / unitPrice

            txtQtyValue.text = String(Qty)
        }
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
        let TotPrice:Int = ((arrGetStockUpdate[section] as AnyObject).value(forKey: "totalPrice") as! Int)

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
        
        if arrGetStockUpdate != nil{
        let DateValue  = ((self.listOfPreviousTransaction[indexPath.section] as AnyObject)) as! NSArray
        let dateString:String = ((DateValue[indexPath.row] as AnyObject).value(forKey: "transactionDate") as! String)
        
        //let TotalPriceValue  = ((self.listOfPreviousTransaction[indexPath.section] as AnyObject)) as! NSArray
        let TotalString:Int = ((DateValue[indexPath.row] as AnyObject).value(forKey: "totalPrice") as! Int)
        
        //let UnitPriceValue  = ((self.listOfPreviousTransaction[indexPath.section] as AnyObject)) as! NSArray
        let UnitString:Int = ((DateValue[indexPath.row] as AnyObject).value(forKey: "unitPrice") as! Int)
        
//        let stockin:Int = ((DateValue[indexPath.row] as AnyObject).value(forKey: "stockIn") as! Int)
//        let stockout:Int = ((DateValue[indexPath.row] as AnyObject).value(forKey: "stockOut") as! Int)

        
        let totPrice:Int = TotalString
        let unitPrice:Int = UnitString
        let Qty:Int = totPrice / unitPrice
        //
        print("QTY--->\(Qty)")
        
        cell.lblDate.text     = dateString
        cell.lblQty.text       =  String(Qty)  //arrQty [indexPath.row] as? String
        cell.lblPrice.text    =  String(TotalString)
        print("cell.lblDate.text--->\(String(describing: cell.lblDate.text))")
        print("cell.lblQty.text--->\(String(describing: cell.lblQty.text))")
        print("cell.lblPrice.text --->\(String(describing: cell.lblPrice.text ))")
        }
        cell.isUserInteractionEnabled = false


        cell.backgroundColor = .white
     
        return cell

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
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
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

             return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {

    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        let a4 = ((textField.tag) - 100)/10  // first text field
        print("a4--->\(a4)") // section value

        let  txt1 = self.view.viewWithTag(textField.tag+1) as? UITextField
        var arrTextField  = NSMutableArray()
        arrTextField = [a4,textField.text]    // section,textfieldvalue
        print("arrTextField--->\(arrTextField)")
        
        let qtyV:Int = Int(textField.text!)!
        let UnitPrice:Int  = 10
        let Total:Int = qtyV * UnitPrice
        
        let lbl1 = self.view.viewWithTag((a4*10)+1000) as? UILabel
        lbl1?.text =  String(Total)
        print(lbl1!)
        
        var totLabel:Int = 0
        
        for  i in 0..<arrGetStockUpdate.count
        {
            let lbl2 = self.view.viewWithTag((i*10)+1000) as? UILabel
            totLabel   +=  Int((lbl2?.text)!)!
            print("Total--->\(totLabel)")
            }
        
      lblNetvalue.text = "$" + String(totLabel)
      
        if(totLabel > 500)
           {
            viewNetValue.backgroundColor = hexStringToUIColor(hex: "#E81100")
            }
            else
            {
                viewNetValue.backgroundColor = hexStringToUIColor(hex: "#5AC38D")
            }
        
        return true
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
    
        return true
        
    }
   


    
    
}
