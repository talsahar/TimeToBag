//
//  SettingsTabTableViewController.swift
//  TimeToBagV1
//
//  Created by admin on 03/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftSpinner
class SettingsTabTableViewController: UITableViewController ,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var nicknameField: JiroTextField!
    @IBOutlet weak var userImage: UIImageView!
    var newProfileImage:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("Loading user's data...")
        tableView.allowsSelection = false
        nicknameField.delegate=self
        let imageView = UIImageView(image: UIImage(named: "bagBackground"))
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView=imageView
        let user=MyAuthentication.getCurrentUser()
        if user != nil{
            nicknameField.text=user.displayName
            if user.photoURL != nil{
                ModelFileStore.getImage(urlStr: "profile/\(MyAuthentication.getCurrentUser().uid).jpg", callback: {
                    image in
                    self.userImage.image=image
                    SwiftSpinner.hide()
                })
//                ModelFileStore.getImage(urlStr: (user.photoURL?.absoluteString)!, callback: {
//                    image in
//                    self.userImage.image=image
//                    SwiftSpinner.hide()
//                })
            }
            
        }
        
        //enable userPickedImage touch
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //image picker
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {//for camera change to .camera
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        SwiftSpinner.show("Loading chosen image...")
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        userImage.image = image
        newProfileImage=image
        dismiss(animated:true, completion: nil)
        SwiftSpinner.hide()
    }
   
    
    @IBAction func onSave(_ sender: Any) {
        SwiftSpinner.show("Saving data...")
        if newProfileImage != nil{
            ModelFileStore.saveImage(image: newProfileImage!, name: "profile/\(MyAuthentication.getCurrentUser().uid).jpg", callback: {str in
                MyAuthentication.updateProfile(displayName: self.nicknameField.text, photo: URL(string: str!), thenDo: {
SwiftSpinner.hide()
                    
                })
            })
        }
    }
    //release text field
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

