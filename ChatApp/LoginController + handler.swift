//
//  LoginController + handler.swift
//  ChatApp
//
//  Created by sinbad on 6/14/1439 AH.
//  Copyright © 1439 AH sinbad. All rights reserved.
//

import UIKit

import Firebase
extension LogInController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func handleProfileImageView(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImgaeFormPicker:  UIImage?
        
        if let editImage = info["UIImagePickerControllerEditedImage"]  as? UIImage{
            
            selectedImgaeFormPicker = editImage
            
            ///print((editImage as AnyObject).size)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"]   {
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
    
    
    
    ///registration
 
    
    
    func handleRegister(){
        guard let email  = emailTextField.text,  let password = passwordTextField.text, let name = nameTextField.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            // save data
            //let storageRef = Storage.storage(url:"gs://chatapp-7bf81.appspot.com/")
            let storage = Storage.storage()
            
            let imagNmae = NSUUID().uuidString
            
            let storageRef = storage.reference().child("\(imagNmae).png")
            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!){
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let profileImageUrl =   metadata?.downloadURL()?.absoluteString  {
                        let values = ["name": name, "email": email, "password": password,  "profileImageUrl": profileImageUrl] as [String : Any]
                        self.registerUserIntoDatabaseWithUIID(uid: uid, values: values as [String : AnyObject])
                    }
                   
                    print(metadata!)
                })
            }
        }
        print(123)
    }

    private func registerUserIntoDatabaseWithUIID(uid: String, values: [String: AnyObject]){
       
        var ref: DatabaseReference
        ref = Database.database().reference(fromURL: "https://chatapp-7bf81.firebaseio.com/")
        let userReference = ref.child("users").child((uid))
       
        userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if let error = error {
                print(error)
                return
            }
            self.dismiss(animated: true, completion: nil)
            print("Save user")
        })
    }
    
}
