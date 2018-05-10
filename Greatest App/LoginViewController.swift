//
//  LoginViewController.swift
//  Greatest App
//
//  Created by Kiana Caston on 5/8/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Material
import Firebase
import Rosefire
import FirebaseAuth

class LoginViewController: UIViewController {
    let REGISTRY_TOKEN = "4172dce5-7567-44f5-980b-cc885c2dcec3"
    
    @IBOutlet weak var rosefireLoginButton: RaisedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    func prepareView() {
        // Rosefire
        rosefireLoginButton.title = "Rosefire Login"
        rosefireLoginButton.titleColor = .white
        rosefireLoginButton.titleLabel!.font = RobotoFont.medium(with: 18)
        rosefireLoginButton.backgroundColor = UIColor(red: 0.5, green: 0, blue: 0, alpha: 0.9)
        rosefireLoginButton.pulseColor = .white
    }
    
    @IBAction func rosefireLogin(_ sender: Any) {
        print("login")
        Rosefire.sharedDelegate().uiDelegate = self
        Rosefire.sharedDelegate().signIn(registryToken: REGISTRY_TOKEN) { (error, result) in
            if let error = error {
                print("Error communicating with Rosefire! \(error.localizedDescription)")
                return
            }
            print("You are not signed in with Rosefire! username: \(result!.username)")
            Auth.auth().signIn(withCustomToken: result!.token,
                               completion: { (user, error) in
                                if error == nil {
                                    self.appDelegate.handleLogin()
                                } else {
                                    print("error")
                                }
                }
            )}
        }
    }
    
    // MARK: - Login Methods
    //    func loginCompletionCallback(_ user: User?, _ error: Error?) {
    //        if let error = error {
    //            print("Error during log in: \(error.localizedDescription)")
    //            let ac = UIAlertController(title: "Login Failed",
    //                                       message: error.localizedDescription,
    //                                       preferredStyle: .alert)
    //            ac.addAction(UIAlertAction(title: "Okay",
    //                                       style: .default,
    //                                       handler: nil))
    //            present(ac, animated: true)
    //        } else {
    //            appDelegate.handleLogin()
    //        }
    //    }
//}
