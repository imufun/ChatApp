//
//  ViewController.swift
//  ChatApp
//
//  Created by sinbad on 6/8/1439 AH.
//  Copyright © 1439 AH sinbad. All rights reserved.
//

import UIKit
import Firebase


class MessageController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        checkIfUserLoggedIn()
        
        let image = UIImage(named: "Icon-Small")
        navigationItem.rightBarButtonItem  = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
    }
    
    func handleNewMessage(){
        
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        
        present(navController, animated: true, completion: nil)
        
        
    }
    
    func checkIfUserLoggedIn(){
        if Auth.auth().currentUser?.uid != nil {
            
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                
                if let dictonary = snapshot.value as? [String: AnyObject]{
                    self.navigationItem.title = dictonary["name"] as? String
                }
                
                
            }, withCancel: { (nil) in
                
                
            })
            
        }else{
            
            // User is signed in.
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            handleLogout()
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

