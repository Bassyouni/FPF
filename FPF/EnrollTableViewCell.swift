//
//  EnrollTableViewCell.swift
//  FPF
//
//  Created by Bassyouni on 10/14/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class EnrollTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func EnrollBtnPressed(_ sender: Any) {
    }
}
