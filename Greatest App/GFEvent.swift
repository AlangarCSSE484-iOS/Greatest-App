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
    var minParticipants: Int?
    var maxParticipants: Int?
    var eventDescription: String
    
    let nameKey = "name"
    let timeKey = "time"
    let locationKey = "location"
    let minParticipantsKey = "minParticipantsKey"
    let maxParticipantsKey = "maxParticipantsKey"
    let eventDescriptionKey = "eventDescription"
    
    
    init(name: String, time: String, location:String, eventDescription: String) {
        self.name = name
        self.time = time
        self.location = location
        self.eventDescription = eventDescription
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
        
    }
    
    var data: [String: Any] {
        return [nameKey: self.name,
                timeKey: self.time,
                locationKey: self.location,
                eventDescriptionKey: self.eventDescription]
    }
    
}
