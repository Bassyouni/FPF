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
    
    
    
    
}
