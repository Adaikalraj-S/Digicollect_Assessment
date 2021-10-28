//
//  UsersListViewController.swift
//  Assessment
//
//  Created by Torbit-iOS on 28/10/21.
//

import UIKit

class UsersListViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usersListTableView: UITableView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var noUserIndicatonLabel: UILabel!
    var usersList = [UserModal]()
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
            setLocalizedData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUsersList()
    }
    
    //MARK:- Initial UI Setups
    
    func setLocalizedData(){
        titleLabel.text = "Registration"
        
        usersListTableView.register(UINib(nibName: "UserListCell", bundle: nil), forCellReuseIdentifier: "UserListCell")
        usersListTableView.delegate = self
        usersListTableView.dataSource = self
        usersListTableView.separatorStyle = .none
        usersListTableView.rowHeight = 320
        usersListTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 25, right: 0)
        usersListTableView.tableFooterView = UIView()
        
        cancelButton.setTitle("CANCEL", for: .normal)
        registrationButton.setTitle("Registration", for: .normal)
        
        cancelButton.addShadow()
        registrationButton.addShadow()
        
        noUserIndicatonLabel.text = "No Users Available!"
        
        cancelButton.layer.cornerRadius = 10
        registrationButton.layer.cornerRadius = 10
        
        self.noUserIndicatonLabel.isHidden = true
        self.usersListTableView.isHidden = true
        
    }
    
    
    //MARK:- Fetchig User data from Realm Handling
    
    func getUsersList(){
        self.startActivityIndicator()
        RealmObjectManager.shared.getUsersList { status, userData in
            self.stopActivityIndicator()
            if status{
                self.usersList = userData
                if self.usersList.count == 0{
                    self.noUserIndicatonLabel.isHidden = false
                    self.usersListTableView.isHidden = true
                }else{
                    self.noUserIndicatonLabel.isHidden = true
                    self.usersListTableView.isHidden = false
                    self.usersListTableView.reloadData()
                }
            }else{
                self.showAlert(message: "Unable to fetch User Data.Try Again.")
            }
        }
    }

    //MARK:- Cancel Button Handling
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Register Button Handling
    
    @IBAction func onClickRegistration(_ sender: Any) {
        let registerVC = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC, animated: true, completion: nil)
    }
}


//MARK:- UITableView Delegates and Datasources

extension UsersListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell") as! UserListCell
        cell.user = self.usersList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
