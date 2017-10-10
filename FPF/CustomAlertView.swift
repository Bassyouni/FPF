//
//  CustomAlertView.swift
//  FPF
//
//  Created by Bassyouni on 10/10/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class CustomAlertView: UIView {

    @IBOutlet weak var goToNextPageBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
}
