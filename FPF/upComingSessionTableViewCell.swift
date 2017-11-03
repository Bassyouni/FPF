//
//  upComingSessionTableViewCell.swift
//  FPF
//
//  Created by Bassyouni on 10/21/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class upComingSessionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var youHaveASession: UILabel!

    func configureCell(course: Course)
    {
        let date = Date()
        let calender = Calendar.current
        var weekDay = calender.component(.weekday, from: date)
        let hour = calender.component(.hour, from: date)
        let daysDict = [1: "Sunday" , 2: "Monday" , 3: "Tuesday", 4: "Wednesday", 5: "Thursday " , 6: "Friday" , 7: "Saturday"]
        var isToday = false

        
        if daysDict[weekDay] == course.day1
        {
            if hour < 18
            {
                isToday = true
                youHaveASession.text = "You have a session today on"
                time.text = course.time1
            }
            else
            {
                isToday = false
            }
        }
        else if daysDict[weekDay] == course.day2
        {
            if hour < 18
            {
                isToday = true
                youHaveASession.text = "You have a session today on"
                time.text = course.time2
            }
            else
            {
                isToday = false
            }
        }
        else if daysDict[weekDay] == course.day3
        {
            if hour < 18
            {
                isToday = true
                youHaveASession.text = "You have a session today on"
                time.text = course.time3
            }
            else
            {
                isToday = false
            }
        }
        
        while !isToday
        {
            if weekDay == 7
            {
                weekDay = 1
            }
            else
            {
                weekDay += 1
            }
            
            if daysDict[weekDay] == course.day1
            {
                youHaveASession.text = "You have a session on \(course.day1)"
                time.text = course.time1
                isToday = true
            }
            else if daysDict[weekDay] == course.day2
            {
                youHaveASession.text = "You have a session on \(course.day2)"
                time.text = course.time2
                isToday = true
            }
            else if daysDict[weekDay] == course.day3
            {
                youHaveASession.text = "You have a session on \(course.day3)"
                time.text = course.time3
                isToday = true
            }
            
        }
    }

}
