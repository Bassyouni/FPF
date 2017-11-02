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
                    //TODO: its obvious ,invitation
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
                return cell
            }
        }
        else if indexPath.section == 3
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTableViewCell", for: indexPath) as? PriceTableViewCell
            {
                return cell
            }
        }

        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //TODO: depend on type make it short or long!
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





