//
//  ParticipationViewController.swift
//  Greatest App
//
//  Created by Kiana Caston on 5/1/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class ParticipationViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    var usersRef: CollectionReference!
    var usersListener: ListenerRegistration!
    
    let headerCellIdentifer = "HeaderCell"
    let participationCellIdentifer = "ParticipationCell"
    var participants = [User]()
    
    let currentHall = "Blumberg"
    var currentUser: User!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var hallLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        hallLabel.text = currentHall
        
        usersRef = Firestore.firestore().collection("users")
        let loggedinUser = Auth.auth().currentUser!
        
        let query = usersRef.whereField("uid", isEqualTo: loggedinUser.uid)
        query.getDocuments { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching documents: \(error!.localizedDescription)")
                return
            }
            snapshot.documentChanges.forEach{(docChange) in
                self.currentUser = User(documentSnapshot: docChange.document)
                self.hallLabel.text = self.currentUser.hall
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.participants.removeAll()
        
        let loggedinUser = Auth.auth().currentUser!
        
        let query = usersRef.whereField("uid", isEqualTo: loggedinUser.uid)
        query.getDocuments { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching documents: \(error!.localizedDescription)")
                return
            }
            snapshot.documentChanges.forEach{(docChange) in
                self.currentUser = User(documentSnapshot: docChange.document)
                self.hallLabel.text = self.currentUser.hall
            }
        }
        
        
//        usersListener = participationRef.where.order(by: "room",descending: true).addSnapshotListener({ (querySnapshot, error) in
//            guard let snapshot = querySnapshot else {
//                print("Error fetching events. error: \(error!.localizedDescription)")
//                return
//            }
//            snapshot.documentChanges.forEach{(docChange) in
//
//            }
//        })
    }
    
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        <#code#>
    //    }
    
    // MARK: TableView Information
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if (indexPath.section == 0) {
            cell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifer, for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: participationCellIdentifer, for: indexPath)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }
        
        return participants.count
    }
    
    
}
