//
//  LoginController+handlers.swift
//  chatapp
//
//  Created by Karthik on 11/2/16.
//  Copyright © 2016 shivaprasad. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        FIRAuth.auth()?.createUser(withEmail: email, password: password,
                                   completion: { (user: FIRUser?, error) in
                                    
                                    if error != nil {
                                        print(error)
                                        return
                                    }
                                    
                                    
                                    guard let uid = user?.uid else {
                                        return
                                    }
                                    //successfully authenticated user
                                    
                let storageRef = FIRStorage.storage().reference().child("myImage.png")
                            
                if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
                                        
                                    
                storageRef.put(uploadData, metadata: nil, completion:
                        { (metadata, error) in
                            if error != nil {
                            print(error)
                                return
                            }
                            print(metadata)
                    })
            }
                    
                                    
                    let ref = FIRDatabase.database().reference(fromURL: "https://chatapp-9cd47.firebaseio.com/" )
                    let usersReference = ref.child("user").child(uid)
                                    
                        let values = ["name": name, "email": email]
                                    
                            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                                if err != nil {
                                    print (err)
                                        return
                                        }
                                        
                                        self.dismiss(animated: true, completion: nil)
                                    })
                                    
        })
    }
    
    
    private func registerUserIntoDatabase() {
        
        
        
        
        
        
    }
    
    func handleSelectProfileImageView() {
    let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    
   func imagePickerController(_ _picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    var selectedImageFromPicker: UIImage?
    
    if let edittedImage = info["UIImagePickerControllerEdittedImage"]
    as? UIImage {
        selectedImageFromPicker = edittedImage
    } else if let originalImage =
        info["UIImagePickerControllerOriginalImage"] as? UIImage {
        
        selectedImageFromPicker = originalImage
           }
    if let selectedImage = selectedImageFromPicker {
    profileImageView.image = selectedImage
        
    }
    dismiss(animated: true, completion: nil)
}

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        
        dismiss(animated: true, completion: nil)
    }
}
