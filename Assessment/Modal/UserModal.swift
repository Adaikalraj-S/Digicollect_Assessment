//
//  UserModal.swift
//  Assessment
//
//  Created by Adaikalraj S on 28/10/21.
//

import Foundation
import RealmSwift

class UserRealmObject : Object{
    @objc dynamic var firstName = String()
    @objc dynamic var lastName = String()
    @objc dynamic var email = String()
    @objc dynamic var password = String()
    @objc dynamic var phone = String()
    @objc dynamic var gender = String()
    
}

struct UserModal{
    var firstName = String()
    var lastName = String()
    var email = String()
    var password = String()
    var phone = String()
    var gender = String()
    
    init(){
        
    }
    
    init(firstName : String,lastName : String,email : String,password : String,phone : String,gender : String){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.phone = phone
        self.gender = gender
    }
}
