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
    
    var participationRef: CollectionReference!
    var participationListener: ListenerRegistration!
    
    let headerCellIdentifer = "HeaderCell"
    let participationCellIdentifer = "ParticipationCell"
    var participants = [Participant]()
    
    let currentHall = "Blumberg"
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var hallLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hallLabel.text = currentHall
        
//        participants.append(Participant(name: "Kiana", room: "Blum", participated: true))
//        participants.append(Participant(name: "Vibha", room: "West 1 Best 1", participated: true))
//
        
    participationRef = Firestore.firestore().collection("participation")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.participants.removeAll()
//        participationListener = participationRef.order(by: "room",descending: true).addSnapshotListener({ (querySnapshot, error) in
//            guard let snapshot = querySnapshot else {
//                print("Error fetching events. error: \(error!.localizedDescription)")
//                return
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
