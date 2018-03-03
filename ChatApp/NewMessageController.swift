//
//  NewMessageControllerTableViewController.swift
//  ChatApp
//
//  Created by sinbad on 6/14/1439 AH.
//  Copyright © 1439 AH sinbad. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {

    
    let cellId = "cellId"
    
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
 
        fetchUser()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        
    }

    func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    
    func fetchUser(){
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            
                let rootRef = Database.database().reference()
                let query = rootRef.child("users").queryOrdered(byChild: "name")
            query.observe(.value, with: { (snapshot) in
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    if let value = child.value as? NSDictionary {
                        let user = User()
                        let name = value["name"] as? String ?? "Name not found"
                        let email = value["email"] as? String ?? "Email not found"
                        user.name = name
                        user.email = email
                        self.users.append(user)
                        DispatchQueue.main.async { self.tableView.reloadData() }
                    }
                }
            })
            
            
            
//            if let dictonary = snapshot.value as? [String: AnyObject] {
//                let user = User()
//                user.setValuesForKeys(dictonary)
//                self.users.append(user)
//                
//                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//                
//            }
            
            
        }, withCancel: { (nil) in
            
        })
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        //cell.textLabel?.text = "dfsdfsd"
       let user = users[indexPath.row]
        cell.textLabel?.text =  user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
 
}


class UserCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}








