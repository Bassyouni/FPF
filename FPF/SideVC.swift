//
//  SideViewController.swift
//  Marriage
//
//  Created by ZooZoo on 6/17/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit
import Alamofire

class SideVC: UIViewController , UITableViewDelegate , UITableViewDataSource{

    //MARK: - iboutlets
    @IBOutlet var tableMenu : UITableView!
    @IBOutlet var lblWelcome : UILabel!
    @IBOutlet var lblName : UILabel!
    @IBOutlet var imgProfile : UIImageView!
    
    //MARK: - variables
//    var arrMenuTxt : [String] = ["Home" , "Check List" , "Budget List" , "Guest List" , "Settings"]
//    var arrMenuImg : [String] = ["IconHome" , "IconCheckList" , "IconBudgetList" , "IconGuestList" , "IconSettings"]
    var arrMenuTxt : [String] = ["Activity","Our Courses" ,"Profile", "About Us" , "Rate Us" , "Logout"]
    var indexSelected : Int? = 0
    
    //MARK: - view
    override func viewDidLoad() {
        super.viewDidLoad()

        // set name
        lblWelcome.text = NSLocalizedString("Welcome", comment: "")
        lblName.text = userFname.capitalized + " " + userSName.capitalized
//
        if userImage == ""
        {
            imgProfile.image = UIImage(named: "logo")
        }
        else
        {
            let url = URL(string: userImage)!
            Alamofire.request(url).responseData { response in
                if let data = response.result.value
                {
                    let image = UIImage(data: data)
                    self.imgProfile.image = image
                }
                else
                {
                    print("Error loading image Almofire \(response.error.debugDescription)")
                    self.imgProfile.image = UIImage(named: "logo")
                }
            }
        }

    }

    
    //MARK: - table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrMenuTxt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? SideMenuTableViewCell
        {
            cell.configureCell(title: arrMenuTxt[indexPath.row])
            
            if (self.indexSelected == indexPath.row)
            {
                UIView.animate(withDuration: 0.5, animations: {
                    cell.viewMenu.backgroundColor = customBlueColor
                })
            }
            else
            {
                UIView.animate(withDuration: 0.5, animations: {
                    cell.viewMenu.backgroundColor = UIColor.white
                })
            }
            return cell
        }
        else
        {
            return UITableViewCell()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexSelected = nil
        UIView.animate(withDuration: 0, animations: {
            self.tableMenu.reloadData()
        }, completion: {_ in
            self.indexSelected = indexPath.row
            self.tableMenu.reloadData()
        })
        
        if indexPath.row == 0
        {
            let homeNav = self.storyboard?.instantiateViewController(withIdentifier: "MainVC")
            menuContainerViewController.centerViewController = homeNav
        }
        if indexPath.row == 1
        {
            let homeNav = self.storyboard?.instantiateViewController(withIdentifier: "FPFCourses")
            menuContainerViewController.centerViewController = homeNav
        }
        else if indexPath.row == 2
        {
            let homeNav = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC")
            menuContainerViewController.centerViewController = homeNav
            
        }
        else if indexPath.row == 3
        {
            let homeNav = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsVC")
            menuContainerViewController.centerViewController = homeNav
        }
        else if indexPath.row == 4
        {
            
        }
        
        self.menuContainerViewController.toggleLeftSideMenuCompletion({})
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
