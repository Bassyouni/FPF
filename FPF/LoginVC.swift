//
//  LoginVC.swift
//  FPF
//
//  Created by Bassyouni on 9/26/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

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
                self.mobileNumberBottomBorder.backgroundColor = UIColor(red: 11/255 , green: 69/255, blue: 156/255, alpha: 1)
                self.mobileBorderHeight.constant = 2
            })
            self.passwordBottomBorder.backgroundColor = UIColor.darkGray
        }
        else
        {
            UIView.animate(withDuration: 0.3, animations: {
               self.passwordBottomBorder.backgroundColor = UIColor(red: 11/255 , green: 69/255, blue: 156/255, alpha: 1)
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
    }
    

    @IBAction func signUpBtnPressed(_ sender: Any) {
    }
    
    @IBAction func continueAsGuestBtnPressed(_ sender: Any) {
    }
    
}

