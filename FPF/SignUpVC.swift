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
import Alamofire
import Firebase

class SignUpVC: ParentViewController {
    
    //MARK: - iboutles
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
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
    
    //MARK: - variables
    var imagePicker: UIImagePickerController!
    var imageURL: String?
    
    var delegate: dismissAllBefore?
    
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
        datePicker.maximumDate = Date()
        
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
    
    @IBAction func returnBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Does all the work of the signUp
    ///
    /// - Parameter sender: Any
    @IBAction func DoneBtnPressed(_ sender: Any) {
        bordersBackToNormal()
        view.endEditing(true)
        if !isAllFieldsAreFilledAndValidated()
        {
            return
        }
        
        callWebService()
        
    }
    
    //MARK: - Almofire webrequest
    func callWebService()
    {
        showLoading()
        
        var gender = "Male"
        if femaleRadiobtn.isSelected
        {
            gender = "Female"
        }
        
        datePicker.datePickerMode = UIDatePickerMode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        let parameters = ["FName": firstNameTxtField.text!, "SName": lastNameTxtField.text! , "Mobile": mobileNumberTxtField.text! , "PMobile": parentsMobileNumberTxtField.text! , "Password": passwordTxtField.text! , "Date": selectedDate, "Gender": gender , "Image": imageURL!]
        
        
        let url = URL(string: signUpUrl)
        
        Alamofire.request(url!, method: .post, parameters: parameters).responseJSON { (response) in
            if let dic =  response.result.value as? Dictionary<String ,AnyObject>
            {
                let  response = dic["response"] as! String
                
                if  response == "Error"
                {
                    let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("This mobile number is used before", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    if let ID = dic["ID"] as? String
                    {
//                        userID = ID
                        UserDefaults.standard.set(ID, forKey: userID)
                    }
                    if let age = dic["Age"] as? Int
                    {
//                        userAge = age
                        UserDefaults.standard.set(age, forKey: userAge)
                    }
                    
//                    userFname = parameters["FName"]!
//                    userSName = parameters["SName"]!
//                    userMobile = parameters["Mobile"]!
//                    userImage = parameters["Image"]!
                    UserDefaults.standard.set(parameters["FName"]!, forKey: userFname)
                    UserDefaults.standard.set(parameters["SName"]!, forKey: userSName)
                    UserDefaults.standard.set(parameters["Mobile"]!, forKey: userMobile)
                    UserDefaults.standard.set(parameters["Image"]!, forKey: userImage)
                    UserDefaults.standard.set(gender, forKey: userGender)
                    UserDefaults.standard.set(parameters["PMobile"], forKey: userPMobile)
                    
                    //Showing Alert
                    self.showAlert()
                    self.scrollView.isUserInteractionEnabled = false
                    self.navbarView.isUserInteractionEnabled = false
                    
                }
            }
            
            // end of Almofire closure
            self.hideLoading()
            
        }
    }
    
    //MARK: - segue to mainVC
    @objc private func goToMainVC()
    {
        if self.delegate != nil
        {
            self.delegate?.dissmissAll()
        }
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let mainVCNav = storyboard?.instantiateViewController(withIdentifier: "MainVC")
        let sideMenuVC = storyboard?.instantiateViewController(withIdentifier: "SideVC")
        
        let containerVC = MFSideMenuContainerViewController.container(withCenter: mainVCNav , leftMenuViewController: sideMenuVC, rightMenuViewController: nil)
        
        delegate?.window?.rootViewController = containerVC
    }
    
    //MARK: - keyboardDissmissOnTouch
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - Desgin & validation
    private func bordersBackToNormal()
    {
        self.confirmPasswordBottomBorderView.backgroundColor = UIColor.darkGray
        self.confirmPasswordViewHeight.constant = 1
        self.passwordBottomBorderView.backgroundColor = UIColor.darkGray
        self.passwordViewHeight.constant = 1
        self.parentsMobileNumberBottomBorderView.backgroundColor = UIColor.darkGray
        self.parentsMobileNumberViewHeight.constant = 1
        self.mobileNumberBottomBorderView.backgroundColor = UIColor.darkGray
        self.mobileNumberViewHeight.constant = 1
        self.lastNameBottomBorderView.backgroundColor = UIColor.darkGray
        self.lastNameViewHeight.constant = 1
        self.firstNameBottomBorderView.backgroundColor = UIColor.darkGray
        self.firstNameViewHeight.constant = 1
    }

    private func isAllFieldsAreFilledAndValidated() -> Bool
    {
        if firstNameTxtField.text == "" {
            self.firstNameBottomBorderView.backgroundColor = UIColor.red
            self.firstNameViewHeight.constant = 2
            return false
        }
        else if lastNameTxtField.text == ""
        {
            self.lastNameBottomBorderView.backgroundColor = UIColor.red
            self.lastNameViewHeight.constant = 2
            return false
        }
        else if mobileNumberTxtField.text == ""
        {
            self.mobileNumberBottomBorderView.backgroundColor = UIColor.red
            self.mobileNumberViewHeight.constant = 2
            return false
        }
        else if !validateMobile(value: mobileNumberTxtField.text!)
        {
            let alert = UIAlertController(title: NSLocalizedString("Mobile Format Error", comment: ""), message: NSLocalizedString("Mobile Number should be 11 digits", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.mobileNumberBottomBorderView.backgroundColor = UIColor.red
            self.mobileNumberViewHeight.constant = 2
            return false
        }
        else if parentsMobileNumberTxtField.text == ""
        {
            self.parentsMobileNumberBottomBorderView.backgroundColor = UIColor.red
            self.parentsMobileNumberViewHeight.constant = 2
            return false
        }
        else if !validateMobile(value: parentsMobileNumberTxtField.text!)
        {
            let alert = UIAlertController(title: NSLocalizedString("Mobile Format Error", comment: ""), message: NSLocalizedString("Mobile Number should be 11 digits", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.parentsMobileNumberBottomBorderView.backgroundColor = UIColor.red
            self.parentsMobileNumberViewHeight.constant = 2
            return false
        }
        else if passwordTxtField.text == ""
        {
            self.passwordBottomBorderView.backgroundColor = UIColor.red
            self.passwordViewHeight.constant = 2
            return false
        }
        else if !validatePassword(value: passwordTxtField.text!)
        {
            let alert = UIAlertController(title: NSLocalizedString("Password Format Error", comment: ""), message: NSLocalizedString("Password should be at least 8 characters", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.passwordBottomBorderView.backgroundColor = UIColor.red
            self.passwordViewHeight.constant = 2
            return false
        }
        else if confirmPasswordTxtField.text == ""
        {
            self.confirmPasswordBottomBorderView.backgroundColor = UIColor.red
            self.confirmPasswordViewHeight.constant = 2
            return false
        }
        else if !isPasswordSame(password: passwordTxtField.text!, confirmPassword: confirmPasswordTxtField.text!)
        {
            let alert = UIAlertController(title: NSLocalizedString("Passwords Are not Same", comment: ""), message: NSLocalizedString("Confirm password is different than password", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.confirmPasswordBottomBorderView.backgroundColor = UIColor.red
            self.confirmPasswordViewHeight.constant = 2
            return false
        }
        else if imageURL == nil
        {
            let alert = UIAlertController(title: NSLocalizedString("Please Choose an Image", comment: ""), message: NSLocalizedString("This will be used for your profile", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
    
    //MARK: - popup view when finish signup
  
    func showAlert() {
        if let alert = Bundle.main.loadNibNamed("CustomAlert", owner: self, options: nil)?.last as? CustomAlertView
        {
            let blackView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            self.view.addSubview(blackView)
            blackView.tag = 500
            blackView.backgroundColor = UIColor.black
            blackView.alpha = 0.400000005960464
            blackView.translatesAutoresizingMaskIntoConstraints = false
            
            
            let leadingConstraint = NSLayoutConstraint(item: blackView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
            let trailingConstraint = NSLayoutConstraint(item: blackView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            let topConstraint = NSLayoutConstraint(item: blackView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: blackView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            self.view.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
            
            self.view.addSubview(alert)
            alert.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: (UIScreen.main.bounds.size.height / 2)-20)
            alert.titleLabel.text = "Congratulations!"
            alert.bodyLabel.text = "You are now part of the family"
            alert.alertHeightConstraint.constant = 180
            
            alert.goToNextPageBtn.addTarget(self, action: #selector(self.goToMainVC), for: UIControlEvents.touchUpInside)
            self.view.bringSubview(toFront: alert)
            alert.isUserInteractionEnabled = true
        }
    }

    
}

//MARK: - textField delegte methods
extension SignUpVC: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        
        
        
      if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? JVFloatLabeledTextField
      {
         nextField.becomeFirstResponder()
      }
      else
      {
         // Not found, so remove keyboard.
         textField.resignFirstResponder()
      }
      // Do not add a line break
      return false
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 3 || textField.tag == 4
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

//MARK: - PickerView Delegete methods
extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            showLoading()
            avatarImage.image = image
            
            // Data in memory
            let data = UIImageJPEGRepresentation(image, 0)
            
            //Random uuid for image
            let uuid = UUID().uuidString
            
            // Create a reference to the file you want to upload
            let storageRef = Storage.storage().reference()
            let imageRef = storageRef.child("users_images/photo-IOS-ID:\(uuid)")
            
            
            // Upload the file to the path "images/rivers.jpg"
            _ = imageRef.putData(data!, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    print("Error  uploading photo to firebase")
                    return
                }
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata.downloadURL
                self.imageURL = downloadURL()?.absoluteString
                self.hideLoading()
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    }
}

protocol dismissAllBefore {
    func dissmissAll()
}


