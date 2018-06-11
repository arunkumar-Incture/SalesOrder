//
//  CustomTableViewCell1.swift
//  sampleSwift
//
//  Created by Sathya M on 28/02/17.
//  Copyright © 2017 IBS. All rights reserved.
//

import UIKit
import QuartzCore

class CustomTableViewCell1: UITableViewCell {
    var myLabel1: UILabel!
    var myLabel2: UILabel!
    var myLabel3 : UILabel!
    var myLabel4 : UILabel!
    var myLabel5 : UILabel!
    var myLabel6 : UILabel!
//    var myLabel7 : UILabel!

    
  //  var imgFlight : UIImageView!
  //  let imgFlight = UIImageView()
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
        myLabel1.backgroundColor = UIColor.clear
        myLabel1.frame = CGRect(x: 20, y: gap, width: 150, height: labelHeight)
        myLabel1.textColor = UIColor.black
        
        myLabel2 = UILabel()
        myLabel2.backgroundColor = UIColor.clear
        myLabel2.frame = CGRect(x: 20, y: myLabel1.frame.origin.y+myLabel1.frame.size.height+2, width: 150, height: labelHeight)
        myLabel2.textColor = UIColor.black
        
        myLabel3 = UILabel()
        myLabel3.backgroundColor = UIColor.clear
        myLabel3.frame = CGRect(x: 20, y: myLabel2.frame.origin.y+myLabel2.frame.size.height+2, width: 150, height: labelHeight)
        myLabel3.textColor = UIColor.black
        contentView.addSubview(myLabel1)
        contentView.addSubview(myLabel2)
        contentView.addSubview(myLabel3)

      //  contentView.addSubview(imgFlight)

        myLabel4 = UILabel()
        myLabel4.backgroundColor = UIColor.clear
        myLabel4.frame = CGRect(x: myLabel1.frame.origin.x+myLabel1.frame.size.width+2, y: gap, width: 150, height: labelHeight)
        myLabel4.textColor = UIColor.black
        
        myLabel5 = UILabel()
        myLabel5.backgroundColor = UIColor.clear
        myLabel5.frame = CGRect(x: myLabel1.frame.origin.x+myLabel1.frame.size.width+2, y: myLabel4.frame.origin.y+myLabel4.frame.size.height+2, width: 150, height: labelHeight)
        myLabel5.textColor = UIColor.black
        
        myLabel6 = UILabel()
        myLabel6.backgroundColor = UIColor.clear
        myLabel6.frame = CGRect(x: myLabel3.frame.origin.x+myLabel3.frame.size.width+2, y: myLabel5.frame.origin.y+myLabel5.frame.size.height+2, width: 150, height: labelHeight)
        myLabel6.textColor = UIColor.black
        contentView.addSubview(myLabel4)
        contentView.addSubview(myLabel5)
        contentView.addSubview(myLabel6)

    }
    
}
