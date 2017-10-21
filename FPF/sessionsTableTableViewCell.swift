//
//  sessionsTableTableViewCell.swift
//  FPF
//
//  Created by Bassyouni on 10/21/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class sessionsTableTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftSessionsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        /* make collection view shrink based on content size , by the next 3 lines of code , and also setting its height constraint priority to 999 source : https://stackoverflow.com/questions/42437966/how-to-adjust-height-of-uicollectionview-to-be-the-height
         */
        
        let height: CGFloat = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeightConstraint.constant = height
        self.setNeedsLayout()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension sessionsTableTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sessionsTableCollectionViewCell", for: indexPath) as? sessionsTableCollectionViewCell
        {
            return cell
        }
        else { return UICollectionViewCell() }
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
//        return CGSize(width: CGFloat((collectionView.frame.size.width / 4) - 10), height: CGFloat(80))
    }
}
