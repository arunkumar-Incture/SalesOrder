//
//  SalesOrderCustomTableViewCell.swift
//  SalesOrder
//
//  Created by Arun Kumar on 29/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class SalesOrderCustomTableViewCell: UITableViewCell {

    @IBOutlet var lblDescription: UILabel!
    
    @IBOutlet var lblDescribtionValue: UILabel!
    @IBOutlet var lblUOM: UILabel!
    @IBOutlet var lblUOMValue: UILabel!
    @IBOutlet var lblUnitPrice: UILabel!
    @IBOutlet var lblUnitPriceValue: UILabel!
    @IBOutlet var lblTax: UILabel!
    @IBOutlet var lblTaxValue: UILabel!
    @IBOutlet var img: UIImageView!
    
    @IBOutlet var lblImgConnector: UILabel!
    
    
    
    
    @IBOutlet var lblDate: UILabel!
    
    @IBOutlet var lblQty: UILabel!
    
    @IBOutlet var lblPrice: UILabel!
    
    @IBOutlet var lblDivider: UILabel!
    
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
