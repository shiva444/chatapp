//
//  NewMessageController.swift
//  chatapp
//
//  Created by Karthik on 10/20/16.
//  Copyright © 2016 shivaprasad. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    
    let cellId = "cellId"

 var users  = [User]()
        override func viewDidLoad() {
        
        
        super.viewDidLoad()
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
            
            tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
            
            fetchUser()
        
    
    }
    func fetchUser() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                
                let user = User()
                
                //if you use this setter, your app will crash if your class properties s=dont excatly match up with the firebase
            user.setValuesForKeys(dictionary)
                    self.users.append(user)
                
                //dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            }
            
            //users.name = dictionary["name"]
            
        }, withCancel: nil)
    }
    
    
        func handleCancel() {
            
        dismiss(animated: true, completion: nil)
    

        }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    
}
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       // let cell = UITableViewCell(style: .subtitle, reuseIdentifier:cellId)
        
        
       let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        
        return cell

    }
}


class UserCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder!) has not been implemented")
    }
    
}
