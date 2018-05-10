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
    
    let nameKey = "name"
    let timeKey = "time"
    let locationKey = "location"
    let participantsKey = "participants"
    let eventDescriptionKey = "eventDescription"
    let eventNumberKey = "eventNumber"
    
    
    init(name: String, time: String, location:String, eventDescription: String, participation: String, eventNumber: Int) {
        self.name = name
        self.time = time
        self.location = location
        self.participants = participation
        self.eventDescription = eventDescription
        self.eventNumber = eventNumber
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
            self.participants = data[participantsKey] as! String
        } else {
            self.participants = "0"
        }
        
        if (data[eventNumberKey] != nil) {
            self.eventNumber = data[eventNumberKey] as! Int
        } else {
            self.eventNumber = 00
        }
        
    }
    
    var data: [String: Any] {
        return [nameKey: self.name,
                timeKey: self.time,
                locationKey: self.location,
                eventDescriptionKey: self.eventDescription,
                participantsKey: self.participants,
                eventNumberKey: self.eventNumber]
    }
    
}
