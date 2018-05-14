//
//  ParticipationViewController.swift
//  Greatest App
//
//  Created by Kiana Caston on 5/1/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ParticipationViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    var usersRef: CollectionReference!
    var usersListener: ListenerRegistration!
    
    let headerCellIdentifer = "HeaderCell"
    let participationCellIdentifer = "ParticipationCell"
    var users = [User]()
    
    let currentHall = "Blumberg"
    var currentUser: User!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var hallLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        hallLabel.text = currentHall
        
        tableView.delegate = self
        tableView.dataSource = self
        
        usersRef = Firestore.firestore().collection("users")
        //        let loggedinUser = Auth.auth().currentUser!
        
        //        let query = usersRef.whereField("uid", isEqualTo: loggedinUser.uid)
        //        query.getDocuments { (querySnapshot, error) in
        //            guard let snapshot = querySnapshot else {
        //                print("Error fetching documents: \(error!.localizedDescription)")
        //                return
        //            }
        //            snapshot.documentChanges.forEach{(docChange) in
        //                self.currentUser = User(documentSnapshot: docChange.document)
        //                self.hallLabel.text = self.currentUser.hall
        //            }
        //        }
        let user = User(name: "test", hall: "test hall", room: 10, participated: true)
        let user2 = User(name: "Person", hall: "test hall1", room: 202, participated: false)
        users.append(user)
        users.append(user2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.participants.removeAll()
        //
        let loggedinUser = Auth.auth().currentUser!
        
        usersRef.whereField("uid", isEqualTo: loggedinUser.uid)
            .getDocuments { (querySnapshot, error) in
                guard let snapshot = querySnapshot else {
                    print("Error fetching documents: \(error!.localizedDescription)")
                    return
                }
                snapshot.documentChanges.forEach{(docChange) in
                    self.currentUser = User(documentSnapshot: docChange.document)
                    self.hallLabel.text = self.currentUser.hall
                }
        }
        
        //        usersRef.whereField("hall", isEqualTo: self.hallLabel)
        //////            .order(by: "room")
        //            .getDocuments { (querySnapshot, error) in
        //                guard let snapshot = querySnapshot else {
        //                    print("Error fetching documents: \(error!.localizedDescription)")
        //                    return
        //                }
        //                snapshot.documentChanges.forEach{(docChange) in
        //                    let user = User(documentSnapshot: docChange.document)
        //                    self.participants.append(user)
        //                }
        //        }
    }
    
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        <#code#>
    //    }
    
    // MARK: TableView Information
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifer, for: indexPath)
            return cell
        } else {
            let cell:ParticipationTableViewCell = tableView.dequeueReusableCell(withIdentifier: participationCellIdentifer, for: indexPath) as! ParticipationTableViewCell
            let user = users[indexPath.row]
            cell.nameLabel.text = user.name
            cell.roomLabel.text = user.room.stringValue
            print(user.participated)
            if user.participated {
                cell.checkmark.isSelected = true
            } else {
                cell.checkmark.isSelected = false
            }
            return cell
        }
    }
    
    
    
    
}
