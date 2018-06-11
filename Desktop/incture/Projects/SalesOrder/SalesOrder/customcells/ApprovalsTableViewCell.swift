//
//  ApprovalsTableViewCell.swift
//  SalesOrder
//
//  Created by Arun Kumar on 04/06/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class ApprovalsTableViewCell: UITableViewCell {

    @IBOutlet var lblLeftBorder: UILabel!
    @IBOutlet var lblCustomerInitial: UILabel!
    @IBOutlet var lblReferenceNo: UILabel!
    
    @IBOutlet var lblCustomer: UILabel!
    
    @IBOutlet var lblCustomerValue: UILabel!
    @IBOutlet var lblSoldTo: UILabel!
    
    @IBOutlet var lblSoldToAddress: UILabel!
    
    @IBOutlet var lblShipTo: UILabel!
    
    @IBOutlet var lblShipToAddress: UILabel!
    
    @IBOutlet var lblOrderAmt: UILabel!
    
    @IBOutlet var lblOrderAmtValue: UILabel!
    
    @IBOutlet var lblExceededAmt: UILabel!
    
    @IBOutlet var lblExceededAmtValue: UILabel!
    
    @IBOutlet var btnApprove: UIButton!
    
    @IBOutlet var btnReject: UIButton!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
