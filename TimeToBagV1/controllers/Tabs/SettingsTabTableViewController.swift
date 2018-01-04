//
//  SettingsTabTableViewController.swift
//  TimeToBagV1
//
//  Created by admin on 03/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import TextFieldEffects

class SettingsTabTableViewController: UITableViewController ,UITextFieldDelegate{

    @IBOutlet var nicknameField: JiroTextField!
    @IBOutlet weak var saveButton: PressableButton!
    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        nicknameField.delegate=self

        let imageView = UIImageView(image: UIImage(named: "bagBackground"))
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView=imageView
        let user=MyAuthentication.getCurrentUser()
        if user != nil{
            nicknameField.text=user.displayName
            //get/set image
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    //release text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
