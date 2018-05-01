//
//  EventsScheduleTableViewController.swift
//  Greatest App
//
//  Created by Kiana Caston on 4/17/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class EventsScheduleTableViewController: UITableViewController {
    
    var eventsRef: CollectionReference!
    var eventsListener: ListenerRegistration!
    
    let eventCellIdentifer = "EventCell"
    let noEventCellIdentifier = "NoEventCell"
    let showDetailSegueIdentifier = "showDetailSegue"
    var events = [GFEvent]()
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        events.append(event1)
//        events.append(event2)
//        events.append(event3)
//        deleteEntireDatabase(collection: "events")
//        seedDatabase()
        eventsRef = Firestore.firestore().collection("events")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tableView.reloadData()
        self.events.removeAll()
        eventsListener = eventsRef.order(by: "time", descending: true).addSnapshotListener({ (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching events. error: \(error!.localizedDescription)")
                return
            }
            snapshot.documentChanges.forEach { (docChange) in
                if (docChange.type == .added) {
                    print("New event: \(docChange.document.data())")
                    self.eventAdded(docChange.document)
                } else if (docChange.type == .modified) {
                    print("Edited event: \(docChange.document.data())")
                    self.eventUpdated(docChange.document)
                }else if (docChange.type == .removed) {
                    print("Event deleted: \(docChange.document.data())")
                    self.eventRemoved(docChange.document)
                }
            }
            self.events.sort(by: { (e1, e2) -> Bool in
                return e1.time > e2.time
            })
            self.tableView.reloadData()
        })
    }
    
    func eventAdded (_ document: DocumentSnapshot) {
        let newEvent = GFEvent(documentSnapshot: document)
        events.append(newEvent)
    }
    
    func eventUpdated (_ document: DocumentSnapshot) {
        let modifiedEvent = GFEvent(documentSnapshot: document)
        for e in events {
            if (e.id == modifiedEvent.id){
                e.name = modifiedEvent.name
                e.time = modifiedEvent.time
                e.location = modifiedEvent.location
                e.eventDescription = modifiedEvent.eventDescription
                break
            }
        }
    }
    
    func eventRemoved (_ document: DocumentSnapshot) {
        for i in 0..<events.count {
            if events[i].id == document.documentID {
                events.remove(at: i)
                break
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        eventsListener.remove()
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
    
    //Mark: Helper functions to populate database
    
    private func deleteEntireDatabase(collection: String) {
        Firestore.firestore().collection(collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
            for document in querySnapshot!.documents {
                print("Deleting \(document.documentID) => \(document.data())")
                document.reference.delete()
            }
        }
    }
    
    private func seedDatabase() {
        addDocument(name: "Opening Event",
                    time: "10 pm",
                    location: "SRC arena",
                    eventDescription: "get excited for Greatest Floor!")
        addDocument(name: "Scavenger Hunt",
                    time: "12 pm",
                    location: "around campus",
                    eventDescription: "go find some stuff across campus using vague clues")
        addDocument(name: "Closing event",
                    time: "8pm Saturday",
                    location: "SRC arena",
                    eventDescription: "you might get to sleep soon")
    }
    
    private func addDocument(name: String, time: String, location: String, eventDescription:String){
        var ref: DocumentReference? = nil
        ref = Firestore.firestore().collection("events").addDocument(data: [
            "name": name,
            "time": time,
            "location": location,
            "eventDescription": eventDescription
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
