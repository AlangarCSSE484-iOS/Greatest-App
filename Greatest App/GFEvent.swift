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
        self.name = data[nameKey] as! String
        self.time = data[timeKey] as! String
        self.location = data[locationKey] as! String
        self.eventDescription = data[eventDescriptionKey] as! String
        
    }
    
    var data: [String: Any] {
        return [nameKey: self.name,
                timeKey: self.time,
                locationKey: self.location,
                eventDescriptionKey: self.eventDescription]
    }
    
}
