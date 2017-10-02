//
//  FPFCourses.swift
//  FPF
//
//  Created by Bassyouni on 10/2/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class FPFCourses: UITableViewController {
    
    let parkour = ["title":"Parkour & FreeRunning","quote":"Be the movement" , "image":"parkour_item in list"]
    
    let mma = ["title":"MMA","quote":"Mixed Martial Art" , "image":"mma_item in list"]
    
    let streetWorkout = ["title":"Street Workout","quote":"Push beyond your limits" , "image":"street_workout_item in list"]
    
    var gamesArray = [Dictionary<String,String>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gamesArray = [parkour , mma , streetWorkout]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MainVCTableViewCell", for: indexPath) as? MainVCTableViewCell
        {
            let dict = gamesArray[indexPath.row]
            cell.configureCell(title: dict["title"]!, quote: dict["quote"]!, image: dict["image"]!)
            
            return cell
        }
        else
        {
            return UITableViewCell()
        }

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
