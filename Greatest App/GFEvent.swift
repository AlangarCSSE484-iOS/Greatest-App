//
//  GFEvent.swift
//  Greatest App
//
//  Created by CSSE Department on 4/17/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit

class GFEvent: NSObject {
    
    var name: String
    var time: String
    var location: String
    var minParticipants: Int?
    var maxParticipants: Int?
    var eventDescription: String?
    
    init(name: String, time: String, location:String) {
        self.name = name
        self.time = time
        self.location = location
    }

}
