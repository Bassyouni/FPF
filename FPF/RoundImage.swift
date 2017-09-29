//
//  RoundImage.swift
//  FPF
//
//  Created by Bassyouni on 9/27/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

@IBDesignable
class RoundImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor =  UIColor(red: shadowGray, green: shadowGray, blue: shadowGray, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        setupView()

    }
    
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView()
    {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
    }

}
