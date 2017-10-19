//
//  Constants.swift
//  FPF
//
//  Created by Bassyouni on 9/26/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

let shadowGray: CGFloat = 120.0  / 255.0
let customBlueColor : UIColor = UIColor(red: 11/255 , green: 69/255, blue: 156/255, alpha: 1)

typealias DownloadCompleted = () -> ()

let mainUrl = "http://fpftest.000webhostapp.com/FPF/"

let addToMyCoursesUrl = "\(mainUrl)Add_To_My_Courses.php"
let editPasswordUrl = "\(mainUrl)Edit_Password.php"
let editUserInfoUrl = "\(mainUrl)Edit_user_info.php"
let inviteFriendUrl = "\(mainUrl)Invite_friend.php"
let showCourseTableUrl = "\(mainUrl)Show_Course_table.php"
let showCoursesUrl = "\(mainUrl)Show_Courses.php"
let showCoursesToUserUrl = "\(mainUrl)Show_Courses_To_User.php"
let showMyCoursesUrl = "\(mainUrl)Show_My_Courses.php"
let showProfileUrl = "\(mainUrl)Show_Profile.php"
let signInUrl = "\(mainUrl)Signin.php"
let signUpUrl = "\(mainUrl)Signup.php"
let updateSeassionsUrl = "\(mainUrl)Update_sessions.php"

var userID = "15"
var userMobile = ""
var userFname = ""
var userSName = ""
var userImage = ""
var userAge: Int = 0
var userGender = ""
var userPMobile = ""
