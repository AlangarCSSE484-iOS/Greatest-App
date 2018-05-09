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
    
    let currentUser = Auth.auth().currentUser!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var hallLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersRef = Firestore.firestore().collection("users")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.participants.removeAll()
        
//        let query = usersRef.whereField("uid", isEqualTo: currentUser.uid)
//        query.getDocuments { (querySnapshot, error) in
//            guard let snapshot = querySnapshot else {
//                print("Error fetching documents: \(error!.localizedDescription)")
//                return
//            }
//            snapshot.documentChanges.forEach{(docChange) in
//                let newUser = User(documentSnapshot: docChange.document)
//                self.hallLabel.text = newUser.hall
//        }
//        }
        
        //        participationListener = participationRef.order(by: "room",descending: true).addSnapshotListener({ (querySnapshot, error) in
        //            guard let snapshot = querySnapshot else {
        //                print("Error fetching events. error: \(error!.localizedDescription)")
        //                return
        //            }
        //        })
    }
    
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
