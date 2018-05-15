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
    
//    var userRef: DocumentReference!
    var usersRef: CollectionReference!
    var usersListener: ListenerRegistration!
    
    let headerCellIdentifer = "HeaderCell"
    let participationCellIdentifer = "ParticipationCell"
    var users = [User]()

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var hallLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        usersRef = Firestore.firestore().collection("users")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.users.removeAll()
        
        self.hallLabel.text = appDelegate.getCurrentUserHall()
        
        usersListener = usersRef.whereField("hall", isEqualTo: appDelegate.getCurrentUserHall())
                .order(by: "room")
                .addSnapshotListener { (querySnapshot, error) in
                    guard let snapshot = querySnapshot else {
                        print("Error fetching documents: \(error!.localizedDescription)")
                        return
                    }
                    snapshot.documentChanges.forEach{(docChange) in
                        if (docChange.type == .added) {
                            print("New pic: \(docChange.document.data())")
                            self.userAdded(docChange.document)
                        } else if (docChange.type == .modified) {
                            print("Modified pic: \(docChange.document.data())")
                            self.userUpdated(docChange.document)
                        }
                    }
                    self.tableView.reloadData()
            }
    }
    
    func userAdded(_ document: DocumentSnapshot) {
        let newUser = User(documentSnapshot: document)
        users.append(newUser)
    }
    
    func userUpdated(_ document: DocumentSnapshot) {
        let modifiedUser = User(documentSnapshot: document)
        
        for user in users {
            if (user.id == modifiedUser.id) {
                user.participated = modifiedUser.participated
                break
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        usersListener.remove()
    }
    
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
//            self.userRef.setData(user.data)
            return cell
        }
    }
}

