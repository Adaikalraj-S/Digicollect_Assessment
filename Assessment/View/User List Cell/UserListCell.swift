//
//  UserListCell.swift
//  Assessment
//
//  Created by Torbit-iOS on 28/10/21.
//

import UIKit
import SkyFloatingLabelTextField

class UserListCell: UITableViewCell {

    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phonetextField: SkyFloatingLabelTextField!
    @IBOutlet weak var genderTextField: SkyFloatingLabelTextField!
    
    var user = UserModal(){
        didSet{
            firstNameTextField.text = user.firstName
            lastNameTextField.text = user.lastName
            emailTextField.text = user.email
            phonetextField.text = user.phone
            genderTextField.text = user.gender
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardBackgroundView.layer.cornerRadius = 5
        cardBackgroundView.layer.borderWidth = 0.7
        cardBackgroundView.layer.borderColor = UIColor.white.cgColor
        
        firstNameTextField.placeholder = "First Name"
        lastNameTextField.placeholder = "Last Name"
        emailTextField.placeholder = "Personal E-mail"
        phonetextField.placeholder = "Personal Phone Number"
        genderTextField.placeholder = "Gender"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
