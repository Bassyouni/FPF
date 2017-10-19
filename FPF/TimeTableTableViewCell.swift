//
//  TimeTableTableViewCell.swift
//  FPF
//
//  Created by Bassyouni on 10/14/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class TimeTableTableViewCell: UITableViewCell {

    
    @IBOutlet weak var firstDayView: UIView!
    @IBOutlet weak var firstViewDayLabel: UILabel!
    @IBOutlet weak var firstViewTimeLabel: UILabel!

    @IBOutlet weak var secondDayView: UIView!
    @IBOutlet weak var secondViewDayLabel: UILabel!
    @IBOutlet weak var secondViewTimeLabel: UILabel!
    
    
    @IBOutlet weak var thirdDayView: UIView!
    @IBOutlet weak var thirdViewDayLabel: UILabel!
    @IBOutlet weak var thirdViewTimeLabel: UILabel!
    
    
    func configureCell(course: Course)
    {
        //TODO: other exeptions like none and stuff
        if course.day1 == "none" || course.time1 == "none"
        {
            firstDayView.isHidden = true
        }
        else
        {
            firstDayView.isHidden = false
            firstViewDayLabel.text = course.day1
            firstViewTimeLabel.text = course.time1
        }
        
        if course.day2 == "none" || course.time2 == "none"
        {
            secondDayView.isHidden = true
        }
        else
        {
            secondDayView.isHidden = false
            secondViewDayLabel.text = course.day2
            secondViewTimeLabel.text = course.time2
        }
        
        if course.day3 == "none" || course.time3 == "none"
        {
            thirdDayView.isHidden = true
        }
        else
        {
            thirdDayView.isHidden = false
            thirdViewDayLabel.text = course.day3
            thirdViewTimeLabel.text = course.time3
        }
        
        
    }

}
