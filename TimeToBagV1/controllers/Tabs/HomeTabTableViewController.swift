//
//  HomeTabTableViewController.swift
//  TimeToTravel
//
//  Created by Admin on 09/12/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class HomeTabTableViewController: UITableViewController, MyCellDelegate{
    
    var bagsData=[Bag]()
    var selectedIndex:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)

        let imageView = UIImageView(image: UIImage(named: "myBagBackground2"))
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView

        ModelNotification.bagList.observe(callback: {bags in
            self.bagsData = bags!
            self.tableView.reloadData()

            })
        Model.getAllBagsAndObserve()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             }
  
    func onCellClicked(index: Int) {
        selectedIndex=index
        performSegue(withIdentifier: "myItemTableSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "myItemTableSegue") {
            
            if let myItemVC: MyItemTableViewController = segue.destination as? MyItemTableViewController {
                myItemVC.currBag = bagsData[selectedIndex!]
                
            }
        }
    }
    
//cell creation
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
return bagsData.count
    }

    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        let bag=bagsData[indexPath.row]
        cell.delegate=self
        cell.index=indexPath.row
        ModelFileStore.getImage(urlStr: bag.imageUrl!, callback: {image in
            cell.cellBackground.image = image

        })
        cell.topLeftLabel.text=bag.title
        cell.topRightLabel.text=bag.vacationDate?.onlyDate()
        cell.bottomLeftLabel.text=bag.vacationType?.rawValue
        cell.bottomRightLabel.text=bag.weather?.rawValue
        cell.clipsToBounds = true
                // Configure the cell...
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    @IBAction func onCancelCreate(segue:UIStoryboardSegue){
        
    }
    @IBAction func onDoneCreate(segue:UIStoryboardSegue){
        
    }
    
    
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
