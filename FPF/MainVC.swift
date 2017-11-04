//
//  MainVC.swift
//  FPF
//
//  Created by Bassyouni on 10/6/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: ParentViewController {

    //MARK: - iboutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - variables
    var coursesArray = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        showLoading()
        grabDataFromApi {
            self.tableView.reloadData()
            self.hideLoading()
        }
    }
    
    // MARK: - webservice call to get data
    func grabDataFromApi(completed:@escaping DownloadCompleted)
    {
        let url = URL(string: showMyCoursesUrl)
        
        let parameters = ["User_ID": UserDefaults.standard.string(forKey: userID)!]
        
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


    // MARK: - ibactions
    @IBAction func menuBtnPressed(_ sender: Any)
    {
        self.menuContainerViewController.toggleLeftSideMenuCompletion({})
    }
    
    //MARK: -  segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CourseSessions
        {
            if let course = sender as? Course
            {
                destination.course = course
            }
        }
    }

}

    // MARK: - Table view data source
extension MainVC: UITableViewDelegate , UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if coursesArray.count == 0
        {
            tableView.isHidden = true
        }
        else
        {
            tableView.isHidden = false
        }
        return coursesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MainVCTableViewCell") as? MainVCTableViewCell
        {
            cell.configureCell(course: coursesArray[indexPath.row])
            return cell
        }
        else
        {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "CourseSessions", sender: coursesArray[indexPath.row])
    }
    
}




