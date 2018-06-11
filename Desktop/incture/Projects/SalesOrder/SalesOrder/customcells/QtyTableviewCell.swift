//
//  QtyTableviewCell.swift
//  SalesOrder
//
//  Created by Arun Kumar on 29/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class QtyTableviewCell: UITableViewCell,UITextFieldDelegate {

    
    
    @IBOutlet var lblQtyStepper1: UILabel!
    
    @IBOutlet var lblQtyStepper2: UILabel!
    
  //  @IBOutlet var stepper1: UIStepper!
    
    
 //   @IBOutlet var stepper2: UIStepper!
    
    @IBOutlet var img: UIImageView!
  
    @IBOutlet var lblImgConnector: UILabel!
    
    
    
    @IBOutlet var lblDate: UILabel!
    
    @IBOutlet var lblQty: UILabel!
    @IBOutlet var lblDivider: UILabel!
    
    @IBOutlet var lblPrice: UILabel!
    
    
    @IBOutlet var lblStockIN: UILabel!
    
    @IBOutlet var lblStockOUT: UILabel!

//    @IBOutlet var btnStockInMinus: UIButton!
//    
//    @IBOutlet var btnStockInPlus: UIButton!
//    
//    @IBOutlet var btnStockOutMinus: UIButton!
//    
//    @IBOutlet var btnStockOutPlus: UIButton!
//    
    
    @IBOutlet var stepperStockIN: GMStepper!
    
    
    @IBOutlet var stepperStockOut: GMStepper!
    
    @IBOutlet var txtStepperStockIN: UITextField!
    
    @IBOutlet var txtStepperStockOut: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
     

      
        
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {

        let a4 = ((textField.tag) - 50000)/2  // first text field
        let txtFieldTag2 = (textField.tag)%2
        print("a4--->\(a4)") // section value
        print("txtFieldTag2--->\(txtFieldTag2)") // section value
        var sample:Int = 0
       
        if txtFieldTag2 == 0
        {
            let  txt1 = self.viewWithTag(textField.tag+1) as? UITextField
            if (textField.text == "")
            {
                
                textField.text = "0"
            }
            sample = Int((txt1?.text)!)! + Int(textField.text!)!
            print("sample--->\(sample)") // textfield value

        }
        else
        {
            let  txt1 = self.viewWithTag(textField.tag-1) as? UITextField
            if (textField.text == "")
            {
                
                textField.text = "0"
            }
            sample = Int((txt1?.text)!)! + Int(textField.text!)!
            print("sample--->\(sample)") // text value
        }
        var arrTextField  = NSMutableArray()
        arrTextField = [a4,sample]    // section,textfieldvalue
        print("arrTextField--->\(arrTextField)")
        NotificationCenter.default.post(name: Notification.Name("getTextfieldDataFromQtyTableViewCell"), object: arrTextField)
    return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
