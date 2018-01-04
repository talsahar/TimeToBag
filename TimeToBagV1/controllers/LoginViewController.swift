//
//  ViewController.swift
//  TimeToTravel
//
//  Created by Admin on 08/12/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol LoginControllerDelegate{
    
    func onLoginSuccess(user:User)
    func onSignupSuccess(user:User)
    func onLoginFailed(error:Error)
    func onSignupFailed(error:Error)
    
}

class LoginViewController: UIViewController ,UITextFieldDelegate, LoginControllerDelegate{
    
    @IBOutlet weak var emailField: MyTextField!
    @IBOutlet weak var passwordField: MyTextField!
    @IBOutlet weak var nicknameField: MyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        nicknameField.delegate = self
        if MyAuthentication.isConnected(){
            loadMainController()
        }
    }
    
    @IBAction func onLogoutButton(segue:UIStoryboardSegue){
        MyAuthentication.logout()
    }
    
    @IBAction func signinAction(_ sender: Any) {
        if (emailField.text?.isEmpty)!{
            view.makeToast("Email field is empty", duration: 3.0, position: .bottom)
        }
        else if (passwordField.text?.isEmpty)!{
            view.makeToast("Password field is empty", duration: 3.0, position: .bottom)
        }
        
        else{
            MyAuthentication.signin(email: emailField.text!, password: passwordField.text!,onSuccess: {user in self.onLoginSuccess(user: user)}, onFail: {error in self.onLoginFailed(error: error)})
            
        }
    }
    @IBAction func signupAction(_ sender: Any) {
        if (emailField.text?.isEmpty)!{
            view.makeToast("Email field is empty", duration: 3.0, position: .bottom)
        }
        else
            if (passwordField.text?.isEmpty)!{
                view.makeToast("Password field is empty", duration: 3.0, position: .bottom)
            }
            else if ((passwordField.text?.count)!<6){
                view.makeToast("Password must be greater than 5 characters", duration: 3.0, position: .bottom)
            }
            else
            {
                MyAuthentication.signup(email: emailField.text!, password: passwordField.text!, nickname: nicknameField.text!, onSuccess: {user in self.onSignupSuccess(user: user)}, onFail: {error in self.onSignupFailed(error: error)})
        }
    }
    func loadMainController(){
        self.performSegue(withIdentifier: "onLoginSegue", sender: self)
    }
    
    func onLoginSuccess(user: User) {
        self.view.makeToast("you have been successfully signed in", duration: 3.0, position: .bottom)
        loadMainController()
    }
    func onSignupSuccess(user: User) {
        self.view.makeToast("you have been successfully signed up", duration: 3.0, position: .bottom)
        loadMainController()
    }
    func onLoginFailed(error: Error) {
        self.view.makeToast(error.localizedDescription, duration: 3.0, position: .bottom)
    }
    func onSignupFailed(error: Error) {
        self.view.makeToast(error.localizedDescription, duration: 3.0, position: .bottom)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

