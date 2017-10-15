//
//  TimeTableTableViewCell.swift
//  FPF
//
//  Created by Bassyouni on 10/14/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class TimeTableTableViewCell: UITableViewCell {

    
    @IBOutlet weak var firstViewDayLabel: UILabel!
    @IBOutlet weak var firstViewTimeLabel: UILabel!

    @IBOutlet weak var secondViewDayLabel: UILabel!
    @IBOutlet weak var secondViewTimeLabel: UILabel!
    
    @IBOutlet weak var thirdViewDayLabel: UILabel!
    @IBOutlet weak var thirdViewTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
