//
//  Course.swift
//  FPF
//
//  Created by Bassyouni on 10/19/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import Foundation

class Course
{
    private var _id: String!
    private var _name: String!
    private var _description: String!
    private var _quote: String!
    private var _team: String!
    private var _day1: String!
    private var _day2: String!
    private var _day3: String!
    private var _time1: String!
    private var _time2: String!
    private var _time3: String!
    private var _pricePerSession: String!
    private var _pricePerMonth8Sessions: String!
    private var _pricePerMonth12Sessions: String!
    
    let quotes = ["1":"Be the movement" , "2":"Mixed Martial Art" , "3": "Push beyond your limits"]
    
    init() {
        _id = ""
        _name = ""
        _description = ""
        _quote = ""
        _team = ""
        _day1 = ""
        _day2 = ""
        _day3 = ""
        _time1 = ""
        _time2 = ""
        _time3 = ""
        _pricePerSession = ""
        _pricePerMonth8Sessions = ""
        _pricePerMonth12Sessions = ""
    }
    
    func populateClassFromApi(dict: Dictionary<String , String>)
    {
        if let id = dict["ID"]
        {
            _id = id
            _quote = quotes[id]
        }
        if let name = dict["Name"]
        {
            _name = name
        }
        if let description = dict["Description"]
        {
            _description = description
        }
        if let team = dict["Team"]
        {
            _team = team
        }
        if let day1 = dict["day1"]
        {
            _day1 = day1
        }
        if let day1 = dict["day1"]
        {
            _day1 = day1
        }
        if let day2 = dict["day2"]
        {
            _day2 = day2
        }
        if let day3 = dict["day3"]
        {
            _day3 = day3
        }
        if let time1 = dict["time1"]
        {
            _time1 = time1
        }
        if let time2 = dict["time2"]
        {
            _time2 = time2
        }
        if let time3 = dict["time3"]
        {
            _time3 = time3
        }
        if let pricePerSession = dict["price_per_session"]
        {
            _pricePerSession = pricePerSession
        }
        if let pricePerMonth8Sessions = dict["price_per_month_8sessions"]
        {
            _pricePerMonth8Sessions = pricePerMonth8Sessions
        }
        if let pricePerMonth12Sessions = dict["price_per_month_12sessions"]
        {
            _pricePerMonth12Sessions = pricePerMonth12Sessions
        }
    }
    
     var id: String
     {
        get{return _id}
        set{_id = newValue}
     }
     var name: String
     {
        get{return _name}
        set{_name = newValue}
     }
     var description: String
     {
        get{return _description}
        set{_description = newValue}
     }
    var quote: String
    {
        get{return _quote}
        set{_quote = newValue}
    }
     var team: String
     {
        get{return _team}
        set{_team = newValue}
     }
     var day1: String
     {
        get{return _day1}
        set{_day1 = newValue}
     }
     var day2: String
     {
        get{return _day2}
        set{_day2 = newValue}
     }
     var day3: String
     {
        get{return _day3}
        set{_day3 = newValue}
     }
     var time1: String
     {
        get{return _time1}
        set{_time1 = newValue}
     }
     var time2: String
     {
        get{return _time2}
        set{_time2 = newValue}
     }
     var time3: String
     {
        get{return _time3}
        set{_time3 = newValue}
     }
     var pricePerSession: String
     {
        get{return _pricePerSession}
        set{_pricePerSession = newValue}
     }
     var pricePerMonth8Sessions: String
     {
        get{return _pricePerMonth8Sessions}
        set{_pricePerMonth8Sessions = newValue}
     }
     var pricePerMonth12Sessions: String
     {
        get{return _pricePerMonth12Sessions}
        set{_pricePerMonth12Sessions = newValue}
     }
    
    
}
