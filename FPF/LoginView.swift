//
//  LoginView.swift
//  FPF
//
//  Created by Bassyouni on 9/26/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

@IBDesignable
class LoginView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor =  UIColor(red: shadowGray, green: shadowGray, blue: shadowGray, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
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
        layer.cornerRadius = cornerRadius
        layer.shadowColor =  UIColor(red: shadowGray, green: shadowGray, blue: shadowGray, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

}
