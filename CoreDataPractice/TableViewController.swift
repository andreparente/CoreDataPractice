//
//  TableViewController.swift
//  CoreDataPractice
//
//  Created by Andre Machado Parente on 4/5/16.
//  Copyright © 2016 Andre Machado Parente. All rights reserved.
//

import UIKit
import CoreData

var users = [NSManagedObject]()

class TableViewController: UITableViewController {

    var swipe: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipe = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panHandler))
        view.addGestureRecognizer(swipe)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //funcao para carregar do CoreData!!!
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            users = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        print(users.count)
        print(users[0].entity.name)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return users.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
        
        let person = users[indexPath.row]
        //aqui eu puxo do coreData, valueForKey passa a ser o atributo que quero
        cell.labelName.text = person.valueForKey("name") as? String
        print("TA CRIANDO AS CELULAS!!")
        cell.labelEmail.text = person.valueForKey("email") as? String
        cell.labelAge.text = String(person.valueForKey("age") as! Double)

        // Configure the cell...

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func panHandler() {
        
        if(swipe.velocityInView(view).y > 0) {
            
            performSegueWithIdentifier("TableToMain", sender: self)
            
        }
        else {
            print("deslizou pro lado errado!")
        }
    }
    
    override func viewWillAppear(animated: Bool) {

        self.tableView.reloadData()

    }
    

}
