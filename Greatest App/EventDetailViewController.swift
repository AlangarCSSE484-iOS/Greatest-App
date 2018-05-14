//
//  EventDetailViewController.swift
//  Greatest App
//
//  Created by Kiana Caston on 4/17/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var participantInfo: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!
    
    
    var event: GFEvent?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()

        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        eventLabel.text = event?.name
        locationLabel.text = event?.location
        timeLabel.text = event?.time
        descriptionLabel.text = event?.eventDescription
        participantInfo.text = event?.participants
        if (event?.update != ""){
            updateLabel.text = event?.update
            updateLabel.textColor = UIColor.red
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
