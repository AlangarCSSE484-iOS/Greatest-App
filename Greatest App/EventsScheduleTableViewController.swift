//
//  EventsScheduleTableViewController.swift
//  Greatest App
//
//  Created by Kiana Caston on 4/17/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit

class EventsScheduleTableViewController: UITableViewController {
    
    let eventCellIdentifer = "EventCell"
    let noEventCellIdentifier = "NoEventCell"
    let showDetailSegueIdentifier = "showDetailSegue"
    var events = [GFEvent]()
    
    let event1 = GFEvent(name: "Opening Event",
                         time: "10 pm",
                         location: "SRC arena",
                         eventDescription: "get excited for Greatest Floor!")
    let event2 = GFEvent(name: "Scavenger Hunt",
                         time: "12 pm",
                         location: "around campus",
                         eventDescription: "go find some stuff across campus using vague clues")
    let event3 = GFEvent(name: "Closing event",
                         time: "8pm Saturday",
                         location: "SRC arena",
                         eventDescription: "you might get to sleep soon")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        events.append(event1)
        events.append(event2)
        events.append(event3)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(events.count, 1)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if events.count == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: noEventCellIdentifier, for: indexPath)
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: eventCellIdentifer, for: indexPath)
            cell.textLabel?.text = events[indexPath.row].name
        }
        
        return cell
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
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showDetailSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow{
                (segue.destination as! EventDetailViewController).event = events[indexPath.row]
            }
        }
     }
    
    
}
