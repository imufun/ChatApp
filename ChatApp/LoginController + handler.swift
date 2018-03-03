//
//  LoginController + handler.swift
//  ChatApp
//
//  Created by sinbad on 6/14/1439 AH.
//  Copyright © 1439 AH sinbad. All rights reserved.
//

import UIKit
extension LogInController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func handleProfileImageView(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImgaeFormPicker:  UIImage?
        
        if let editImage = info["UIImagePickerControllerEditedImage"]  {
            
            selectedImgaeFormPicker = editImage  as? UIImage
            
            ///print((editImage as AnyObject).size)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImgaeFormPicker = originalImage as? UIImage
            
            //print((originalImage as AnyObject).size)
        }
        
        if let selectedImgae = selectedImgaeFormPicker {
            profileImageView.image = selectedImgae
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancle")
        dismiss(animated: true, completion: nil)
        
    }
    
}
