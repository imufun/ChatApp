//
//  NewMessageControllerTableViewController.swift
//  ChatApp
//
//  Created by sinbad on 6/14/1439 AH.
//  Copyright © 1439 AH sinbad. All rights reserved.
//

import UIKit

class NewMessageController: UITableViewController {

    
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        ///tableView.dataSource = self
        //tableView.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
 
    }

    func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        cell.textLabel?.text = "HaHAHAHAHAHAHAHAHAHA"
        return cell
    }
 
}
