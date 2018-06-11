//
//  StockUpdateViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 25/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit
import Alamofire

class stockUpdateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UITextFieldDelegate,UISearchBarDelegate
{
    var arrMaterial  = NSArray()
    var arrQty = NSArray()
    var arrPrice = NSArray()
    var arrStep  = NSMutableArray()
    var arrLabel  = NSMutableArray()
    var arrChangeColor  = NSMutableArray()

    var stepperString1 = NSString()
    var stepperString2 = NSString()

    var stepper = UIStepper.self.init();
    var stepper1 = UIStepper.self.init();
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnFilter: UIButton!
    @IBOutlet var btnBarcodescanner: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var btnSave: UIButton!
    
   //global variables for assigning
    var strStockINQtyMinusValue: String    = "0 "
    var strStockOUTQtyMinusValue : String    = "0 "
    var str = String()
    
    var a:Int = 0
    var b:Int = 0
    var c:Int = 0

    let kHeaderSectionTag: Int = 6900;

    var lblMaterial               = UILabel()
    var lbStockIN                = UILabel()
    var lblStockOUT           = UILabel()
    var lbStockOUTQTY     = UITextField()
    var lblDivider                 = UILabel()
    var lblQty                       = UILabel()
    var lblPrice                     = UILabel()
    var lblPriceValue             = UILabel()
    var btnStockINMinus      = UIButton()
    var btnStockINPlus         = UIButton()
    var btnStockOUTMinus   = UIButton()
    var btnStockOUTPlus      = UIButton()
    var searchActive : Bool = false
    
    var screenSize = CGSize(width:0,height:0)
   
   // var data = ["Customer  1","Customer 2","Customer 3","Customer 4","Customer 5","Customer 6","Customer 7"]
   // var filtered:[String] = []
     // var data:[String] = []
    
  //  var data = NSMutableArray()
    var userDefaults = UserDefaults()
    
    @IBOutlet var searchbar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var viewSuccess: UIView!
    
    @IBOutlet var lblReferenceNo: UILabel!
    
    @IBOutlet var imageBackground: UIImageView!
    
    @IBOutlet var btnClose: UIButton!
    
    
    var CellColorChange : Bool = false

   

    //From json response
    var fullData:NSMutableArray  = []
    var oldfullData:NSMutableArray  = []
    var subCategoryName:NSArray  = []
    var subCategoryType:NSArray  = []
    var listOfPreviousTransaction:NSArray  = []

    var listOfDatesPreviousTransaction:NSArray  = []
   
    var listOfTotalPrice:NSArray  = []
    var listOfUnitPrice:NSArray  = []
    //insidecell
    var listOfTotalPriceInCell:NSArray  = []
    var listOfUnitPriceInCell:NSArray  = []
    
    
    
    
    @IBAction func didActionClose(_ sender: Any)
    {
        viewSuccess.isHidden = true
        viewSuccess.isUserInteractionEnabled = false
        imageBackground.isHidden = true
        self.navigationController?.popViewController(animated: true)

    }
  
    
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UIView!
    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = []
    
    
    //Show Updated stocks
    var UpdatedSections: Array<Any> = []
    var EditedSectionArray:NSMutableArray  = []
    var selectedArray:NSMutableArray  = []
    var arrPassTOSalesOrder:NSMutableArray  = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        screenSize=UIScreen.main.bounds.size
      
        
        let urlString =  "https://delfisorestwebnewc22708853.ap1.hana.ondemand.com/DelfiSo_RestWeb_new/rest/stock/datta/datta"
        
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
                    self.fullData = NSMutableArray(array:json["data"] as! NSArray)
                    print("fullData-->: \(self.fullData)")

                    self.userDefaults = UserDefaults.standard
                    self.userDefaults.set(self.fullData, forKey: "StockUpdate")
                   self.serviceCall()//Call method to update
                   
                }
                else
                {
                    print("didn't get todo object as JSON from API")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
       
        }
        
       // self.serviceCall()
       
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = true
        lbStockOUTQTY.isUserInteractionEnabled = true
        print(str)
        
        lblTitle.text    = "Stock Update - " + str
        tableView.delegate                =  self
        tableView.dataSource           =  self
        searchbar.delegate               =   self
        definesPresentationContext = true
        lbStockOUTQTY.delegate = self
      
        sectionNames = [ "Cookies", "Milk chocolates","Biscuits", "Waffers" ];
        sectionItems   =   [ ["5/11/2018 ","5/09/2018 ","5/04/2018 "],
                           ["5/11/2018 ","5/09/2018 ","5/04/2018 "],
                           ["5/11/2018 ","5/09/2018 ","5/04/2018 "],
                           ["5/11/2018 ","5/09/2018 ","5/04/2018 "]];
     searchbar.showsCancelButton = false
       // print("filtered-->\(filtered)")
      
        //QtyCell
          arrMaterial = NSArray()
          arrQty        = NSArray()
          arrPrice     = NSArray()
          arrMaterial = ["Material 1","Material 1","Material 2","Material 3"]
          arrQty      = ["20","18","34"]
          arrPrice   = ["100","180","400"]
          arrStep    = NSMutableArray()
          arrStep    = ["0","0","0","0"]
          arrLabel   = NSMutableArray()
          arrLabel   = ["/$0","/$0","/$0","/$0"]
          arrChangeColor    = NSMutableArray()
          arrChangeColor    = ["0","0","0","0"]
          UpdatedSections  = ["0","0","0","0","0","0"]
    //    getEditedSection  = ["0","0","0","0"]
        
        self.tableView.register(UINib(nibName:"QtyTableviewCell", bundle: nil), forCellReuseIdentifier: "QtyCell")
       // self.tableView.frame=CGRect(x:0,y:self.tableView.frame.origin.y,width:screenSize.width,height:screenSize.height-228)
       // self.tableView!.tableFooterView = UIView()
        btnSave.layer.borderWidth = 1.0
        btnSave.layer.borderColor  = UIColor.white.cgColor
     
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(self.sayHello(notification:)),
                                       name: NSNotification.Name(rawValue: "getTextfieldDataFromQtyTableViewCell"),
                                       object: nil)
    
    
        
       
        
    //
    
    
    }
    
    
    func editSection(section: Int)
    {
        EditedSectionArray[section] = "1"
    }
    
    func serviceCall()
    {
    
//        if let path = Bundle.main.path(forResource: "stockupdate", ofType: "json")
//        {
//            do {
//                let datas = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let jsonResult = try JSONSerialization.jsonObject(with: datas, options: .mutableLeaves)
//                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["data"] as? [Any]
//                {
//                    // do stuff
//                    fullData = NSMutableArray(array:person as! NSArray)
//                    print("fullData--->\(fullData)")
//                    print("fullData-subCategoryName--->\(fullData.value(forKey: "subCategoryName"))")
//                    print("fullData-subCategoryType--->\(fullData.value(forKey: "subCategoryType"))")
//
                for _ in 0..<fullData.count
                {
                    EditedSectionArray.add("0")
                }
                    subCategoryName = (fullData.value(forKey: "subCategoryName")) as! NSArray
                    print("1subCategoryName--->\(fullData.value(forKey: "subCategoryName"))")

                    subCategoryType = (fullData.value(forKey: "subCategoryType")) as! NSArray
                    print("2subCategoryType--->\(fullData.value(forKey: "subCategoryType"))")
               
                    listOfPreviousTransaction = (fullData.value(forKey: "listOfPreviousTransaction")) as! NSArray
                    print("listOfPreviousTransaction--->\(fullData.value(forKey: "listOfPreviousTransaction"))")
                    
                    listOfDatesPreviousTransaction = (listOfPreviousTransaction.value(forKey: "transactionDate")) as! NSArray
                    print("listOfDatesPreviousTransaction--->\(listOfPreviousTransaction.value(forKey: "transactionDate"))")
                    
                    listOfTotalPrice = (fullData.value(forKey: "totalPrice")) as! NSArray
                    print("listOfTotalPrice--->\(fullData.value(forKey: "totalPrice"))")
                   
                    listOfUnitPrice = (fullData.value(forKey: "unitPrice" ))as! NSArray
                    print("listOfUnitPrice--->\(fullData.value(forKey: "unitPrice"))")
                    
                    listOfTotalPriceInCell = (listOfPreviousTransaction.value(forKey: "totalPrice")) as! NSArray
                    print("listOfTotalPrice--->\((listOfPreviousTransaction.value(forKey: "unitPrice")))")
                    
                    listOfUnitPriceInCell = (listOfPreviousTransaction.value(forKey: "unitPrice"))as! NSArray
                    print("listOfUnitPrice--->\((listOfPreviousTransaction.value(forKey: "unitPrice"))))")
                    //filtered = subCategoryName as! [String]
                 //   data = subCategoryName as! [String] as! NSMutableArray
                self.tableView.reloadData()
        
    }
    
   
    
    
    @objc func sayHello(notification: NSNotification)
    {
      
        let arr:NSMutableArray = notification.object as! NSMutableArray
        print("arr--->\(arr)")
      //  arrStep[arr[0] as! Int] = arr[1]
       // print("arrStep--->\(arrStep)")
       // print(arr[0])
        
        let arrsec: Int = arr[0] as! Int
        let strText:String = String(describing: arr[1])
        print("strText--->\(strText)")

        
     if let theTextField = self.view.viewWithTag(arrsec + 1000) as? UITextField
       {
        theTextField.text = strText
        print(theTextField.text!)
        }
//        let qtyV:Int = Int(strText)!
//        let UnitPrice:Int  = 10
//        let Total:Int = qtyV * UnitPrice
//        let a4 = arrsec
//
//        let lbl1 = self.view.viewWithTag(arrsec+200) as? UILabel
//        let currStr:String = "/$"
//        let fullStr:String = String(Total)
//        lbl1?.text =  currStr + fullStr
        //print(lbl1!)
    //   arrLabel[a4] = lbl1?.text
    //    print(arrLabel)
    
    }
    
    @IBAction func didActionHome(_ sender: Any)
    {
    self.navigationController?.popViewController(animated: true)
    }
   
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    

    @IBAction func didActionSave(_ sender: Any)
    {
        viewSuccess.isHidden = false
        viewSuccess.isUserInteractionEnabled = true
        imageBackground.isHidden = false
    }
    
    
    
    @IBAction func didActionSubmit(_ sender: Any)
    {
        for i in 0..<self.fullData.count
        {
            if (self.EditedSectionArray[i] as! String  == "1")
            {
                let txt1 = self.view.viewWithTag((i*2)+50000) as! UITextField
                let txt2 = self.view.viewWithTag((i*2)+50001) as! UITextField
                
                let dic = NSMutableDictionary()
                dic.setValue(txt1.text, forKey: "stockIn")
                        dic.setValue(txt2.text, forKey: "stockOut")
                        dic.setValue((self.fullData[i] as! AnyObject).value(forKey: "listOfPreviousTransaction"), forKey: "listOfPreviousTransaction")
                        arrPassTOSalesOrder.add(dic)
            }
             print(arrPassTOSalesOrder)
        }
        print("arrPassTOSalesOrder-->\(self.arrPassTOSalesOrder)")
       
        viewSuccess.isHidden = false
        viewSuccess.isUserInteractionEnabled = true
        imageBackground.isHidden = false
    }
    
    @IBAction func didActionCreateSalesOrder(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SO") as! SalesOrderViewController
        nextViewController.arrGetStockUpdate = self.arrPassTOSalesOrder.copy() as! NSArray
        print("nextViewController.arrGetStockUpdate-->\(nextViewController.arrGetStockUpdate)")
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    
    
    @IBAction func didActionFilter(_ sender: UIButton)
    {
        //str
        let alert = UIAlertController(title: "Filter", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
     
        let AllButton = UIAlertAction(title: "All", style: .default, handler: { (action) -> Void in
            print("All")
            
            //self.viewDidLoad().self
            var NewArray:NSMutableArray  = []

            for i in 0..<self.fullData.count
            {
                if (self.EditedSectionArray[i] as! String  == "1")
                {
                NewArray.insert(self.fullData[i], at: 0)
                    self.arrPassTOSalesOrder.add(self.fullData[i])
                }
                else {
                  NewArray.add(self.fullData[i])
                }
            }
            
            self.fullData = NewArray
            print("arrPassTOSalesOrder-->\(self.arrPassTOSalesOrder)")

            print("self.fullData-->\(self.fullData)")
            print("NewArray-->\(NewArray)")

           // self.sectionNames = ["Cookies","Milk Chocolates","Biscuits", "Waffers"];
            self.tableView.reloadData()
            
        })
        

//        let sendButton = UIAlertAction(title: "Cookies", style: .default, handler: { (action) -> Void in
//            print("Cookies")
//          //  self.sectionNames = [ "Cookies", "Cookies","Cookies", "Cookies" ];
//         //   self.tableView.reloadData()
//
//        })
//
//        let  deleteButton = UIAlertAction(title: "Milk Chocolates", style: .default, handler: { (action) -> Void in
//            print("Milk Chocolates")
////            self.sectionNames = [ "Milk Chocolates", "Milk Chocolates","Milk Chocolates" ];
////            self.tableView.reloadData()
//
//        })
//
//        let cancelButton = UIAlertAction(title: "Biscuits", style: .default, handler: { (action) -> Void in
//            print("Biscuits")
////            self.sectionNames = [ "Biscuits", "Biscuits"];
////            self.tableView.reloadData()
////
//        })
//
//        let WaffersButton = UIAlertAction(title: "Waffers", style: .default, handler: { (action) -> Void in
//            print("Waffers")
////            self.sectionNames = [ "Waffers", "Waffers","Waffers", "Waffers" ];
////            self.tableView.reloadData()
//
//        })
//
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
    
    //SEARCHBAR
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool
    {
     
        searchActive = true;
       // oldfullData=fullData
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
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool
    {
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchActive = false;
        oldfullData=fullData
        let arrSearch=NSMutableArray()
        for i in 0..<fullData.count {
            let catogryName:String=(fullData[i] as AnyObject).value(forKey: "subCategoryName") as! String
            if catogryName.range(of: searchbar.text!)  != nil {
               arrSearch.add(fullData[i])
            }
        }
        fullData=arrSearch
        
        if searchBar.text == ""{
            fullData=oldfullData
           // tableView.reloadData()
            searchBar.resignFirstResponder()
            
        }
        tableView.reloadData()
        self.searchbar.resignFirstResponder()
        self.searchbar.endEditing(true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText == ""{
            fullData=oldfullData
            tableView.reloadData()
            searchBar.resignFirstResponder()
        }
        else
        {
//        let arrSearch=NSMutableArray()
//        for i in 0..<fullData.count {
//            let catogryName:String=(fullData[i] as AnyObject).value(forKey: "subCategoryName") as! String
//            if catogryName.range(of: searchbar.text!)  != nil {
//                arrSearch.add(fullData[i])
//            }
//        }
//        fullData = arrSearch
        }
//        filtered = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
//             If dataItem matches the searchText, return true to include it
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }

      
        
    }

    // MARK: - Tableview Methods
    
    func numberOfSections(in tableView: UITableView) -> Int
    {

        
        if fullData.count > 0
        {
//            if(searchActive)
//            {
//                return filtered.count
//            }
//            else
//            {
//                tableView.backgroundView = nil
//                return self.sectionNames.count
//            }
            return fullData.count
        }
        else
        {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = "Retrieving data please wait.\n"
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)!
            messageLabel.sizeToFit()
            self.tableView.backgroundView = messageLabel;
            }
            
       // }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.expandedSectionHeaderNumber == section)
        {
            let arrayOfItems = self.listOfDatesPreviousTransaction[section] as! NSArray
            return arrayOfItems.count;
        }
        else {
            return 0;
        }
    }
    
 /*   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (self.fullData.count != 0)
        {
            return (fullData[section] as AnyObject).value(forKey: "subCategoryName") as? String
           
//            if(searchActive)
//            {
//                return self.fullData[section] as! String
//
//            }
//            else
//            {
//                return self.subCategoryName[section] as? String
//            }
        }
        return ""
    }*/
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 80.0;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if indexPath.row == 0
        {
            return 110.0
        }
        else
        {
        return 40.0
        }
    }
    
 /*   func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
//        listOfTotalPrice = (fullData.value(forKey: "totalPrice")) as! NSArray
//        print("listOfTotalPrice--->\(fullData.value(forKey: "totalPrice"))")
//
//        listOfUnitPrice = (fullData.value(forKey: "unitPrice" ))as! NSArray
//        print("listOfUnitPrice--->\(fullData.value(forKey: "unitPrice"))")
//
//        stockIn = 50;
//        stockOut = 91;
        
        let stockIn:Int = (fullData[section] as AnyObject ).value(forKey: "stockIn") as! Int
        
        let stockOut:Int = (fullData[section] as AnyObject ).value(forKey: "stockOut") as! Int

//        let totPrice:Int = (fullData[section] as AnyObject ).value(forKey: "totalPrice") as! Int
//        let unitPrice:Int = (fullData[section] as AnyObject ).value(forKey: "unitPrice") as! Int
        let Qty:Int = stockIn + stockOut
        print("QTY--->\(Qty)")
        
        //recast your view as a UITableViewHeaderFooterView
        let header: UIView = view
        
        header.backgroundColor = .white
        header.layer.borderColor = UIColor.gray.cgColor
        header.layer.masksToBounds = true
       header.layer.borderWidth = 0.2
        
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section)
        {
            viewWithTag.removeFromSuperview()
        }
        
        let headerFrame = self.view.frame.size
        lblMaterial = UILabel(frame: CGRect(x: 20, y: 50, width: 120, height: 20));
        
        lblQty = UILabel(frame: CGRect(x: self.view.frame.size.width-80, y: 50, width: 40, height: 20));
        var txtQtyValue               = UITextField()

        txtQtyValue = UITextField(frame: CGRect(x: self.view.frame.size.width-70, y: 30, width: 30, height: 20));
       txtQtyValue.backgroundColor = .white

        
        lblPrice = UILabel(frame: CGRect(x:lblQty.frame.origin.x + lblQty.frame.size.width+1, y: 50, width: 40, height: 20));
        
        lblPriceValue = UILabel(frame: CGRect(x: lblPrice.frame.origin.x, y: 30, width: 80, height: 20));
     
        txtQtyValue.delegate = self
        lbStockOUTQTY.delegate = self

     
        header.addSubview(lblMaterial)
        lblMaterial.backgroundColor = .clear
        lblMaterial.textColor = .gray
        lblMaterial.text = ""
        lblMaterial.text =   subCategoryType[section] as! String
        lblMaterial.font = UIFont(name: "HelveticaNeue", size: 14.0)!
        

        lblQty.text = "Qty"
        lblQty.textColor = .gray
        lblQty.backgroundColor = .white
        lblQty.font = UIFont(name: "HelveticaNeue", size: 13.0)!
        lblQty.textAlignment = .right
        header.addSubview(lblQty)

        txtQtyValue.textColor = .black
        txtQtyValue.font = UIFont(name: "HelveticaNeue-Bold", size: 14.0)!
        txtQtyValue.textAlignment = .right
        txtQtyValue.tag = section+1000
        txtQtyValue.isUserInteractionEnabled = false
        txtQtyValue.delegate = self
        txtQtyValue.text =  String(Qty)                //arrStep[section] as? String
        print(" txtQtyValue.text--->\(String(describing:  txtQtyValue.text))")

//      //setting bottom
//        let border = CALayer()
//        let width = CGFloat(2.0)
//        border.borderColor = UIColor.darkGray.cgColor
//        border.frame = CGRect(x: 0, y: txtQtyValue.frame.size.height - width, width:  txtQtyValue.frame.size.width, height: txtQtyValue.frame.size.height)
//
//        border.borderWidth = width
//        txtQtyValue.layer.addSublayer(border)
//        txtQtyValue.layer.masksToBounds = true
        
        header.addSubview(txtQtyValue)
        
        lblPrice.text = "/ Price"
        lblPrice.textColor = .gray
        lblPrice.backgroundColor = .white
        lblPrice.font = UIFont(name: "HelveticaNeue", size: 13.0)!
        lblPrice.textAlignment = .left
        //header.addSubview(lblPrice)
//        var strinText:String = (txtQtyValue.text)!
//
//        if (txtQtyValue.text?.isEmpty)!{
//            strinText = "0"
        
      //  }
//        let qtyV:Int = Int(strinText)!
//            let UnitPrice:Int = 10
//            let Total:Int = qtyV * UnitPrice
//            print(Total)
//            let  currency = "/$" as String
          //  lblPriceValue.text = currency + String(Total)
        
        lblPriceValue.textColor = .black
        lblPriceValue.backgroundColor = .white
        lblPriceValue.font = UIFont(name: "HelveticaNeue-Bold", size: 14.0)!
        lblPriceValue.textAlignment = .left
//         lblPriceValue.tag = section+200
     //   header.addSubview(lblPriceValue)


        // let btnQtyReduce
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 50, width: 18, height: 18));
      theImageView.image = UIImage(named: "chevron-down")
        theImageView.tag = 10000 + section
        header.addSubview(theImageView)
        
        
        
        
        // make headers touchable
        header.tag = section+20000
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(stockUpdateViewController.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
        
        let listener : String =  EditedSectionArray[section] as! String
        if  listener == "1"
        {
            
            header.backgroundColor = hexStringToUIColor(hex: "#ffebee")

        }
        else{
            
            header.backgroundColor = .white

        }
        
    }*/
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let stockIn:Int = (fullData[section] as AnyObject ).value(forKey: "stockIn") as! Int
        
        let stockOut:Int = (fullData[section] as AnyObject ).value(forKey: "stockOut") as! Int
        
        //        let totPrice:Int = (fullData[section] as AnyObject ).value(forKey: "totalPrice") as! Int
        //        let unitPrice:Int = (fullData[section] as AnyObject ).value(forKey: "unitPrice") as! Int
        let Qty:Int = stockIn + stockOut
        print("QTY--->\(Qty)")
        
        //recast your view as a UITableViewHeaderFooterView
        let header = UIView.init(frame: CGRect(x:0,y:0,width:screenSize.width,height:screenSize.height))
        header.backgroundColor = .white
        header.layer.borderColor = UIColor.gray.cgColor
        header.layer.masksToBounds = true
        header.layer.borderWidth = 0.2
        
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section)
        {
            viewWithTag.removeFromSuperview()
        }
        
        let headerFrame = self.view.frame.size
        lblMaterial = UILabel(frame: CGRect(x: 20, y: 50, width: 120, height: 20));
        
        lblQty = UILabel(frame: CGRect(x: self.view.frame.size.width-80, y: 50, width: 40, height: 20));
        var txtQtyValue               = UITextField()
        
        txtQtyValue = UITextField(frame: CGRect(x: self.view.frame.size.width-70, y: 30, width: 30, height: 20));
        //txtQtyValue.backgroundColor = .white
        
        
        lblPrice = UILabel(frame: CGRect(x:lblQty.frame.origin.x + lblQty.frame.size.width+1, y: 50, width: 40, height: 20));
        
        lblPriceValue = UILabel(frame: CGRect(x: lblPrice.frame.origin.x, y: 30, width: 80, height: 20));
        
        txtQtyValue.delegate = self
        lbStockOUTQTY.delegate = self
        var lblName:UILabel = UILabel.init(frame: CGRect(x:10,y:10,width:200,height:30))
        lblName.text=(fullData[section] as AnyObject).value(forKey: "subCategoryName") as? String
        lblName.textColor = .black
        lblName.font = UIFont(name: "HelveticaNeue", size: 16.0)!
        header.addSubview(lblName)
        header.addSubview(lblMaterial)
        lblMaterial.backgroundColor = .clear
        lblMaterial.textColor = .gray
        lblMaterial.text = ""
        lblMaterial.text =  (self.fullData[section] as AnyObject).value(forKey: "subCategoryType") as! String //subCategoryType[section] as! String
        lblMaterial.font = UIFont(name: "HelveticaNeue", size: 14.0)!
        
        
        lblQty.text = "Qty"
        lblQty.textColor = .gray
        //lblQty.backgroundColor = .white
        lblQty.font = UIFont(name: "HelveticaNeue", size: 13.0)!
        lblQty.textAlignment = .right
        header.addSubview(lblQty)
        
        txtQtyValue.textColor = .black
        txtQtyValue.font = UIFont(name: "HelveticaNeue-Bold", size: 14.0)!
        txtQtyValue.textAlignment = .right
        txtQtyValue.tag = section+1000
        txtQtyValue.isUserInteractionEnabled = false
        txtQtyValue.delegate = self
        txtQtyValue.text =  String(Qty)                //arrStep[section] as? String
        print(" txtQtyValue.text--->\(String(describing:  txtQtyValue.text))")
        
        //      //setting bottom
        //        let border = CALayer()
        //        let width = CGFloat(2.0)
        //        border.borderColor = UIColor.darkGray.cgColor
        //        border.frame = CGRect(x: 0, y: txtQtyValue.frame.size.height - width, width:  txtQtyValue.frame.size.width, height: txtQtyValue.frame.size.height)
        //
        //        border.borderWidth = width
        //        txtQtyValue.layer.addSublayer(border)
        //        txtQtyValue.layer.masksToBounds = true
        
        header.addSubview(txtQtyValue)
        
        lblPrice.text = "/ Price"
        lblPrice.textColor = .gray
        //lblPrice.backgroundColor = .white
        lblPrice.font = UIFont(name: "HelveticaNeue", size: 13.0)!
        lblPrice.textAlignment = .left
        //header.addSubview(lblPrice)
        //        var strinText:String = (txtQtyValue.text)!
        //
        //        if (txtQtyValue.text?.isEmpty)!{
        //            strinText = "0"
        
        //  }
        //        let qtyV:Int = Int(strinText)!
        //            let UnitPrice:Int = 10
        //            let Total:Int = qtyV * UnitPrice
        //            print(Total)
        //            let  currency = "/$" as String
        //  lblPriceValue.text = currency + String(Total)
        
        lblPriceValue.textColor = .black
        lblPriceValue.backgroundColor = .white
        lblPriceValue.font = UIFont(name: "HelveticaNeue-Bold", size: 14.0)!
        lblPriceValue.textAlignment = .left
        //         lblPriceValue.tag = section+200
        //   header.addSubview(lblPriceValue)
        
        
        // let btnQtyReduce
      
        let theImageView = UIImageView(frame: CGRect(x: screenSize.width - 32, y: 50, width: 18, height: 18));
        theImageView.image = UIImage(named: "chevron-down")
        theImageView.tag =   section+10000
        header.addSubview(theImageView)
        
        
        
        
        
        // make headers touchable
        header.tag = section+20000
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(stockUpdateViewController.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
        
        let listener : String =  EditedSectionArray[section] as! String
        if  listener == "1"
        {
            
            header.backgroundColor = hexStringToUIColor(hex: "#ffebee")
            
        }
        else
        {
            
            header.backgroundColor = .white
            
        }
        return header
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QtyCell", for: indexPath) as! QtyTableviewCell
        
        if (cell == nil)
        {
            tableView.register(UINib(nibName:"QtyTableviewCell", bundle: nil), forCellReuseIdentifier: "QtyCell")
        }
        
        let DateValue  = ((self.listOfPreviousTransaction[indexPath.section] as AnyObject)) as! NSArray
        let dateString:String = ((DateValue[indexPath.row] as AnyObject).value(forKey: "transactionDate") as! String)
        
        //let TotalPriceValue  = ((self.listOfPreviousTransaction[indexPath.section] as AnyObject)) as! NSArray
        let TotalString:Int = ((DateValue[indexPath.row] as AnyObject).value(forKey: "totalPrice") as! Int)
        
        //let UnitPriceValue  = ((self.listOfPreviousTransaction[indexPath.section] as AnyObject)) as! NSArray
        
        let UnitString:Int = ((DateValue[indexPath.row] as AnyObject).value(forKey: "unitPrice") as! Int)
//        let stockin:Int = ((DateValue[indexPath.row] as AnyObject).value(forKey: "stockIn") as! Int)
//        let stockout:Int = ((DateValue[indexPath.row] as AnyObject).value(forKey: "stockOut") as! Int)

        let stockIn:Int = (fullData[indexPath.section] as AnyObject ).value(forKey: "stockIn") as! Int
        
        let stockout:Int = (fullData[indexPath.section] as AnyObject ).value(forKey: "stockOut") as! Int

       
        if (indexPath.row == 0)
        {
            cell.lblStockIN.isHidden            = false
            cell.lblStockOUT.isHidden        = false
            cell.stepperStockIN.isHidden   = false
            cell.stepperStockOut.isHidden = false
            
           cell.txtStepperStockIN.frame = CGRect(x: 27, y: 0, width: 45, height: 30)
           cell.txtStepperStockOut.frame = CGRect(x: 27, y: 0, width: 45, height: 30)

            //cell.stepperStockIN.addSubview(cell.txtStepperStockIN)
            //cell.stepperStockOut.addSubview(cell.txtStepperStockOut)

            // self.view.bringSubview(toFront: cell.txtStepperStockIN)
            //cell..bringSubview(toFront: cell.txtStepperStockOut)


            
            cell.stepperStockIN.tag = 100000+(indexPath.section*2)
            cell.stepperStockOut.tag =  100001+(indexPath.section*2)
            
            cell.txtStepperStockIN.tag = (indexPath.section*2)+50000
            cell.txtStepperStockOut.tag = (indexPath.section*2)+50001
            
          
            cell.isUserInteractionEnabled = true
            cell.img.frame         =  CGRect(x: 15.0, y: 83.0, width: 15.0, height: 15.0)
            cell.lblDate.frame    =  CGRect(x: 40.0, y: 81.0, width: 100.0, height: 21.0)
            cell.lblQty.frame      =  CGRect(x: screenSize.width-107, y: 81.0, width: 30.0, height: 21.0)
            cell.lblDivider.frame =  CGRect(x: screenSize.width-75, y: 81.0, width: 15.0, height: 21.0)
            cell.lblPrice.frame    =  CGRect(x: screenSize.width-58, y: 81.0, width: 35.0, height: 21.0)
            cell.lblImgConnector.frame  =  CGRect(x: 21.0, y: 98.0, width: 2.0, height: 28.0)
            cell.lblImgConnector.isHidden = false
            
            cell.stepperStockIN.value   = Double(stockIn)
            cell.stepperStockOut.value = Double(stockout)
        
            let abc =  Int(cell.stepperStockIN.value)
            let def  = Int(cell.stepperStockOut.value)

            cell.txtStepperStockIN.text = String(abc)
            cell.txtStepperStockOut.text = String(def)

            cell.stepperStockIN.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
            cell.stepperStockOut.addTarget(self, action: #selector(stepperValueChanged1), for: .valueChanged)

        }
        else if (indexPath.row == 2)
        {
            cell.stepperStockIN.isHidden    = true
            cell.stepperStockOut.isHidden  = true
            cell.lblStockIN.isHidden            = true
            cell.lblStockOUT.isHidden         = true
            
            cell.img.frame         =  CGRect(x: 15.0, y: 18.0, width: 15.0, height: 15.0)
            cell.lblDate.frame    =  CGRect(x: 40.0, y: 15.0, width: 100.0, height: 21.0)
            cell.lblQty.frame      =  CGRect(x: screenSize.width-107, y: 15.0, width: 30.0, height: 21.0)
            cell.lblDivider.frame =  CGRect(x: screenSize.width-75, y: 15.0, width: 15.0, height: 21.0)
            cell.lblPrice.frame    =  CGRect(x: screenSize.width-58, y: 15.0, width: 35.0, height: 21.0)
            //cell.lblImgConnector.frame  =  CGRect(x: 22.0, y: 33.0, width: 2.0, height: 31.0)
            
            cell.isUserInteractionEnabled = false
            cell.lblImgConnector.isHidden = true
            
        }
            
        else
        {
            cell.stepperStockIN.isHidden    = true
            cell.stepperStockOut.isHidden  = true
            cell.lblStockIN.isHidden            = true
            cell.lblStockOUT.isHidden         = true
         
            cell.img.frame         =  CGRect(x: 15.0, y: 17.0, width: 15.0, height: 15.0)
            cell.lblDate.frame    =  CGRect(x: 40.0, y: 14.0, width: 100.0, height: 21.0)
            cell.lblQty.frame      =  CGRect(x: screenSize.width-107, y: 14.0, width: 30.0, height: 21.0)
            cell.lblDivider.frame =  CGRect(x: screenSize.width-75, y: 14.0, width: 15.0, height: 21.0)
            cell.lblPrice.frame    =  CGRect(x: screenSize.width-58, y: 14.0, width: 32.0, height: 21.0)
            cell.lblImgConnector.frame  =  CGRect(x: 21.0, y: 32.0, width: 2.0, height: 28.0)
            cell.lblImgConnector.isHidden = false
            cell.isUserInteractionEnabled = false

        }
        cell.selectionStyle = .none
        
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
       self.tableView.separatorColor = .clear
        cell.tag=30000+(indexPath.section*3)+indexPath.row
        return cell

    }
    
    @objc func stepperValueChanged(stepper: GMStepper)
    {
        print(stepper.value, terminator: "")
        a = Int(stepper.value)
        print(a)
        c = a + b
        print("c--->\(c)")
        print("stepper.tag-->\(stepper.tag)")
        let a1section = (stepper.tag-100000)/2
        print("a1section--->\(a1section)")
       
        // cell.txtStepperStockIN.tag = (indexPath.section*2)+50000
        let txt1 = self.view.viewWithTag((a1section*2)+50000) as? UITextField
        txt1?.text =  String(a)
        
        print("txt1.tag--->\(String(describing: txt1?.tag))")
        print("txt1?.text --->\(String(describing: txt1?.text ))")

        let txtSection = self.view.viewWithTag(a1section+1000) as? UITextField
        txtSection?.text =  String(c)
        print("stepper.tag--->\(stepper.tag)")
        print("txtSection.tag--->\(String(describing: txtSection?.tag))")
        print("txtSection?.text --->\(String(describing: txtSection?.text ))")
      
    //    var arr = fullData[a1section] as! NSMutableArray
    //    let stocksIN: Int = Int((txt1?.text)!)!
    //    arr ["stockIn"]  =  String(stocksIN)
        
       editSection(section: a1section)
        
//        var arrStepperUpdated = NSMutableArray()
//
//        for i in 0..<self.fullData.count
//        {
//            if (a1section  == i)
//            {
////                let txt1 = self.view.viewWithTag((i*2)+50000) as! UITextField
//                let txt2 = self.view.viewWithTag((i*2)+50001) as! UITextField
//
//                let dic = NSMutableDictionary()
//                dic.setValue(txt1?.text, forKey: "stockIn")
//                dic.setValue(txt2.text, forKey: "stockOut")
//                dic.setValue((self.fullData[i] as AnyObject).value(forKey: "listOfPreviousTransaction"), forKey: "listOfPreviousTransaction")
//                arrStepperUpdated.add(dic)
//            }
//
//        }
//        print(arrStepperUpdated)
//
//        fullData =  arrStepperUpdated
//        print("fullData-->\(fullData)")
//
        
        if let currHeaderView = self.view.viewWithTag(a1section+20000) {
            currHeaderView.backgroundColor = hexStringToUIColor(hex: "#ffebee")// .red
        }
        
        for i in 0..<((fullData[a1section] as AnyObject).value(forKey: "listOfPreviousTransaction") as! NSArray).count {
            if let currHeaderView = self.view.viewWithTag((a1section*3)+30000+i) as? UITableViewCell {
                currHeaderView.backgroundColor = hexStringToUIColor(hex: "#ffebee")//.red
            }
        }
        
        
//        print(lbl1!)
//        arrLabel[a4] = lbl1?.text
//        print(arrLabel)
// tableView.reloadData()
        
        
    }
    
    @objc func stepperValueChanged1(stepper: GMStepper)
    {
        print(stepper.value, terminator: "")
        b = Int(stepper.value)
        print(b)
        c = a + b
        print("c--->\(c)")
      
        let a2section = (stepper.tag-100000)/2
        print("a2section--->\(a2section)")
        print("a2section--->\(a2section)")
        print("stepper.tag--->\(stepper.tag)")
        
        // let txt1 = self.view.viewWithTag((a1section*2)+50000) as? UITextField

        let txt2 = self.view.viewWithTag((a2section*2)+50001) as? UITextField
        txt2?.text =  String(b)

        let txtSection = self.view.viewWithTag(a2section+1000) as? UITextField
        txtSection?.text =  String(c)
        editSection(section: a2section)

        //tableView.reloadData()

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
    

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Expand / Collapse Methods
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer)
    {
        let headerView  = sender.view as! UIView
        let section         = headerView.tag-20000
        let eImageView = self.view.viewWithTag(section+10000) as? UIImageView
      
        if (self.expandedSectionHeaderNumber == -1) {
            //expand
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section,imageView: eImageView!)
        }
        else
        {
            //collapse
            if (self.expandedSectionHeaderNumber == section)
            {
                tableViewCollapeSection(section,imageView: eImageView!)
            }
            else
            {
                let cImageView = self.view.viewWithTag(self.expandedSectionHeaderNumber+10000) as? UIImageView
                print(self.expandedSectionHeaderNumber)
               tableViewCollapeSection(self.expandedSectionHeaderNumber,imageView: cImageView!)
               tableViewExpandSection(section,imageView: eImageView!)
                
            }
        }
        
    }
    
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView)
    {

        let sectionData = self.listOfDatesPreviousTransaction[section] as! NSArray
        
        self.expandedSectionHeaderNumber = -1;
        if (sectionData.count == 0)
        {
            return;
        }
        else
        {
            UIView.animate(withDuration: 0.1, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            
//           if  let img = self.view.viewWithTag(10000+section) as? UIImageView {
//                img.image=UIImage.init(named: "chevron-down.png")
//            }
            
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
    
    func tableViewExpandSection(_ section: Int,imageView: UIImageView)
    {

        let sectionData = (self.fullData[section] as AnyObject).value(forKey: "listOfPreviousTransaction") as! NSArray
      //  expandedSectionHeader.backgroundColor = hexStringToUIColor(hex: "#ffebee")
        if (sectionData.count == 0)
        {
            self.expandedSectionHeaderNumber = -1;
            return;
        }
        else {
            UIView.animate(withDuration: 0.1, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
        })
//            if  let img = self.view.viewWithTag(10000+section) as? UIImageView {
//                img.image=UIImage.init(named: "chevron-up.png")
//            }
            
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
    
    
    
    //Text field delegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return true
    }
   
    func textFieldDidEndEditing(_ textField: UITextField)
    {
//        let QP:Int = Int(textField.text!)!
//        let UP:Int = 5
//        let TP:Int = QP * UP
//        strStockINQtyMinusValue = String(TP)
//

    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //textField.text
        textField.resignFirstResponder()
    //    tableView.reloadData()
        return true

    }




}

