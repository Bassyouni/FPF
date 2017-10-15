//
//  PriceTableViewCell.swift
//  FPF
//
//  Created by Bassyouni on 10/14/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var seassionView: UIView!
    @IBOutlet weak var seassionPrice: UILabel!
    
    @IBOutlet weak var eightSeassionsView: UIView!
    @IBOutlet weak var eaightSessionPrice: UILabel!
    
    @IBOutlet weak var sixteenSeassionsView: UIView!
    @IBOutlet weak var sixteenSeassionPrice: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
