//
//  LoginButton.swift
//  FPF
//
//  Created by Bassyouni on 9/27/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit
@IBDesignable
class LoginButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor =  UIColor(red: shadowGray, green: shadowGray, blue: shadowGray, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        setupView()
        
    }
    
    
    @IBInspectable var cornerRadius: CGFloat = 30.0
        {
        didSet
        {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView()
    {
        layer.borderWidth = 2
        layer.masksToBounds = false
        layer.borderColor = UIColor(red: 11/255 , green: 69/255, blue: 156/255, alpha: 1).cgColor
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }

}
