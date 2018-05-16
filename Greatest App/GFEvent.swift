//MARK: GF Event
//
//  GFEvent.swift
//  Greatest App
//
//  Created by CSSE Department on 4/17/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class GFEvent: NSObject {
    
    var id: String?
    var name: String
    var time: String
    var location: String
    var participants: String
    var eventDescription: String
    var eventNumber: Int
    var update: String?
    var winner: String?
    
    let nameKey = "name"
    let timeKey = "time"
    let locationKey = "location"
    let participantsKey = "participants"
    let eventDescriptionKey = "eventDescription"
    let eventNumberKey = "eventNumber"
    let updateKey = "update"
    let winnerKey = "winner"
    
    
    init(name: String, time: String, location:String, eventDescription: String, participation: String, eventNumber: Int, update: String? = "", winner: String? = "") {
        self.name = name
        self.time = time
        self.location = location
        self.participants = participation
        self.eventDescription = eventDescription
        self.eventNumber = eventNumber
        self.update = update
        self.winner = winner
    }
    
    init(documentSnapshot: DocumentSnapshot) {
        self.id = documentSnapshot.documentID
        let data = documentSnapshot.data()!
        if (data[nameKey] != nil) {
            self.name = data[nameKey] as! String
        } else {
            self.name = "_"
        }
        
        if (data[timeKey] != nil) {
            self.time = data[timeKey] as! String
        } else {
            self.time = "_"
        }
        
        if (data[locationKey] != nil) {
            self.location = data[locationKey] as! String
        } else {
            self.location = "_"
        }
        
        if (data[eventDescriptionKey] != nil) {
            self.eventDescription = data[eventDescriptionKey] as! String
        } else {
            self.eventDescription = "_"
        }
        
        if (data[participantsKey]  != nil) {
         //   self.participants = data[participantsKey] as! String
            self.participants = "\(data[participantsKey] ?? "default")" as! String
        } else {
            self.participants = "0"
        }
        
        if (data[eventNumberKey] != nil) {
            self.eventNumber = data[eventNumberKey] as! Int
        } else {
            self.eventNumber = 00
        }
        
        if (data[updateKey]  != nil) {
            self.update = data[updateKey] as? String
        } else {
            self.update = ""
        }
        
        if (data[winnerKey]  != nil) {
            self.winner = data[winnerKey] as? String
        } else {
            self.winner = ""
        }
        
        
    }
    
    func setUpdate(update:String) {
        self.update = update
    }
    
    func setWinner(winner: String) {
        self.winner = winner
    }
    
    var data: [String: Any] {
        return [nameKey: self.name,
                timeKey: self.time,
                locationKey: self.location,
                eventDescriptionKey: self.eventDescription,
                participantsKey: self.participants,
                eventNumberKey: self.eventNumber,
                updateKey: self.update ?? "",
                winnerKey: self.winner ?? ""]
    }
    
}
