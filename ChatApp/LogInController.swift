//
//  logoutController.swift
//  ChatApp
//
//  Created by sinbad on 6/8/1439 AH.
//  Copyright © 1439 AH sinbad. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LogInController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.rgb(red: 61, green: 91, blue: 131)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegistration)
        view.addSubview(profileImageView)
        view.addSubview(loginRegistrationSegmentedControl)
        
        setupInputsContainerView()
        setuploginRegistration()
        setupProfileImageView()
        setLoginRegistrationSegmentedControl()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    func handleRegister(){
        guard let email  = emailTextField.text,  let password = passwordTextField.text, let name = nameTextField.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error) in
            
            if error != nil {
                
                print(error!)
                return
            }
            
            // save data
            var ref: DatabaseReference
            ref = Database.database().reference(fromURL: "https://chatapp-7bf81.firebaseio.com/")
            let userReference = ref.child("users").child((user?.uid)!)
            let valus = ["name": name, "email": email, "password": password]
            userReference.updateChildValues(valus, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error!)
                    return
                }
                print("Save user")
            })
            
        }
        
        
        
        print(123)
    }
    
    
    func setLoginRegistrationSegmentedControl(){
        loginRegistrationSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive  = true
        loginRegistrationSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegistrationSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegistrationSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    func setupProfileImageView(){
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegistrationSegmentedControl.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
   
 
    
    func setupInputsContainerView() {
        
        // center position x, y, width & height
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        //name text field
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive =  true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        //separetor
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
        //email
        //name text field
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive =  true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        //separetor
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
        //password
        //name text field
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive =  true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
    }
    
    func setuploginRegistration(){
        //login button
        loginRegistration.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegistration.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegistration.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegistration.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ac")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let inputsContainerView : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        return containerView
    }()
    
    let loginRegistration: UIButton = {
        let button = UIButton()
        button.setTitle("Registration", for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = UIColor.rgb(red: 61, green: 100, blue: 161)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    let nameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let nameSeparatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 61, green: 91, blue: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailSeparatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 61, green: 91, blue: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()

    let loginRegistrationSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Registration"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    func handleLoginRegisterChange(){
        let title = loginRegistrationSegmentedControl.titleForSegment(at: loginRegistrationSegmentedControl.selectedSegmentIndex)
        loginRegistration.setTitle(title, for: .normal)
    }
}

