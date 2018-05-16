//
//  UpdateTableViewController.swift
//  Greatest App
//
//  Created by CSSE Department on 5/14/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class UpdateTableViewController: UITableViewController {
    
    var eventsRef: CollectionReference!
    var eventsListener: ListenerRegistration!
    
    let updateCellIdentifer = "UpdateCell"
    let noUpdateCellIdentifier = "NoUpdateCell"
    let showDetailSegueIdentifier = "showEventDetailSegue"
    var updatesArray = [GFEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsRef = Firestore.firestore().collection("events")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tableView.reloadData()
        self.updatesArray.removeAll()
        eventsListener = eventsRef.order(by: "eventNumber", descending: true)
            .addSnapshotListener({ (querySnapshot, error) in
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
                self.updatesArray.sort(by: { (e1, e2) -> Bool in
                    return e1.eventNumber < e2.eventNumber
                })
                self.tableView.reloadData()
            })
    }
    
    func eventAdded (_ document: DocumentSnapshot) {
        let newEvent = GFEvent(documentSnapshot: document)
        if (newEvent.update != ""){
            updatesArray.append(newEvent)
        }
    }
    
    func eventUpdated (_ document: DocumentSnapshot) {
        let modifiedEvent = GFEvent(documentSnapshot: document)
        for e in updatesArray {
            if (e.id == modifiedEvent.id){
                e.name = modifiedEvent.name
                e.time = modifiedEvent.time
                e.location = modifiedEvent.location
                e.update = modifiedEvent.update
                e.eventDescription = modifiedEvent.eventDescription
                break
            }
        }
    }
    
    func eventRemoved (_ document: DocumentSnapshot) {
        for i in 0..<updatesArray.count {
            if updatesArray[i].id == document.documentID {
                updatesArray.remove(at: i)
                break
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        eventsListener.remove()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(updatesArray.count, 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if updatesArray.count == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: noUpdateCellIdentifier, for: indexPath)
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: updateCellIdentifer, for: indexPath)
            
            cell.textLabel?.text = updatesArray[indexPath.row].name
            cell.detailTextLabel?.text = updatesArray[indexPath.row].update
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == showDetailSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow{
                (segue.destination as! EventDetailViewController).event = updatesArray[indexPath.row]
            }
        }
    }
    
    
}
