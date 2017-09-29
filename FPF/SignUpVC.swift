//
//  SignUpVC.swift
//  FPF
//
//  Created by Bassyouni on 9/29/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit
import DLRadioButton
import JVFloatLabeledTextField

class SignUpVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK: - iboutles
    @IBOutlet weak var maleRadioBtn: DLRadioButton!
    @IBOutlet weak var femaleRadiobtn: DLRadioButton!
    
    @IBOutlet weak var avatarImage: RoundImage!
    @IBOutlet weak var firstNameTxtField: JVFloatLabeledTextField!
    @IBOutlet weak var lastNameTxtField: JVFloatLabeledTextField!
    @IBOutlet weak var mobileNumberTxtField: JVFloatLabeledTextField!
    @IBOutlet weak var parentsMobileNumberTxtField: JVFloatLabeledTextField!
    @IBOutlet weak var passwordTxtField: JVFloatLabeledTextField!
    @IBOutlet weak var confirmPasswordTxtField: JVFloatLabeledTextField!
    
    @IBOutlet weak var firstNameBottomBorderView: UIView!
    @IBOutlet weak var lastNameBottomBorderView: UIView!
    @IBOutlet weak var mobileNumberBottomBorderView: UIView!
    @IBOutlet weak var parentsMobileNumberBottomBorderView: UIView!
    @IBOutlet weak var passwordBottomBorderView: UIView!
    @IBOutlet weak var confirmPasswordBottomBorderView: UIView!
    
    @IBOutlet weak var firstNameViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lastNameViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mobileNumberViewHeight: NSLayoutConstraint!
    @IBOutlet weak var parentsMobileNumberViewHeight: NSLayoutConstraint!
    @IBOutlet weak var passwordViewHeight: NSLayoutConstraint!
    @IBOutlet weak var confirmPasswordViewHeight: NSLayoutConstraint!

    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MARK: - variables
    var imagePicker: UIImagePickerController!
    
    //MARK: - viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //image picker init
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        maleRadioBtn.isSelected = true
        firstNameTxtField.delegate = self
        lastNameTxtField.delegate = self
        mobileNumberTxtField.delegate = self
        parentsMobileNumberTxtField.delegate = self
        passwordTxtField.delegate = self
        confirmPasswordTxtField.delegate = self
        
        //firstNameTxtField.enablesReturnKeyAutomatically = false
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -16, to: Date())
    }
    
    //MARK: - ibactions
    @IBAction func femaleRadioBtnPressed(_ sender: Any) {
        if avatarImage.image == UIImage(named: "man")
        {
            self.avatarImage.image = UIImage(named: "girl")
        }
        
    }
    
    @IBAction func maleRadioBtnPressed(_ sender: Any) {
        if avatarImage.image == UIImage(named: "girl")
        {
            self.avatarImage.image = UIImage(named: "man")
        }
    }
    
    @IBAction func addProfilePictureBtnPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func DoneBtnPressed(_ sender: Any) {
    }
    
    @IBAction func returnBtnPressed(_ sender: Any) {
    }
    
    //MARK: - textField delegte methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1
        {
            UIView.animate(withDuration: 0.3, animations: { 
                self.firstNameBottomBorderView.backgroundColor = customBlueColor
                self.firstNameViewHeight.constant = 2
            })
        }
        else if textField.tag == 2
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.lastNameBottomBorderView.backgroundColor = customBlueColor
                self.lastNameViewHeight.constant = 2
            })
        }
        else if textField.tag == 3
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.mobileNumberBottomBorderView.backgroundColor = customBlueColor
                self.mobileNumberViewHeight.constant = 2
            })
        }
        else if textField.tag == 4
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.parentsMobileNumberBottomBorderView.backgroundColor = customBlueColor
                self.parentsMobileNumberViewHeight.constant = 2
            })
        }
        else if textField.tag == 5
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.passwordBottomBorderView.backgroundColor = customBlueColor
                self.passwordViewHeight.constant = 2
            })
        }
        else if textField.tag == 6
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.confirmPasswordBottomBorderView.backgroundColor = customBlueColor
                self.confirmPasswordViewHeight.constant = 2
            })
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField.tag == 1
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.firstNameBottomBorderView.backgroundColor = UIColor.darkGray
                self.firstNameViewHeight.constant = 1
            })
        }
        else if textField.tag == 2
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.lastNameBottomBorderView.backgroundColor = UIColor.darkGray
                self.lastNameViewHeight.constant = 1
            })
        }
        else if textField.tag == 3
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.mobileNumberBottomBorderView.backgroundColor = UIColor.darkGray
                self.mobileNumberViewHeight.constant = 1
            })
        }
        else if textField.tag == 4
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.parentsMobileNumberBottomBorderView.backgroundColor = UIColor.darkGray
                self.parentsMobileNumberViewHeight.constant = 1
            })
        }
        else if textField.tag == 5
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.passwordBottomBorderView.backgroundColor = UIColor.darkGray
                self.passwordViewHeight.constant = 1
            })
        }
        else if textField.tag == 6
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.confirmPasswordBottomBorderView.backgroundColor = UIColor.darkGray
                self.confirmPasswordViewHeight.constant = 1
            })
        }
    }
    
    //MARK: - PickerView Delegete methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            avatarImage.image = image
            //toDo: upload on the server
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    


}
