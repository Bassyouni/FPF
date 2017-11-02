//
//  sessionsTableCollectionViewCell.swift
//  FPF
//
//  Created by Bassyouni on 10/21/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class sessionsTableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var theLineImageView: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(session: String)
    {
        self.isHidden = false
        if session == "none"
        {
            self.isHidden = true
        }
        else if session == "false"
        {
            theLineImageView.isHidden = true
        }
        else
        {
            theLineImageView.isHidden = false
        }
    }
    
    
    
    
}
