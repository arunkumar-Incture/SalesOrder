//
//  CustomTableViewCell.swift
//  sampleSwift
//
//  Created by Sathya M on 28/02/17.
//  Copyright © 2017 IBS. All rights reserved.
//

import UIKit
import QuartzCore

class CustomTableViewCell: UITableViewCell {
    var myLabel1: UILabel!
//    var myLabel2: UILabel!
//    var myLabel3 : UILabel!
//    var myLabel4 : UILabel!
//    var myLabel5 : UILabel!
//    var myLabel6 : UILabel!
//    var myLabel7 : UILabel!

    
  //  var imgFlight : UIImageView!
    let imgFlight = UIImageView()
  //  let imgPrice = UIImageView()

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let gap : CGFloat = 15.0
        let labelHeight: CGFloat = 30.0
        let labelWidth: CGFloat = 80.0
        let lineGap : CGFloat = 5
        let label2Y : CGFloat = gap + labelHeight + lineGap
        let imageSize : CGFloat = 30
        
        myLabel1 = UILabel()
       
        imgFlight.frame = CGRect(x: 15, y: 5, width: 50, height: 50)
        
        myLabel1.backgroundColor = UIColor.clear

         imgFlight.backgroundColor = UIColor.clear
        myLabel1.frame = CGRect(x: 80, y: gap, width: 150, height: labelHeight)
        
        myLabel1.textColor = UIColor.black
        contentView.addSubview(myLabel1)
        contentView.addSubview(imgFlight)

        
    }
    
}
