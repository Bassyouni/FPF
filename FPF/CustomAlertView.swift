//
//  CustomAlertView.swift
//  FPF
//
//  Created by Bassyouni on 10/10/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class CustomAlertView: UIView {

    @IBOutlet weak var alertHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var goToNextPageBtn: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
}
