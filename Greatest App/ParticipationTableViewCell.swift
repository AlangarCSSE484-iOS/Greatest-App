//
//  ParticipationTableViewCell.swift
//  Greatest App
//
//  Created by Kiana Caston on 5/13/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit

class ParticipationTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var checkmark: UIButton!
    
    // http://www.iostutorialjunction.com/2018/01/create-checkbox-in-swift-ios-sdk-tutorial-for-beginners.html
    @IBAction func checkmarkTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            UIView.animate(withDuration: 0.25, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
}
