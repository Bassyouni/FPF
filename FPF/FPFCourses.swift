//
//  FPFCourses.swift
//  FPF
//
//  Created by Bassyouni on 10/2/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit
import Alamofire

class FPFCourses: ParentViewController ,reloadMan {
    
    //MARK: - iboutles
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - variables
    var coursesArray = [Course]()
    var isFirstTime = true
    
    deinit {
        print("fpfCourses deinit")
    }

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        
       let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "menuBtn"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(self.menuBtnPressed(_:)), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30) //CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        
        showLoading()
        

        grabDataFromApi {
            self.tableView.reloadData()
            self.hideLoading()
        }
    
        
    }

    
    func reloadTable()
    {
        showLoading()
        coursesArray.removeAll()
        grabDataFromApi {
            
            if self.coursesArray.count == 0
            {
                self.tableView.isHidden = true
            }
            else
            {
                self.tableView.reloadData()
            }
            self.hideLoading()
        }

    }
    
    //MARK: - ibactions
    @IBAction func menuBtnPressed(_ sender: Any)
    {
        self.menuContainerViewController.toggleLeftSideMenuCompletion({})
    }

    // MARK: - webservice call to get data
    func grabDataFromApi(completed:@escaping DownloadCompleted)
    {
        let url: URL!
        
        let parameters: Dictionary<String, String>!
        
        if UserDefaults.standard.object(forKey: userID) == nil
        {
            parameters = [:]
            url = URL(string: showCoursesUrl)
        }
        else
        {
            parameters = ["User_ID": UserDefaults.standard.string(forKey: userID)!]
            url = URL(string: showCoursesToUserUrl)
        }
        
        
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
                            print("xxx: ",courseDict)
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
                destination.delegate = self
            }
        }
        
    }



}

    // MARK: - Table view data source
extension FPFCourses: UITableViewDelegate , UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coursesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MainVCTableViewCell", for: indexPath) as? MainVCTableViewCell
        {

            cell.configureCell(course: coursesArray[indexPath.row])
            
            return cell
        }
        else
        {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CourseDetails", sender: coursesArray[indexPath.row])
        
    }

}

