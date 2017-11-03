//
//  EnrollTableViewCell.swift
//  FPF
//
//  Created by Bassyouni on 10/14/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class EnrollTableViewCell: UITableViewCell {

    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var enrollBtn: LoginButton!
    @IBOutlet weak var courseDescription: UILabel!
    

    func configureCell(course: Course)
    {
        if course.id == "1"
        {
            courseImage.image = UIImage(named: "parkour in details layout")
        }
        else if course.id == "2"
        {
            courseImage.image = UIImage(named: "mma in details layout")
        }
        else if course.id == "3"
        {
            courseImage.image = UIImage(named: "street_workout in details layout")
        }
        
        courseDescription.text = course.description
    }
//    @IBAction func EnrollBtnPressed(_ sender: Any) {
//        showAlert()
//    }
    
    func showAlert() {
        if let alert = Bundle.main.loadNibNamed("EnrollAlert", owner: self, options: nil)?.last as? EnrollAlertView
        {
            
            self.superview?.addSubview(alert)
            alert.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: (UIScreen.main.bounds.size.height / 2)-20)
            
            alert.tag = 100
            
            let aSelector : Selector = #selector(EnrollTableViewCell.removeSubview)
            let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
            alert.addGestureRecognizer(tapGesture)
            
        }
    }

    func removeSubview()
    {
        print("Start remove sibview")
        if let viewWithTag = self.superview?.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
    }
    
 
    
}
