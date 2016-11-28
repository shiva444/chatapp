
//  ViewController.swift
//  chatapp
//
//  Created by IT Test Mac on 9/29/16.
//  Copyright © 2016 shivaprasad. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                style: .plain, target: self, action: #selector(handleLogout))
        let image = UIImage(named: "new_msg.png")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMesaage))
        
        
        
    
                checkIfUserIsLoggedIn()
    }
    
    func handleNewMesaage(){
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        
        present(navController, animated: true,
        completion: nil)
    }
    
    

    func checkIfUserIsLoggedIn(){
        
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        
        } else {
            fetchUserAndSetupNavBarTitle()
            
            }
        }
    func fetchUserAndSetupNavBarTitle() {
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
            self.navigationItem.title = dictionary["name"] as? String
            let user = User()
                user.setValuesForKeys(dictionary)
                
                
                self.setupNavBarWithUser(user: user)
            }
            
            
        }, withCancel: nil)
        
    }
    
    func setupNavBarWithUser(user: User) {
        let titleView = UIView()
        titleView.frame = CGRect(x: 0 , y: 0, width: 100, height: 40)
        titleView.backgroundColor = UIColor.red
        
        let profileImageView = UIImageView()
        if let profileImageView = user.profileImageUrl {
            //profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
            }
        
        self.navigationItem.titleView = titleView
    }

func handleLogout() {
        
        do {
            
         try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print (logoutError)
        }
        let loginController = LoginController()
    loginController.messagesController = self
        present(loginController, animated: true, completion: nil)

}

}
