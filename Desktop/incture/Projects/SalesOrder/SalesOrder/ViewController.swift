//
//  ViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 16/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var rgtButton  = UIButton()
   
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = true
        navigationController?.title = "Sales Cockpit"
    
        
        button1.layer.shadowColor = UIColor.black.cgColor
        button1.layer.shadowOffset = CGSize(width: 5, height: 5)
        button1.layer.shadowRadius = 5
        button1.layer.shadowOpacity = 1.0

        button2.layer.shadowColor = UIColor.black.cgColor
        button2.layer.shadowOffset = CGSize(width: 5, height: 5)
        button2.layer.shadowRadius = 5
        button2.layer.shadowOpacity = 1.0
      
        button3.layer.shadowColor = UIColor.black.cgColor
        button3.layer.shadowOffset = CGSize(width: 5, height: 5)
        button3.layer.shadowRadius = 5
        button3.layer.shadowOpacity = 1.0
        
        button4.layer.shadowColor = UIColor.black.cgColor
        button4.layer.shadowOffset = CGSize(width: 5, height: 5)
        button4.layer.shadowRadius = 5
        button4.layer.shadowOpacity = 1.0
        
        button5.layer.shadowColor = UIColor.black.cgColor
        button5.layer.shadowOffset = CGSize(width: 5, height: 5)
        button5.layer.shadowRadius = 5
        button5.layer.shadowOpacity = 1.0
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func didActionClosingStock(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CS") as! CustomerSearchViewController
        nextViewController.stringTag = "1"
        nextViewController.stringTitle = "Closing Stock"
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    @IBAction func didActionSalesOrder(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CS") as! CustomerSearchViewController
        nextViewController.stringTag = "2"
        nextViewController.stringTitle = "Sales Order"
        self.navigationController?.pushViewController(nextViewController, animated: true)
        //stringTag
    }
    
    
    @IBAction func didActionBilling(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CS") as! CustomerSearchViewController
        nextViewController.stringTag = "3"
        nextViewController.stringTitle = "Billing"
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
    
    @IBAction func didActionStatus(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CS") as! CustomerSearchViewController
        nextViewController.stringTag = "4"
        nextViewController.stringTitle = "Status"
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    
    
}

