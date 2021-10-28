//
//  WelcomeViewController.swift
//  Assessment
//
//  Created by Torbit-iOS on 28/10/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!

    
    //MARK:- Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalizedData()
    }
    
    //MARK:- Initial UI Setups
    
    func setLocalizedData(){
        welcomeLabel.text = "Welcome"
        
        registerButton.setTitle("Register", for: .normal)
        registrationButton.setTitle("Registration", for: .normal)
        
        registerButton.layer.cornerRadius = 10
        registrationButton.layer.cornerRadius = 10
        
        registerButton.addShadow()
        registrationButton.addShadow()
    }

    //MARK:- Register Button Handling
    
    @IBAction func onClickRegister(_ sender: Any) {
        let registerVC = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC, animated: true, completion: nil)
    }
    
    
    //MARK:- View Users List Button Handling
    
    @IBAction func onClickViewUsersList(_ sender: Any) {
        let usersListVC = UsersListViewController(nibName: "UsersListViewController", bundle: nil)
        usersListVC.modalPresentationStyle = .fullScreen
        self.present(usersListVC, animated: true, completion: nil)
    }
    
    
}
