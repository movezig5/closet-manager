//
//  ClothingTableViewController.swift
//  Closet Manager
//
//  Created by Daniel Ziegler on 3/13/16.
//  Copyright © 2016 CSC471. All rights reserved.
//

import UIKit

var clothingList = [ClothingItem]();

class ClothingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedClothes = loadClothes() {
            for ci in savedClothes {
                clothingList.append(ci);
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        clothingTable.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBOutlet var clothingTable: UITableView!
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return clothingList.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let clothing = clothingList[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(clothing.type.rawValue, forIndexPath: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = clothing.name
        cell.detailTextLabel?.text = clothing.type.rawValue
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let detailViewController = segue.destinationViewController as? DetailViewController{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                detailViewController.clothing = clothingList[indexPath.row]
            }
        }
        
    }
    // MARK: NSCoding
    func saveClothes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(clothingList, toFile: ClothingItem.ArchiveURL.path!);
        if !isSuccessfulSave {
            print("Failed to save clothing list.");
        }
    }
    
    func loadClothes() -> [ClothingItem]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(ClothingItem.ArchiveURL.path!) as? [ClothingItem];
    }

}
