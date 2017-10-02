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
    
    func configureCell(title:String , quote: String , image: String)
    {
        gameImageView.image = UIImage(named: image)
        self.titleLabel.text = title
        self.quoteLabel.text = quote
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
