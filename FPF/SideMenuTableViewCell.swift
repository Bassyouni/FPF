//
//  SideMenuTableViewCell.swift
//  Marriage
//
//  Created by ZooZoo on 6/17/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet var lblMenu : UILabel!
    @IBOutlet var imgMenu : UIImageView!
    @IBOutlet var viewMenu : UIView!
    
    func configureCell(title: String)
    {
        self.lblMenu.text = title
        self.imgMenu.image = UIImage(named: title)
        if title == "Profile"
        {
            imgMenu.image = imgMenu.image?.withRenderingMode(.alwaysTemplate)
            imgMenu.tintColor = UIColor.gray
        }
        if title == "Activity"
        {
            imgMenu.image = imgMenu.image?.withRenderingMode(.alwaysTemplate)
            imgMenu.tintColor = UIColor.darkGray
        }
        
    }

}
