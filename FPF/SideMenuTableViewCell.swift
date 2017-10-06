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
    }

}
