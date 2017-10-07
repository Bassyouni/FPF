//
//  LoginVC.swift
//  FPF
//
//  Created by Bassyouni on 9/26/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import Alamofire


class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var mobileNumberTxtField: JVFloatLabeledTextField!
    @IBOutlet weak var passwordTxtField: JVFloatLabeledTextField!
    
    @IBOutlet weak var passwordBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var mobileBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var passwordBottomBorder: UIView!
    @IBOutlet weak var mobileNumberBottomBorder: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobileNumberTxtField.tag = 1
        passwordTxtField.tag = 2
        mobileNumberTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Hiiiiiii: did begin")
        if textField.tag == 1
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.mobileNumberBottomBorder.backgroundColor = customBlueColor
                self.mobileBorderHeight.constant = 2
            })
            self.passwordBottomBorder.backgroundColor = UIColor.darkGray
        }
        else
        {
            UIView.animate(withDuration: 0.3, animations: {
               self.passwordBottomBorder.backgroundColor = customBlueColor
                self.passwordBorderHeight.constant = 2
            })
            
            self.mobileNumberBottomBorder.backgroundColor = UIColor.darkGray
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 1
        {
            self.mobileNumberBottomBorder.backgroundColor = UIColor.darkGray
            self.mobileBorderHeight.constant = 1
        }
        else
        {
            self.passwordBottomBorder.backgroundColor = UIColor.darkGray
            self.passwordBorderHeight.constant = 1
        }
    }

    @IBAction func LoginBtnPressed(_ sender: Any) {
        
//        let delegate = UIApplication.shared.delegate as? AppDelegate
//        let mainVCNav = storyboard?.instantiateViewController(withIdentifier: "MainVC")
//        let sideMenuVC = storyboard?.instantiateViewController(withIdentifier: "SideVC")
//    
//        let containerVC = MFSideMenuContainerViewController.container(withCenter: mainVCNav , leftMenuViewController: sideMenuVC, rightMenuViewController: nil)
//        
//        delegate?.window?.rootViewController = containerVC
        
        
        // this is sign up
        let parameters = ["FName": "Omar", "SName": "Ashraf" , "Mobile": "01116895595" , "PMobile": "01000000000" , "Password": "12345678" , "Date": "13/2/1996" , "Gender": "Male" , "Image": "www.whatsappstatus77.in/wp-content/uploads/2015/07/awesome-boys-profile-photos-pics-for-facebook-wall-whatsapp-dp.jpg"]
        
        let url = URL(string: "http://fpftest.000webhostapp.com/FPF/Signup.php")
        
        Alamofire.request(url!, method: .post, parameters: parameters).responseJSON { (response) in
            if let dic =  response.result.value as? Dictionary<String ,AnyObject>
            {
                print("xxxxx: \(String(describing: dic["response"]))")
                print(dic)
            }
            else
            {
                print(response.result, response.result.error.debugDescription)
            }
        }

        
    }
    

    @IBAction func signUpBtnPressed(_ sender: Any) {
    }
    
    @IBAction func continueAsGuestBtnPressed(_ sender: Any) {
    }
    
}

