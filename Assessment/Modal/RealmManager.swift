//
//  RealmManager.swift
//  Assessment
//
//  Created by Torbit-iOS on 28/10/21.
//

import Foundation
import RealmSwift


class RealmObjectManager{
    public static var shared = RealmObjectManager()
    
    func createUser(userDetail : UserModal,completion :@escaping (_ status : Bool) -> Void) {
        let userRealmObject = UserRealmObject()
        userRealmObject.firstName = userDetail.firstName
        userRealmObject.lastName = userDetail.lastName
        userRealmObject.email = userDetail.email
        userRealmObject.password = userDetail.password
        userRealmObject.phone = userDetail.phone
        userRealmObject.gender = userDetail.gender
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(userRealmObject)
            try! realm.commitWrite()
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func getUsersList(completion : @escaping (_ status : Bool,_ data : [UserModal]) -> Void){
        do {
            let realm = try Realm()
            let users = realm.objects(UserRealmObject.self)
            var usersModal = [UserModal]()
            users.forEach { userRealmObject in
                usersModal.append(UserModal(firstName: userRealmObject.firstName, lastName: userRealmObject.lastName, email: userRealmObject.email, password: userRealmObject.password, phone: userRealmObject.phone, gender: userRealmObject.gender))
            }
            return completion(true,usersModal)
        } catch {
            print(error.localizedDescription)
            return completion(false,[UserModal]())
        }
    }
}
