//
//  CourseSessions.swift
//  FPF
//
//  Created by Bassyouni on 10/20/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit
import Alamofire

class CourseSessions: ParentViewController  {

    // MARK: - iboutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - variables
    var course:Course!
    var state:String!
    var type:String!
    var seassionsArray = [String]()
    var invitationNameArray = [String]()
    var invitationNumberArray = [String]()
    var isFirstTime = true
    
    // MARK: - viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        state = "none"
        type = "session"
        
        self.title = course.name
        if let topItem = self.navigationController?.navigationBar.topItem
        {
            topItem.backBarButtonItem = UIBarButtonItem(title: "" , style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }

        showLoading()
        grabDataFromApi {
            if self.isFirstTime
            {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.isFirstTime = false
            }

            self.tableView.reloadData()
            self.hideLoading()
        }
        //remove alert when changing password with double tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.removeAlert))
        tap.numberOfTapsRequired = 2
        self.navigationController?.view.addGestureRecognizer(tap)
       
    }
    
    // MARK: - webservice call to get data
    func grabDataFromApi(completed:@escaping DownloadCompleted)
    {
        let url = URL(string: showCourseTableUrl)
        
        let parameters = ["User_ID": UserDefaults.standard.string(forKey: userID)!,"Course_ID": course.id]
        
        Alamofire.request(url!, method: .post, parameters: parameters).responseJSON { (response) in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String , AnyObject>
            {
                
                let result = dict["response"] as? String
                
                if result == "Error"
                {
                    print("response error in courses to user !")
                }
                else
                {
                    if let state = dict["state"] as? String
                    {
                        self.state = state
                    }
                    if let type = dict["type"] as? String
                    {
                        self.type = type
                    }
                    for i in 1...12
                    {
                        let sessionName = "session\(i)"
                        if let session = dict[sessionName] as? String
                        {
                            self.seassionsArray.append(session)
                        }
                    }
                    for i in 1...3
                    {
                        let inviteName = "Invitation\(i)_name"
                        let inviteNum = "Invitation\(i)_number"
                        
                        if let invitationName = dict[inviteName] as? String
                        {
                            self.invitationNameArray.append(invitationName)
                        }
                        if let invitationNumber = dict[inviteNum] as? String
                        {
                            self.invitationNumberArray.append(invitationNumber)
                        }
                    }
                }
                
            }
            else
            {
                print("error in courses \(response.error.debugDescription)")
            }
            completed()
        }
        
        
    }

    func showAlertForInvite(_ sender: UIButton)
    {
        if sender.tag == 200
        {
            if let alert = Bundle.main.loadNibNamed("PasswordPopUp", owner: self, options: nil)?.last as? EditPasswordPopUpView
            {
//                self.alertBackView.isHidden = false
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
                alert.tag = 100
                alert.title.text = "Invitation"
                alert.passwordTextField.placeholder = "Friend's Name"
                alert.confirmPasswordTextField.placeholder = "Friend's Mobile Number"
                alert.confirmPasswordTextField.keyboardType = .numberPad
                alert.passwordTextField.isSecureTextEntry = false
                alert.confirmPasswordTextField.isSecureTextEntry = false

                alert.doneBtn.removeTarget(EditPasswordPopUpView.self, action: #selector(EditPasswordPopUpView.DoneBtnPressed(_:)) , for: UIControlEvents.touchUpInside)
                self.navigationController?.view.bringSubview(toFront: alert)
                alert.isUserInteractionEnabled = true
            }
        }
    }
    
    
    @objc private func removeAlert()
    {
        if let alert = self.navigationController?.view.viewWithTag(100)
        {
            alert.removeFromSuperview()
            if let back = self.navigationController?.view.viewWithTag(500)
            {
                back.removeFromSuperview()
            }
        }
    }
    
    //MARK: - keyboardDissmissOnTouch
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
}

// MARK: - table data source
extension CourseSessions: UITableViewDelegate , UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 && type == "session"
        {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "upComingSessionTableViewCell", for: indexPath) as? upComingSessionTableViewCell
            {
                return cell
            }
        }
        else if indexPath.section == 1
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "sessionsTableTableViewCell", for: indexPath) as? sessionsTableTableViewCell
            {
                cell.configureCell(state: state, sessions: seassionsArray, type: type)
                return cell
            }
        }
        else if indexPath.section == 2
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "invitationsTableViewCell", for: indexPath) as? invitationsTableViewCell
            {
                cell.inviteBtn.tag = 200
                cell.inviteBtn.addTarget(self, action: #selector(self.showAlertForInvite(_:)), for: UIControlEvents.touchUpInside)
                return cell
            }
        }
        else if indexPath.section == 3
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTableViewCell", for: indexPath) as? PriceTableViewCell
            {
                cell.configureCell(course: course)
                return cell
            }
        }

        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 125
        }
        else if indexPath.section == 1
        {
            if type == "8_session"
            {
                return (424 - 120)
            }
            return (424 - 40)
        }
        else if indexPath.section == 2
        {
            return 130
        }
        else if indexPath.section == 3
        {
            return 246
        }
        return 0
    }
}





