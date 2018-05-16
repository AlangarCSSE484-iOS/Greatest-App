//
//  AppDelegate.swift
//  Greatest App
//
//  Created by CSSE Department on 4/17/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    var currentUser: User?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        
        if Auth.auth().currentUser == nil {
            showLoginViewController()
        } else {
            showEventsViewController()
            saveUser()
        }
        window?.makeKeyAndVisible()
        return true
    }
    
    func handleLogin() {
        showEventsViewController()
        saveUser()
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error on sign out: \(error.localizedDescription)")
        }
        showLoginViewController()
    }
    
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window!.rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
    }
    
    func showEventsViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window!.rootViewController = storyboard.instantiateViewController(withIdentifier: "EventsViewController")
    }
    
    func saveUser() {
        let usersRef = Firestore.firestore().collection("users")
        if let loggedInUser = Auth.auth().currentUser {
            usersRef.whereField("uid", isEqualTo: loggedInUser.uid)
                    .getDocuments { (querySnapshot, error) in
                    guard let snapshot = querySnapshot else {
                        print("Error fetching documents: \(error!.localizedDescription)")
                        return
                    }
                    snapshot.documentChanges.forEach{(docChange) in
                        self.currentUser = User(documentSnapshot: docChange.document)
                    }
                }
        }
    }
    
    func getCurrentUserHall() -> String {
         return self.currentUser!.hall
    }
}

extension UIViewController {
    var appDelegate : AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
}
