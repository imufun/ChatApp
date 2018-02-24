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
         
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogot))
    }
 
    func handleLogot(){
        let logoutController = LogInController()
        present(logoutController, animated: true, completion: nil)
    }

}

