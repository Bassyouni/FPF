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
import IHKeyboardAvoiding

class LoginVC: ParentViewController, segueToSignUpVCDelegate {

    //MARK: - iboutlets
    @IBOutlet weak var loginBtn: LoginButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var mobileNumberTxtField: JVFloatLabeledTextField!
    @IBOutlet weak var passwordTxtField: JVFloatLabeledTextField!
    
    @IBOutlet weak var blueTopViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var mobileBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var passwordBottomBorder: UIView!
    @IBOutlet weak var mobileNumberBottomBorder: UIView!
    
    @IBOutlet weak var loginView: LoginView!
    
    //MARK: - viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Constant: \(self.view.frame.size.height)")
        
        if self.view.frame.size.height < 667
        {
            blueTopViewHeightConstraint.constant = 260
        }
        else
        {
            blueTopViewHeightConstraint.constant = 295
        }
        
        mobileNumberTxtField.tag = 1
        passwordTxtField.tag = 2
        mobileNumberTxtField.delegate = self
        passwordTxtField.delegate = self
        KeyboardAvoiding.avoidingView = loginView
        
    }
    
    
    //MARK: - ibactions
    @IBAction func LoginBtnPressed(_ sender: Any) {
        
        mobileNumberBottomBorder.backgroundColor = UIColor.darkGray
        passwordBottomBorder.backgroundColor = UIColor.darkGray
        mobileBorderHeight.constant = 1
        passwordBorderHeight.constant = 1
        
        if mobileNumberTxtField.text == "" || passwordTxtField.text == ""
        {
            let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Please Fill Both Mobile and Password", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            mobileNumberBottomBorder.backgroundColor = UIColor.red
            passwordBottomBorder.backgroundColor = UIColor.red
            mobileBorderHeight.constant = 2
            passwordBorderHeight.constant = 2
            
        }
        else if !validateMobile(value: mobileNumberTxtField.text!)
        {
            let alert = UIAlertController(title: NSLocalizedString("Mobile Format Error", comment: ""), message: NSLocalizedString("Mobile Number should be 11 digits", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            mobileNumberBottomBorder.backgroundColor = UIColor.red
            mobileBorderHeight.constant = 2
        }
        else if !validatePassword(value: passwordTxtField.text!)
        {
            let alert = UIAlertController(title: NSLocalizedString("Password Format Error", comment: ""), message: NSLocalizedString("Password should be at least 8 characters", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            passwordBottomBorder.backgroundColor = UIColor.red
            passwordBorderHeight.constant = 2
        }
        else
        {
            self.showLoading()
            loginBtn.isEnabled = false
            let parameters = ["Mobile" : mobileNumberTxtField.text! , "Password" : passwordTxtField.text!]
            
            let url = URL(string: signInUrl)
            
            Alamofire.request(url!, method: .post, parameters: parameters).responseJSON { (response) in
                if let dic =  response.result.value as? Dictionary<String ,AnyObject>
                {
                    let  response = dic["response"] as! String
                    
                    if  response == "Error"
                    {
                        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Either Mobile or Password is incorrect", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        if let age = dic["Age"] as? Int
                        {
//                            userAge = age
                            UserDefaults.standard.set(age, forKey: userAge)
                        }
                        if let id = dic["ID"] as? String
                        {
//                            userID = id
                            UserDefaults.standard.set(id, forKey: userID)
                        }
                        if let fName = dic["FName"] as? String
                        {
//                            userFname = fName
                            UserDefaults.standard.set(fName, forKey: userFname)
                        }
                        if let sName = dic["SName"] as? String
                        {
//                            userSName = sName
                            UserDefaults.standard.set(sName, forKey: userSName)
                        }
                        if let image = dic["Image"] as? String
                        {
//                            userImage = image
                            UserDefaults.standard.set(image, forKey: userImage)
                        }
                        if let gender = dic["gender"] as? String
                        {
//                            userGender = gender
                            UserDefaults.standard.set(gender, forKey: userGender)
                        }
                        if let pMobile = dic["P_Mobile"] as? String
                        {
//                            userPMobile = pMobile
                            UserDefaults.standard.set(pMobile, forKey: userPMobile)
                        }
                        
//                        userMobile = parameters["Mobile"]!
                        UserDefaults.standard.set(parameters["Mobile"]!, forKey: userMobile)
                        
                        self.goToMainVC()
                    }
                }
                else
                {
                    print(response.result, response.result.error.debugDescription)
                }
            
                self.loginBtn.isEnabled = true
                self.hideLoading()
            }
        }
        
        
        
        
    }

    @IBAction func continueAsGuestBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "GuestVC", sender: nil)
    }
    
    @IBAction func signUpNowBtnPressd(_ sender: Any) {
        goToSignUpVC()
    }
    
    
    //MARK: - segue
    private func goToMainVC()
    {
        view.endEditing(true)
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let mainVCNav = storyboard?.instantiateViewController(withIdentifier: "MainVC")
        let sideMenuVC = storyboard?.instantiateViewController(withIdentifier: "SideVC")
        
        let containerVC = MFSideMenuContainerViewController.container(withCenter: mainVCNav , leftMenuViewController: sideMenuVC, rightMenuViewController: nil)

        delegate?.window?.rootViewController = containerVC
    }
    
    func goToSignUpVC() {
        performSegue(withIdentifier: "SignUpVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? UINavigationController
        {
            let guest = dest.viewControllers[0] as? GuestVC
            guest?.delegateSegueToSignUpVC = self
        }
    }
    
    //MARK: - validation
    private func validateMobile(value: String) -> Bool {
        if value.characters.count < 11
        {
            return false
        }
        else if value.characters.count > 11
        {
            return false
        }
        
        return true
    }
    
    private func validatePassword(value: String) -> Bool {
        if value.characters.count >= 8
        {
            return true
        }
        return false
        
    }
    
    //MARK: - keyboardDissmissOnTouch
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

//MARK: - textField delegte methods
extension LoginVC: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1
        {
            let currentCharacterCount = textField.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= 11
        }
        return true
        
    }
}

