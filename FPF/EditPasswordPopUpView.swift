//
//  EditPasswordPopUpView.swift
//  FPF
//
//  Created by Bassyouni on 10/12/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import Alamofire

class EditPasswordPopUpView: UIView {

    @IBOutlet weak var passwordTextField: JVFloatLabeledTextField!
    @IBOutlet weak var confirmPasswordTextField: JVFloatLabeledTextField!

    @IBOutlet weak var passwordBottmBorder: UIView!
    @IBOutlet weak var confirmPasswordBottomBorder: UIView!
    
    @IBOutlet weak var passwordBottomBorderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmPasswordBottomBorderHeigtConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    @IBAction func DoneBtnPressed(_ sender: Any) {
        let validated = isAllFieldsAreFilledAndValidated()
        if validated
        {
            callWebServiceForEditPassword()
        }
    }
    
    func callWebServiceForEditPassword()
    {
        let paramters = ["ID": UserDefaults.standard.string(forKey: userID)! , "Password": passwordTextField.text!]
        
        let url = URL(string: editPasswordUrl)
        
        Alamofire.request(url!, method: .post, parameters: paramters).responseJSON { (response) in
            if let dic =  response.result.value as? Dictionary<String , AnyObject>
            {
                let result = dic["response"] as? String
                
                if result == "Error"
                {
                    let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Make sure the password is valid", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                else
                {
                    let alert = UIAlertController(title: NSLocalizedString("Success", comment: ""), message: NSLocalizedString("password changed successfully", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    self.removeFromSuperview()
                }
            }
            else
            {
                let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Problem in web request", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func isAllFieldsAreFilledAndValidated() -> Bool
    {
        if passwordTextField.text == ""
        {
            self.passwordBottmBorder.backgroundColor = UIColor.red
            self.passwordBottomBorderHeightConstraint.constant = 2
            return false
        }
        else if !validatePassword(value: passwordTextField.text!)
        {
            let alert = UIAlertController(title: NSLocalizedString("Password Format Error", comment: ""), message: NSLocalizedString("Password should be at least 8 characters", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            self.passwordBottmBorder.backgroundColor = UIColor.red
            self.passwordBottomBorderHeightConstraint.constant = 2
            return false
        }
        else if confirmPasswordTextField.text == ""
        {
            self.confirmPasswordBottomBorder.backgroundColor = UIColor.red
            self.confirmPasswordBottomBorderHeigtConstraint.constant = 2
            return false
        }
        else if !isPasswordSame(password: passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!)
        {
            let alert = UIAlertController(title: NSLocalizedString("Passwords Are not Same", comment: ""), message: NSLocalizedString("Confirm password is different than password", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            self.confirmPasswordBottomBorder.backgroundColor = UIColor.red
            self.confirmPasswordBottomBorderHeigtConstraint.constant = 2
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
    
    private func isPasswordSame(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword{
            return true
        }else{
            return false
        }
    }
    
    

}

//MARK: - 
extension EditPasswordPopUpView: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.passwordBottmBorder.backgroundColor = customBlueColor
                self.passwordBottomBorderHeightConstraint.constant = 2
            })
        }
        else if textField.tag == 2
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.confirmPasswordBottomBorder.backgroundColor = customBlueColor
                self.confirmPasswordBottomBorderHeigtConstraint.constant = 2
            })
        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.passwordBottmBorder.backgroundColor = UIColor.darkGray
                self.passwordBottomBorderHeightConstraint.constant = 1
            })
        }
        else if textField.tag == 2
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.confirmPasswordBottomBorder.backgroundColor = UIColor.darkGray
                self.confirmPasswordBottomBorderHeigtConstraint.constant = 1
            })
        }
    }
    
    //MARK: - keyboardDissmissOnTouch
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
