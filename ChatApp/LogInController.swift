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

    
    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ac")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfileImageView)))
        image.isUserInteractionEnabled = true
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
    
    lazy var loginRegistration: UIButton = {
        let button = UIButton(type: .system)
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
    
    lazy var loginRegistrationSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Registration"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    //*
    func handleloginRegister(){
        if loginRegistrationSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else{
            handleRegister()
        }
    }
    func handleLogin(){
        guard  let email = emailTextField.text, let password = passwordTextField.text else {
            print("in valid")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let  error = error {
                print(error)
                return
            }
            print("You have successfully login")
            self.dismiss(animated: true, completion: nil)
        }
    }
   
    
    
    func handleLoginRegisterChange(){
        let title = loginRegistrationSegmentedControl.titleForSegment(at: loginRegistrationSegmentedControl.selectedSegmentIndex)
        loginRegistration.setTitle(title, for: UIControlState())
        
        //
        
        
        inputContainerViewHeightAnchor?.constant = loginRegistrationSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        // chnage height neme textField
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegistrationSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        nameTextField.isHidden = loginRegistrationSegmentedControl.selectedSegmentIndex == 0 ? true : false
        //nameTextField.isHidden = loginRegistrationSegmentedControl.selectedSegmentIndex == 0
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegistrationSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegistrationSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
        
        
    }
    
    
    func setLoginRegistrationSegmentedControl(){
        loginRegistrationSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive  = true
        loginRegistrationSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        //loginRegistrationSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegistrationSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1).isActive = true
        loginRegistrationSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    
    func setupProfileImageView(){
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegistrationSegmentedControl.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    
    var inputContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    func setupInputsContainerView() {
        
        // center position x, y, width & height
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainerViewHeightAnchor =  inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputContainerViewHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        //name text field
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive =  true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
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
        
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
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
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    func setuploginRegistration(){
        //login button
        loginRegistration.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegistration.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegistration.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegistration.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}

