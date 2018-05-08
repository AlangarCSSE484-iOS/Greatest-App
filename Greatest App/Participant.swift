//
//  Participant.swift
//  Greatest App
//
//  Created by Kiana Caston on 5/8/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class Participant: NSObject {
    var id: String?
    var name: String
    var hall: String
    var room: NSNumber
    var participated: Bool
    
    let nameKey = "name"
    let hallKey = "hall"
    let roomKey = "room"
    let participatedKey = "participated"
    
    init(name: String, hall: String, room: NSNumber, participated: Bool) {
        self.name = name
        self.hall = hall
        self.room = room
        self.participated = participated
    }
    
    init(documentSnapshot: DocumentSnapshot) {
        self.id = documentSnapshot.documentID
        let data = documentSnapshot.data()!
        self.name = data[nameKey] as! String
        self.hall = data[hallKey] as! String
        self.room = data[roomKey] as! NSNumber
        self.participated = data[participatedKey] as! Bool
    }
    
    var data: [String: Any] {
        return [nameKey: self.name,
                hallKey: self.hall,
                roomKey: self.room,
                participatedKey: self.participated]
    }
}
