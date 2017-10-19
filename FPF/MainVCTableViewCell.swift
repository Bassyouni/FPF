//
//  MainVCTableViewCell.swift
//  FPF
//
//  Created by Bassyouni on 10/2/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class MainVCTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(course: Course)
    {
        if course.id == "1"
        {
            gameImageView.image = UIImage(named: "parkour_item in list")
        }
        else if course.id == "2"
        {
            gameImageView.image = UIImage(named: "mma_item in list")
        }
        else if course.id == "3"
        {
            gameImageView.image = UIImage(named: "street_workout_item in list")
        }
        
        self.titleLabel.text = course.name
        self.quoteLabel.text = course.quote
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
