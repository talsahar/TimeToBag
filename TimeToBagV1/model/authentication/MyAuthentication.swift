//
//  MyAuthentication.swift
//  TimeToBag
//
//  Created by admin on 25/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//
import FirebaseAuth
import Foundation
class MyAuthentication{
   
    
    static func signin(email: String, password: String, onSuccess: @escaping (_ user:User)->Void, onFail: @escaping (_ error:Error)->Void) {
       Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (user != nil){
                onSuccess(user!)
            }
            else{
                onFail(error!)
            }
        }
    }
    
   static func signup(email: String, password: String,nickname:String, onSuccess: @escaping(_ user:User)->Void, onFail: @escaping (_ error:Error)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if ((user) != nil){
                let update=user?.createProfileChangeRequest()
                update?.displayName=nickname
                update?.commitChanges(completion: nil)
                onSuccess(user!)
            }
            else{
                onFail(error!)
            }
        }
    }
    
   static func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
    
    static func getCurrentUser()->User{
        return Auth.auth().currentUser!
    }
    
    
   static func isConnected() -> Bool {
        return (Auth.auth().currentUser != nil)
    }
}
