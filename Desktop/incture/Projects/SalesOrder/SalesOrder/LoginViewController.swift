//
//  LoginViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 31/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var txtUserName: UITextField!
    
    @IBOutlet var txtPassword: UITextField!
    
    @IBOutlet var btnLogin: UIButton!
    
    
    @IBAction func didActionLogin(_ sender: Any)
    {
       txtUserName.text = "SW012890"
        if self.txtUserName.text == "" || self.txtPassword.text == ""
        {
            let alertController = UIAlertController(title: "Error", message: "Please enter Valid Credentials", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "dashboard") as! ViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
