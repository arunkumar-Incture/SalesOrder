//
//  PersonViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 17/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {
    var selectedname = NSNumber.self
    override func viewDidLoad()
    {
        super.viewDidLoad()
     //   print(Customer)
        // Do any additional setup after loading the view.
    }
    @IBAction func didActionBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
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
