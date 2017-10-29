//
//  ProfileVC.swift
//  FPF
//
//  Created by Bassyouni on 10/12/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import Alamofire

class ProfileVC: ParentViewController {

    //MARK: - iboutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLAbel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var nameTextField: JVFloatLabeledTextField!
    @IBOutlet weak var mobileTextField: JVFloatLabeledTextField!
    @IBOutlet weak var parentMobileTextField: JVFloatLabeledTextField!
    
    @IBOutlet weak var nameBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var mobileBorderConstant: NSLayoutConstraint!
    @IBOutlet weak var parentMobileBorderHeight: NSLayoutConstraint!
    
    @IBOutlet weak var nameBottomBorder: UIView!
    @IBOutlet weak var mobileBottomBorder: UIView!
    @IBOutlet weak var parentMobileBottomBorder: UIView!
    
    @IBOutlet weak var changePasswordBtn: UIButton!
    @IBOutlet weak var profileImage: RoundImage!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        mobileTextField.delegate = self
        parentMobileTextField.delegate = self
        
        disableInteraction()
        
        loadDataIntoFields()
        

    }
    
    //MARK: - ibactions
    @IBAction func changePasswordBtnPressed(_ sender: Any) {
        if let alert = Bundle.main.loadNibNamed("PasswordPopUp", owner: self, options: nil)?.last as? EditPasswordPopUpView
        {
            self.view.addSubview(alert)
            alert.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: (UIScreen.main.bounds.size.height / 2)-20)
            
            self.view.bringSubview(toFront: alert)
            alert.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        self.menuContainerViewController.toggleLeftSideMenuCompletion({})
    }
    
    @IBAction func toggleEnableEdit(sender: UIButton)
    {
        if sender.titleLabel?.text == "Edit"
        {
            enableInteraction()
            sender.setTitle("Done", for: UIControlState.normal)
        }
        else if nameTextField.text == "\(String(describing: UserDefaults.standard.string(forKey: userFname)?.capitalized)) \(String(describing: UserDefaults.standard.string(forKey: userSName)?.capitalized))" && mobileTextField.text == UserDefaults.standard.string(forKey: userMobile) && parentMobileTextField.text == UserDefaults.standard.string(forKey: userPMobile)
        {
            disableInteraction()
            sender.setTitle("Edit", for: UIControlState.normal)
        }
        else
        {
            
            let validated = isAllFieldsAreFilledAndValidated()
            if validated
            {
                showLoading()
                updateOnServer()
                disableInteraction()
                sender.setTitle("Edit", for: UIControlState.normal)
            }
            
        
        }
    }
    
    //MARK: - init stuff
    func loadDataIntoFields()
    {
        nameLabel.text =  "\(String(describing: UserDefaults.standard.string(forKey: userFname)?.capitalized)) \(String(describing: UserDefaults.standard.string(forKey: userSName)?.capitalized))"
        mobileTextField.text = UserDefaults.standard.string(forKey: userMobile)
        parentMobileTextField.text = UserDefaults.standard.string(forKey: userPMobile)
        idLAbel.text = UserDefaults.standard.string(forKey: userID)
        ageLabel.text = "\(String(describing: UserDefaults.standard.object(forKey: userAge)))"
        let url = URL(string: UserDefaults.standard.string(forKey: userImage)!)!
        Alamofire.request(url).responseData { response in
            if let data = response.result.value
            {
                let image = UIImage(data: data)
                self.profileImage.image = image
            }
            else
            {
                print("Error loading image Almofire")
            }
        }
    }
    
    func disableInteraction()
    {
        nameTextField.isUserInteractionEnabled = false
        mobileTextField.isUserInteractionEnabled = false
        parentMobileTextField.isUserInteractionEnabled = false
        nameTextField.isHidden = true
        nameBottomBorder.isHidden = true
        mobileBottomBorder.isHidden = true
        parentMobileBottomBorder.isHidden = true
        nameLabel.isHidden = false
    }
    
    func enableInteraction()
    {
        nameTextField.isUserInteractionEnabled = true
        mobileTextField.isUserInteractionEnabled = true
        parentMobileTextField.isUserInteractionEnabled = true
        nameTextField.isHidden = false
        nameBottomBorder.isHidden = false
        mobileBottomBorder.isHidden = false
        parentMobileBottomBorder.isHidden = false
        nameLabel.isHidden = true
        
        nameTextField.text = nameLabel.text
    }
    
    //MARK: - load into server
    func updateOnServer()
    {
        if nameTextField.text != "\(userFname.capitalized) \(userSName.capitalized)" || mobileTextField.text != userMobile || parentMobileTextField.text != userPMobile
        {
            let paramters = ["ID": UserDefaults.standard.string(forKey: userID)! , "Name" : nameTextField.text! , "Mobile": mobileTextField.text! , "P_Mobile": parentMobileTextField.text!]
            
            let url = URL(string: editUserInfoUrl)!
            
            print(nameTextField.text!)
            
            print(editUserInfoUrl)
            Alamofire.request(url, method: .post, parameters: paramters).responseJSON(completionHandler: { (response) in
                if let dic = response.result.value as? Dictionary<String,AnyObject>
                {
                    let result = dic["response"] as? String
                    
                    if result == "Error"
                    {
                        print("Error on server ! edit user info")
                        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("An error occurred please try again", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        let alert = UIAlertController(title: NSLocalizedString("Success", comment: ""), message: NSLocalizedString("Your information has been updated successfully", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        


                        let fullNameArr = paramters["Name"]!.components(separatedBy: " ")
                        let fName    = fullNameArr[0]
                        let sName = fullNameArr[1]
                        
//                        userFname = fName
//                        userSName = sName
//                        userMobile = paramters["Mobile"]!
//                        userPMobile = paramters["P_Mobile"]!
                        UserDefaults.standard.set(fName, forKey: userFname)
                        UserDefaults.standard.set(sName, forKey: userSName)
                        UserDefaults.standard.set(paramters["Mobile"]!, forKey: userMobile)
                        UserDefaults.standard.set(paramters["P_Mobile"]!, forKey: userPMobile)
                    }
                }
                else
                {
                    print("Error in edit user info")
                    print(response.error.debugDescription)
                    print("Error on server ! edit user info")
                    let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("An error occurred please try again", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    self.nameLabel.text =  "\(String(describing: UserDefaults.standard.string(forKey: userFname)?.capitalized)) \(String(describing: UserDefaults.standard.string(forKey: userSName)?.capitalized))"
                    self.mobileTextField.text = UserDefaults.standard.string(forKey: userMobile)
                    self.parentMobileTextField.text = UserDefaults.standard.string(forKey: userPMobile)

                }
             self.hideLoading()
            })
        }
        else
        {
            return
        }
    }
    
    //MARK: - input validation
    private func isAllFieldsAreFilledAndValidated() -> Bool
    {
        if nameTextField.text == "" {
            self.nameBottomBorder.backgroundColor = UIColor.red
            self.nameBorderHeight.constant = 2
            return false
        }
        else if mobileTextField.text == ""
        {
            self.mobileBottomBorder.backgroundColor = UIColor.red
            self.mobileBorderConstant.constant = 2
            return false
        }
        else if !validateMobile(value: mobileTextField.text!)
        {
            let alert = UIAlertController(title: NSLocalizedString("Mobile Format Error", comment: ""), message: NSLocalizedString("Mobile Number should be 11 digits", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.mobileBottomBorder.backgroundColor = UIColor.red
            self.mobileBorderConstant.constant = 2
            return false
        }
        else if parentMobileTextField.text == ""
        {
            self.parentMobileBottomBorder.backgroundColor = UIColor.red
            self.parentMobileBorderHeight.constant = 2
            return false
        }
        else if !validateMobile(value: parentMobileTextField.text!)
        {
            let alert = UIAlertController(title: NSLocalizedString("Mobile Format Error", comment: ""), message: NSLocalizedString("Mobile Number should be 11 digits", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.parentMobileBottomBorder.backgroundColor = UIColor.red
            self.parentMobileBorderHeight.constant = 2
            return false
        }
        
        return true
    }
    
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

}


//MARK: -
extension ProfileVC: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.nameBottomBorder.backgroundColor = UIColor.white
                self.nameBorderHeight.constant = 2
            })
        }
        else if textField.tag == 2
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.mobileBottomBorder.backgroundColor = customBlueColor
                self.mobileBorderConstant.constant = 2
            })
        }
        else if textField.tag == 3
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.parentMobileBottomBorder.backgroundColor = customBlueColor
                self.parentMobileBorderHeight.constant = 2
            })
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.nameBorderHeight.constant = 1
            })
        }
        else if textField.tag == 2
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.mobileBottomBorder.backgroundColor = UIColor.darkGray
                self.mobileBorderConstant.constant = 1
            })
        }
        else if textField.tag == 3
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.parentMobileBottomBorder.backgroundColor = UIColor.darkGray
                self.parentMobileBorderHeight.constant = 1
            })
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 2 || textField.tag == 3
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
    
    //MARK: - keyboardDissmissOnTouch
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
