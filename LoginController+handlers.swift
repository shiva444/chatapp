//
//  LoginController+handlers.swift
//  chatapp
//
//  Created by Karthik on 11/2/16.
//  Copyright © 2016 shivaprasad. All rights reserved.
//

import UIKit

extension LoginController: UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    func handleSelectProfileImageView() {
    let picker = UIImagePickerController()
        
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
  private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
    if let originalImage =
        info["UIImagePickerControllerOriginalImage"] {
        print(originalImage.size)
    }
    

    
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        
        dismiss(animated: true, completion: nil)
    }
}
