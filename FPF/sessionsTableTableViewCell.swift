//
//  sessionsTableTableViewCell.swift
//  FPF
//
//  Created by Bassyouni on 10/21/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class sessionsTableTableViewCell: UITableViewCell {
    @IBOutlet weak var freezeModeView: UIView!

//    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftSessionsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var seassionsArray = [String]()
    var type: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        /* make collection view shrink based on content size , by the next 3 lines of code , and also setting its height constraint priority to 999 source : https://stackoverflow.com/questions/42437966/how-to-adjust-height-of-uicollectionview-to-be-the-height
         */
//        
//        let height: CGFloat = collectionView.collectionViewLayout.collectionViewContentSize.height
//        collectionViewHeightConstraint.constant = height
//        self.setNeedsLayout()
        
        
    }

    func configureCell(state: String , sessions: [String], type: String)
    {
        if state == "none"
        {
            freezeModeView.isHidden = false
        }
        else if state == "active"
        {
            freezeModeView.isHidden = true
        }
        
        
        self.type = type
        seassionsArray = sessions
        
        var count = 0
        if type == "8_session"
        {
            count = 7
        }
        else
        {
            count = 11
        }
        var leftCount = 0
        for i in (0...count).reversed()
        {
            if seassionsArray[i] == "false"
            {
                leftCount += 1
            }
            else
            {
                break
            }
        }

        self.leftSessionsLabel.text = "You have \(leftCount) session(s) left."
        
        self.collectionView.reloadData()
    }

}

extension sessionsTableTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == "12_session"
        {
            return 12
        }
        else if type == "8_session"
        {
            return 8
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sessionsTableCollectionViewCell", for: indexPath) as? sessionsTableCollectionViewCell
        {
//            let height: CGFloat = collectionView.collectionViewLayout.collectionViewContentSize.height
//            collectionViewHeightConstraint.constant = height
//            self.setNeedsLayout()

            cell.configureCell(session: seassionsArray[indexPath.row])
            return cell
        }
        else { return UICollectionViewCell() }
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
//        return CGSize(width: CGFloat((collectionView.frame.size.width / 4) - 10), height: CGFloat(80))
    }
}
