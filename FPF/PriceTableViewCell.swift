//
//  PriceTableViewCell.swift
//  FPF
//
//  Created by Bassyouni on 10/14/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var sessionView: UIView!
    @IBOutlet weak var sessionPrice: UILabel!
    
    @IBOutlet weak var eightSessionsView: UIView!
    @IBOutlet weak var eightSessionPrice: UILabel!
    
    @IBOutlet weak var sixteenSessionsView: UIView!
    @IBOutlet weak var sixteenSessionPrice: UILabel!
    
    func configureCell(course: Course)
    {
        if course.pricePerSession == "none"
        {
            sessionView.isHidden = true
        }
        else
        {
            sessionPrice.text = course.pricePerSession
            sessionView.isHidden = false
        }
        
        if course.pricePerMonth8Sessions == "none"
        {
            eightSessionsView.isHidden = true
        }
        else
        {
            eightSessionPrice.text = course.pricePerMonth8Sessions
            eightSessionsView.isHidden = false
        }
        
        if course.pricePerMonth12Sessions == "none"
        {
            sixteenSessionsView.isHidden = true
        }
        else
        {
            sixteenSessionPrice.text = course.pricePerMonth12Sessions
            sixteenSessionsView.isHidden = false
        }
        
    }

}
