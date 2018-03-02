//
//  ViewController.swift
//  ChatApp
//
//  Created by sinbad on 6/8/1439 AH.
//  Copyright © 1439 AH sinbad. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        if Auth.auth().currentUser?.uid == nil {
            // User is signed in.
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            handleLogout()
        } else {
            // No user is signed in.
            // ...
        }
    }
 
    func handleLogout(){
        
        do{
            try Auth.auth().signOut()
        }catch let logoutError{
            print(logoutError)
        }
        
        let logoutController = LogInController()
        present(logoutController, animated: true, completion: nil)
    }

}

