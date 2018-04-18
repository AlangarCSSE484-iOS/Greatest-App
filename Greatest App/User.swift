//
//  User.swift
//  Greatest App
//
//  Created by CSSE Department on 4/17/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var username: String
    var role: String
    var floor: String?
    
    init(username: String, role: String) {
        self.username = username
        self.role = role
        
    }
}
