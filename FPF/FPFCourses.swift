//
//  FPFCourses.swift
//  FPF
//
//  Created by Bassyouni on 10/2/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit
import Alamofire

class FPFCourses: UITableViewController {
    
    // MARK: - variables
    var hud : MBProgressHUD!
    
    var coursesArray = [Course]()
    
    var isFirstTime = true

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoading()
        grabDataFromApi {
            self.tableView.reloadData()
            self.hideLoading()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isFirstTime
        {
            showLoading()
            coursesArray.removeAll()
            grabDataFromApi {
                self.tableView.reloadData()
                self.hideLoading()
            }
        }
        else
        {
            isFirstTime = false
        }
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coursesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MainVCTableViewCell", for: indexPath) as? MainVCTableViewCell
        {
            //TODO: ask for qoute datasource!
            cell.configureCell(course: coursesArray[indexPath.row])
            
            return cell
        }
        else
        {
            return UITableViewCell()
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CourseDetails", sender: coursesArray[indexPath.row])
    }

    // MARK: - webservice call to get data
    func grabDataFromApi(completed:@escaping DownloadCompleted)
    {
        let url = URL(string: showCoursesToUserUrl)
        
        let parameters = ["User_ID": userID]
        
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
                    for i in 0...2
                    {
                        if let courseDict = dict["\(i)"] as? Dictionary<String, String>
                        {
                            let course = Course()
                            course.populateClassFromApi(dict: courseDict)
                            self.coursesArray.append(course)
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
    
    // MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CourseDetails
        {
            if let course = sender as? Course
            {
                destination.course = course
            }
        }
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
