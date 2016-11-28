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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath )as! UserCell
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        cell.imageView?.image = UIImage(named: "job.png")
        cell.imageView?.contentMode = .scaleAspectFill
        
        
        
        return cell

    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}


class UserCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // user cell not showing 
        
       //textLabel?.frame = CGRectMake(56, textLabel!.frame.origin.y - 2, textLabel!.frame.width, textLabel!.frame.height)
        
        //detailTextLabel?.frame = CGRectMake(56, detailTextLabel!.frame.origin.y + 2, detailTextLabel!.frame.width, detailTextLabel!.frame.height)
    }
    
    
    
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "job.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        
        return imageView
        
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
      addSubview(profileImageView)
        
        //iOS 10 constraints anchors
        // need anchors
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder!) has not been implemented")
    }
    
}
