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
    var participation = 0.0
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var hallLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.25
        
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
                self.updateParticipation()
                self.tableView.reloadData()
        }
    }
    
    func userAdded(_ document: DocumentSnapshot) {
        let newUser = User(documentSnapshot: document)
        users.append(newUser)
        updateParticipation()
    }
    
    func userUpdated(_ document: DocumentSnapshot) {
        let modifiedUser = User(documentSnapshot: document)
        
        for user in users {
            if (user.id == modifiedUser.id) {
                user.participated = modifiedUser.participated
                break
            }
        }
        updateParticipation()
    }
    
    func updateParticipation() {
        var k = 0.0
        for user in users{
            if (user.participated){
                k = k + 1
            }
        }
        let fraction = Double(k / Double(users.count))
        self.participation = round(fraction * Double(100.0))
        percentLabel.text = "\(self.participation)"
        progressBar.setProgress(Float(fraction), animated: false)
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
            cell.checkmark.tag = indexPath.row
            if user.participated{
                cell.checkmark.setImage(#imageLiteral(resourceName: "Checkmark"), for: .normal)
                cell.checkmark.isSelected = true
            } else {
                cell.checkmark.setImage(#imageLiteral(resourceName: "Checkmarkempty"), for: .normal)
                cell.checkmark.isSelected = false
            }
            return cell
        }
    }
    
    @IBAction func checkmarkTapped(_ sender: UIButton) {
        if (appDelegate.currentUser?.reslife)! {
            let user = users[sender.tag]
            user.participated = !sender.isSelected
            updateUser(user, sender)
        }
        
    }
    
    func updateUser(_ user: User, _ sender: UIButton) {
        let userRef = usersRef.document(user.id!)
        userRef.updateData(["participated" : user.participated]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
}


