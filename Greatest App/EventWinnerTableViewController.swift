//
//  EventWinnerTableViewController.swift
//  Greatest App
//
//  Created by CSSE Department on 5/15/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class EventWinnerTableViewController: UITableViewController {
    
    var eventWinnerRef: CollectionReference!
    var eventWinnerListener: ListenerRegistration!
    
    let eventWinnerCellIdentifier = "EventWinnerCell"
    let noEventWinnerCellIdentifier = "NoEventWinnerCell"
    var winners = [GFEvent]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventWinnerRef = Firestore.firestore().collection("events")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tableView.reloadData()
        self.winners.removeAll()
        eventWinnerListener = eventWinnerRef.order(by: "eventNumber", descending: true).addSnapshotListener({ (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching events. error: \(error!.localizedDescription)")
                return
            }
            snapshot.documentChanges.forEach { (docChange) in
                if (docChange.type == .added) {
                    print("New update!!!: \(docChange.document.data())")
                    self.eventAdded(docChange.document)
                } else if (docChange.type == .modified) {
                    print("Edited update: \(docChange.document.data())")
                    self.eventUpdated(docChange.document)
                }else if (docChange.type == .removed) {
                    print("Event update: \(docChange.document.data())")
                    self.eventRemoved(docChange.document)
                }
            }
            self.winners.sort(by: { (e1, e2) -> Bool in
                return e1.eventNumber < e2.eventNumber
            })
            self.tableView.reloadData()
        })
    }
    
    func eventAdded (_ document: DocumentSnapshot) {
        let newEvent = GFEvent(documentSnapshot: document)
        if (newEvent.winner != ""){
            winners.append(newEvent)
        }
    }
    
    func eventUpdated (_ document: DocumentSnapshot) {
        let modifiedEvent = GFEvent(documentSnapshot: document)
        for e in winners {
            if (e.id == modifiedEvent.id){
                e.name = modifiedEvent.name
                e.winner = modifiedEvent.winner
                break
            }
        }
    }
    
    func eventRemoved (_ document: DocumentSnapshot) {
        for i in 0..<winners.count {
            if winners[i].id == document.documentID {
                winners.remove(at: i)
                break
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        eventWinnerListener.remove()
    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(winners.count, 1)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if winners.count == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: noEventWinnerCellIdentifier, for: indexPath)
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: eventWinnerCellIdentifier, for: indexPath)
            
            cell.textLabel?.text = winners[indexPath.row].name
            cell.detailTextLabel?.text = winners[indexPath.row].winner
        }
        
        return cell    }
    

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
