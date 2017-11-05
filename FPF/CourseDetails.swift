//
//  CourseDetails.swift
//  FPF
//
//  Created by Bassyouni on 10/14/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit
import Alamofire

class CourseDetails: UITableViewController , dismissAllBefore {
    
    //MARK: - variables

    var hud : MBProgressHUD!
    
    var course: Course!
    
    var delegate: reloadMan?
    
    deinit {
        print("courseDetails deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
            self.title = course.name
            if let topItem = self.navigationController?.navigationBar.topItem
            {
                topItem.backBarButtonItem = UIBarButtonItem(title: "" , style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            }
        
        
    }
    
    // MARK: - ibactions
    @IBAction func enrollBtnPressed(_ sender: UIButton) {
        if sender.tag == 100
        {
            if UserDefaults.standard.object(forKey: userID) != nil
            {
                showEnrollAlert()
                self.tableView.isScrollEnabled = false
            }
            else
            {
                showGuestAlert()
            }
            
        }
    }
    
    func showGuestAlert()
    {
        if let alert = Bundle.main.loadNibNamed("GuestAlert", owner: self, options: nil)?.last as? GuestAlertView
        {
            let blackView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            self.navigationController?.view.addSubview(blackView)
            blackView.tag = 500
            blackView.backgroundColor = UIColor.black
            blackView.alpha = 0.400000005960464
            blackView.translatesAutoresizingMaskIntoConstraints = false
            
            
            let leadingConstraint = NSLayoutConstraint(item: blackView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
            let trailingConstraint = NSLayoutConstraint(item: blackView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            let topConstraint = NSLayoutConstraint(item: blackView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: blackView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            self.navigationController?.view.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
            
            self.navigationController?.view.addSubview(alert)
            alert.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: (UIScreen.main.bounds.size.height / 2)-20)
            
            alert.tag = 200
            
            let aSelector : Selector = #selector(EnrollTableViewCell.removeSubview)
            let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
            alert.addGestureRecognizer(tapGesture)
            
            alert.sginUpNowBtn.addTarget(self, action: #selector(self.goToSginupVC), for: UIControlEvents.touchUpInside)
            alert.alreadyHaveAnAccountBtn.addTarget(self, action: #selector(self.goToLoginVC), for: UIControlEvents.touchUpInside)
            
        }
    }
    
    func dissmissAll()
    {
        self.navigationController?.dismiss(animated: false, completion: nil)
    }
    
    func goToSginupVC()
    {
        
        
        if let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
        {
            let delegate = UIApplication.shared.delegate as? AppDelegate
            signupVC.delegate = self
            delegate?.window?.rootViewController = signupVC
        }
        
    }
    
    func goToLoginVC()
    {
       self.navigationController?.dismiss(animated: true, completion: nil)
    }
    // MARK: enrolling sequence
    func showEnrollAlert() {
        if let alert = Bundle.main.loadNibNamed("EnrollAlert", owner: self, options: nil)?.last as? EnrollAlertView
        {
            let blackView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            self.navigationController?.view.addSubview(blackView)
            blackView.tag = 500
            blackView.backgroundColor = UIColor.black
            blackView.alpha = 0.400000005960464
            blackView.translatesAutoresizingMaskIntoConstraints = false
            
            
            let leadingConstraint = NSLayoutConstraint(item: blackView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
            let trailingConstraint = NSLayoutConstraint(item: blackView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            let topConstraint = NSLayoutConstraint(item: blackView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: blackView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            self.navigationController?.view.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
            
            self.navigationController?.view.addSubview(alert)
            alert.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: (UIScreen.main.bounds.size.height / 2)-20)
            
            alert.tag = 200
            
            let aSelector : Selector = #selector(EnrollTableViewCell.removeSubview)
            let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
            alert.addGestureRecognizer(tapGesture)
            
            alert.enrollBtn.addTarget(self, action: #selector(self.enrollToCourse), for: UIControlEvents.touchUpInside)
            
            if course.pricePerSession == "none"
            {
                alert.bySessionBtn.isHidden = true
            }
            if course.pricePerMonth8Sessions == "none"
            {
                alert.monthly8btn.isHidden = true
            }
            if course.pricePerMonth12Sessions == "none" {
                alert.monthly12btn.isHidden = true
            }
        }
    }
    
    func enrollToCourse(alert: UIView)
    {
        
        if let alert = self.navigationController?.view.viewWithTag(200) as? EnrollAlertView
        {
            alert.isUserInteractionEnabled = false
            var selected = "none"
            if alert.bySessionBtn.isSelected == true
            {
                selected = "session"
            }
            else if alert.monthly8btn.isSelected == true
            {
                selected = "8_session"
            }
            else if alert.monthly12btn.isSelected == true
            {
                selected = "12_session"
            }
            else
            {
                return
            }
            addCourseOnServer(type: selected)
            
        }
    }
    
    func addCourseOnServer(type: String)
    {
        let url = URL(string: addToMyCoursesUrl)
        
        let parameters = ["User_ID": UserDefaults.standard.string(forKey: userID)! , "Course_ID": course.id , "type": type]
        
        self.removeSubview()
        self.showLoading()
        Alamofire.request(url!, method: .post, parameters: parameters).responseJSON { (response) in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String , AnyObject>
            {
                if let serverResponse = dict["response"] as? String
                {
                    if serverResponse == "Error"
                    {
                        let alert = UIAlertController(title: "Error", message: "error saveing on server, please try again", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        self.showSuccsessAlert()
                    }
                }
            }
            self.hideLoading()
        }
    }
    
    func removeSubview()
    {
        print("Start remove sibview")
        if let viewWithTag = self.navigationController?.view.viewWithTag(200) {
            viewWithTag.removeFromSuperview()
            self.tableView.isScrollEnabled = true
            viewWithTag.isUserInteractionEnabled = true
            if let back = self.navigationController?.view.viewWithTag(500)
            {
                back.removeFromSuperview()
            }
        }else{
            print("No!")
        }
    }

    func showSuccsessAlert()
    {
        if let alert = Bundle.main.loadNibNamed("CustomAlert", owner: self, options: nil)?.last as? CustomAlertView
        {
            let blackView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            self.navigationController?.view.addSubview(blackView)
            blackView.tag = 500
            blackView.backgroundColor = UIColor.black
            blackView.alpha = 0.400000005960464
            blackView.translatesAutoresizingMaskIntoConstraints = false
            
            
            let leadingConstraint = NSLayoutConstraint(item: blackView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
            let trailingConstraint = NSLayoutConstraint(item: blackView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            let topConstraint = NSLayoutConstraint(item: blackView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: blackView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            self.navigationController?.view.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
            
            self.navigationController?.view.addSubview(alert)
            alert.tag = 200
            alert.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: (UIScreen.main.bounds.size.height / 2))
            alert.alertHeightConstraint.constant = 280
            alert.titleLabel.text = "Hurray!!"
            alert.bodyLabel.text = "You are successfully enrolled\nYou have to visit FPF as soon as possible\nYour request will be granted once you pay the fees"
        
            
            alert.goToNextPageBtn.addTarget(self, action: #selector(self.goBackToFPFCourses), for: UIControlEvents.touchUpInside)
            self.navigationController?.view.bringSubview(toFront: alert)
            alert.isUserInteractionEnabled = true
            self.delegate?.reloadTable()
        }
    }
    
    func goBackToFPFCourses()
    {
        if let back = self.navigationController?.view.viewWithTag(500)
        {
            back.removeFromSuperview()
        }
        if let alert = self.navigationController?.view.viewWithTag(200)
        {
            alert.removeFromSuperview()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - progress hud
    func showLoading()
    {
        //        self.view.alpha = 0.5
        //    self.view.backgroundColor = UIColor.blackColor()
        self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDModeIndeterminate
    }
    
    func hideLoading()
    {
        //        self.view.alpha = 1.0
        self.hud.hide(true)
    }
    
}

    // MARK: - Table view data source
extension CourseDetails
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EnrollTableViewCell", for: indexPath) as? EnrollTableViewCell
            {
                cell.configureCell(course: course)
                cell.enrollBtn.tag = 100
                cell.enrollBtn.addTarget(self, action: #selector(enrollBtnPressed), for: UIControlEvents.touchUpInside)
                
                return cell
            }
        }
        else if indexPath.section == 1
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableTableViewCell", for: indexPath) as? TimeTableTableViewCell
            {
                cell.configureCell(course: course)
                
                return cell
            }
        }
        else if indexPath.section == 2
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTableViewCell", for: indexPath) as? PriceTableViewCell
            {
                cell.configureCell(course: course)
                
                return cell
            }
        }
        return UITableViewCell()
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 367
        }
        else if indexPath.section == 1
        {
            return 164
        }
        else if indexPath.section == 2
        {
            var rowHeight = 56
            if course.pricePerSession != "none"
            {
                rowHeight += 60
            }
            if course.pricePerMonth8Sessions != "none"
            {
                rowHeight += 65
            }
            if course.pricePerMonth12Sessions != "none"
            {
                rowHeight += 65
            }
            return CGFloat(rowHeight)
        }
        else
        {
            return 0
        }
    }
}


protocol reloadMan {
    func reloadTable()
}
