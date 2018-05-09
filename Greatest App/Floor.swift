//
//  Floor.swift
//  Greatest App
//
//  Created by CSSE Department on 4/17/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class Floor: NSObject {
    
    var name: String
    var residents = [User]()
    var participation = [Int]()
    
    init(name: String){
        self.name = name;
    }
}
