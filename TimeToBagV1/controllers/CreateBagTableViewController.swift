//
//  CreateBagTableViewController.swift
//  TimeToBag
//
//  Created by admin on 26/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import SwiftSpinner
class CreateBagTableViewController: UITableViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate
{
  
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.font = UIFont(name: "Futura", size: 11)!
//        header.textLabel?.textColor = UIColor.white
//        header.backgroundColor=UIColor.blue
//    }
//    
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var userPickerImage: UIImageView!
    @IBOutlet weak var weatherPicker: UIPickerView!
    @IBOutlet weak var targetPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionField: UITextView!
    
    let weatherData = WeatherDataGenerator.generate()
    let targetData = VacationTypeDataGenerator.generate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationField.delegate=self
        //enable userPickedImage touch
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        userPickerImage.isUserInteractionEnabled = true
        userPickerImage.addGestureRecognizer(tapGestureRecognizer)
        
        pickerView(weatherPicker, didSelectRow: 0, inComponent: 0)
    }
    
    
    @IBAction func onDone(_ sender: Any) {
        
        //delete it
      //  Model.getAllBagsAndObserve()
        
        if verify()==true{
            let id=UUID().uuidString
            let userId=MyAuthentication.getCurrentUser().displayName
            let title=destinationField.text
            let description=descriptionField.text
            let vacationDate=datePicker.date
            let weather=pickerView(weatherPicker, titleForRow:weatherPicker.selectedRow(inComponent: 0), forComponent: 0)
            let type=pickerView(targetPicker, titleForRow: targetPicker.selectedRow(inComponent: 0), forComponent: 0)
            let imageUrl=ModelFileStore.saveImage(image: userPickerImage.image!, name: "images/\(id).jpg", callback: {imageUrl in
                let bag=Bag(id: id, userId: userId!, title: title!, description: description!, vacationDate: vacationDate, imageUrl: imageUrl!, weather: Weather(rawValue: weather!)!, vacationType: VacationType(rawValue: type!)!, items: nil)
                Model.storeBag(bag: bag)
                self.dismiss(animated: true, completion: nil)
                //save object on database
                
            })
        }
//        if destinationField.text != ""{
//
//            let id=UUID().uuidString
//            let imageUrl=ModelFileStore.saveImage(image: userPickerImage.image!, name: id, callback: { (imageUrl) in
//                var bag=Bag(id:id,userId: MyAuthentication.getCurrentUser().providerID, vacationDate: self.datePicker.date, imageUrl: imageUrl!, weather: Weather(rawValue: weather!)!, vacationType: VacationType(rawValue: type!)!, items: nil)
//                
//                ModelFirebase.addBag(bag: bag, completionBlock: { (error) in
//                    self.navigationController!.popViewController(animated: true)
//                    })
//                
//                
//            })
//           
//            //save to Database with generated id
//            
//            //save to local db
//            
//            //return to main
//        }
    }
    func verify()->Bool{
        return true
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
        SwiftSpinner.show("Uploading image...")
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        userPickerImage.image = image
        dismiss(animated:true, completion: nil)
        SwiftSpinner.hide()

    }
    
    
    
    
    //weather picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
     
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView==weatherPicker{
            return weatherData.count
        }
        else if pickerView==targetPicker{
            return targetData.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        if pickerView==weatherPicker{
            return Array(weatherData.keys)[row].rawValue
        }
        else if pickerView == targetPicker{
            return Array(targetData.keys)[row].rawValue
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var image:UIImage?
        if pickerView==weatherPicker{
             image=Array(weatherData.values)[row]
        }
        else if pickerView==targetPicker{
             image=Array(targetData.values)[row]
        }
        let background = UIImageView(image: image)
        background.contentMode = .scaleAspectFill
        self.tableView.backgroundView = background
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //release text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
