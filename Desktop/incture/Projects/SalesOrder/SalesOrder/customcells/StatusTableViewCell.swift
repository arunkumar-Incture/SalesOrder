//
//  StatusTableViewCell.swift
//  SalesOrder
//
//  Created by Arun Kumar on 04/06/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {

    @IBOutlet var lblOrderSubmit: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblCompleted: UILabel!    
    @IBOutlet var imgTimeline: UIImageView!
    @IBOutlet var lblimgConnector: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
