//
//  RegisterViewController.swift
//  Assessment
//
//  Created by Adaikalraj S on 28/10/21.
//

import UIKit
import SkyFloatingLabelTextField
import RealmSwift
import Realm

class RegisterViewController: UIViewController {
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNametextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNametextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phonetextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var genderTitleLabel: UILabel!
    @IBOutlet var genderButtonCollection: [UIButton]!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var gender = String()
    
    //MARK:- Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalizedData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLocalizedData()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    //MARK:- Initial UI Setups
    
    func setLocalizedData(){
        titleLabel.text = "Registration"
        firstNametextField.placeholder = "First Name*"
        lastNametextField.placeholder = "Last Name*"
        emailTextField.placeholder = "Personal E-mail*"
        passwordTextField.placeholder = "Password*"
        confirmPasswordTextField.placeholder = "Confirm Password*"
        phonetextField.placeholder = "Personal Phone Number*"
        genderTitleLabel.text = "Gender*"
        
        
        cancelButton.setTitle("CANCEL", for: .normal)
        registerButton.setTitle("Registration", for: .normal)
        
        cancelButton.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 10
        
        cancelButton.addShadow()
        registerButton.addShadow()
        
        self.genderButtonCollection.forEach { genderButton in
            switch genderButton.tag{
            case 0 :
                genderButton.setTitle("Male", for: .normal)
                break
            case 1 :
                genderButton.setTitle("Female", for: .normal)
                break
            case 2 :
                genderButton.setTitle("Other", for: .normal)
                break
            default : break
            }
        }
        
        self.firstNametextField.delegate = self
        self.lastNametextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.phonetextField.delegate = self
        
        self.emailTextField.keyboardType = .emailAddress
        self.phonetextField.keyboardType = .numberPad
        self.passwordTextField.isSecureTextEntry = true
        self.confirmPasswordTextField.isSecureTextEntry = true
        
        self.loadToolBar()
    }
    
    
    //MARK:- Keyboard Observers
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo!
        var keyboardFrame : CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        var contentInset:UIEdgeInsets = self.mainScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.mainScrollView.contentInset = contentInset
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.mainScrollView.contentInset = contentInset
        
    }
    
    //MARK:- Toolbar Handling
    
    func loadToolBar(){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker))
        doneButton.tag = 1
        let space = UIBarButtonItem(barButtonSystemItem : UIBarButtonItem.SystemItem.flexibleSpace ,  target: nil, action: nil)
        toolBar.setItems([space ,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.phonetextField.inputAccessoryView = toolBar
    }
    
    //MARK:- Picker Input Accessory View Actions
    
    @objc func donePicker(_ sender : UIButton){
        self.view.endEditing(true)
    }
    
    //MARK:- Fields Validation Handlings
    
    func validateFields() ->  Bool{
        if firstNametextField.text!.isEmpty{
            firstNametextField.errorMessage = "Kindly Enter First Name"
            return false
        }
        
        if lastNametextField.text!.isEmpty{
            lastNametextField.errorMessage = "Kindly Enter Last Name"
            return false
        }
        
        if emailTextField.text!.isEmpty{
            emailTextField.errorMessage = "Kindly Enter Personal E-mail"
            return false
        }
        
        if !(emailTextField.text!.isValidEmail()){
            emailTextField.errorMessage = "Kindly Enter Valid Personal E-mail"
            return false
        }
        
        if passwordTextField.text!.isEmpty{
            passwordTextField.errorMessage = "Kindly Enter Password"
            return false
        }
        
        if confirmPasswordTextField.text!.isEmpty{
            confirmPasswordTextField.errorMessage = "Kindly Enter Confirm Password"
            return false
        }
        
        if passwordTextField.text! != confirmPasswordTextField.text!{
            confirmPasswordTextField.errorMessage = "Password & Confirm Password Doesn't match"
            return false
        }
        
        if phonetextField.text!.isEmpty{
            phonetextField.errorMessage = "Kindly Enter Personal Phone Number"
            return false
        }
        
        if phonetextField.text!.count < 10{
            phonetextField.errorMessage = "Kindly Enter Valid Phone Number"
            return false
        }
        
        if gender == ""{
            self.showAlert(message: "Kindly Select Gender")
            return false
        }
        return true
    }
    
    //MARK:- Gender Selection Button Handling
    
    @IBAction func onClickGenderSelection(_ sender: Any) {
        guard let sender = sender as? UIButton else { return }
        self.genderButtonCollection.forEach { genderButton in
            if sender == genderButton{
                genderButton.isSelected = true
                self.gender = sender.titleLabel?.text ?? ""
            }else{
                genderButton.isSelected = false
            }
        }
        
    }
    
    
    //MARK:- Cancel Button Handling
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- Register Button Handling
    
    @IBAction func onClickRegister(_ sender: Any) {
        self.view.endEditing(true)

        if validateFields(){
            self.startActivityIndicator()
            let firstName = firstNametextField.text ?? ""
            let lastName = lastNametextField.text ?? ""
            let email = emailTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            let phone = phonetextField.text ?? ""
            
            let user = UserModal(firstName: firstName, lastName: lastName, email: email, password: password, phone: phone, gender: self.gender)
            RealmObjectManager.shared.createUser(userDetail: user) { status in
                self.stopActivityIndicator()
                if status{
                    self.showAlertwithAction(message: "User Registered Successfully") {
                        self.dismiss(animated: true, completion:nil)
                    }
                }else{
                    self.showAlert(message: "User Registration Failed!")
                }
            }
        }
        return
    }
 
}

//MARK:- UITextField Delegates

extension RegisterViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let skyTF = textField as? SkyFloatingLabelTextField{
            skyTF.errorMessage = nil
            skyTF.textColor = .white
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

