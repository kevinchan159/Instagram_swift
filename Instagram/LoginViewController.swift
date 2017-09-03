//
//  LoginViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 8/29/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    var topView: UIView!
    var logoImageView: UIImageView!
    var loginRegisterSegmentedControl: UISegmentedControl!
    var registerView: UIView!
    var loginView: UIView!
    
    var nameTextField: UITextField!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    
    var loginButton: UIButton!
    var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        setupViews()
        
    }
    
    func toggleLoginRegisterSegment() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            setupForLoginView()

        } else {
            setupForRegisterView()

        }
    }
    
    func setupViews() {
        topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = UIColor.init(red: 138/255, green: 58/255, blue: 185/255, alpha: 1)
        view.addSubview(topView)
        
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: view.frame.height*0.2).isActive = true
        
        logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.backgroundColor = UIColor.init(red: 138/255, green: 58/255, blue: 185/255, alpha: 1)
        logoImageView.image = UIImage(named: "instagram")?.withRenderingMode(.alwaysTemplate)
        logoImageView.tintColor = .white
        topView.addSubview(logoImageView)
        
        logoImageView.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: view.frame.height*0.1).isActive = true
        
        loginRegisterSegmentedControl = UISegmentedControl(items: ["Login", "Register"])
        loginRegisterSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        loginRegisterSegmentedControl.layer.cornerRadius = 5
        loginRegisterSegmentedControl.layer.borderColor = UIColor.white.cgColor
        loginRegisterSegmentedControl.selectedSegmentIndex = 0
        loginRegisterSegmentedControl.tintColor = UIColor.init(red: 252/255, green: 204/255, blue: 99/255, alpha: 1)
        loginRegisterSegmentedControl.addTarget(self, action: #selector(toggleLoginRegisterSegment), for: .valueChanged)
        //loginRegisterSegmentedControl.tintColor = .white
        view.addSubview(loginRegisterSegmentedControl)
        
        loginRegisterSegmentedControl.widthAnchor.constraint(equalToConstant: view.frame.width*0.8).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: view.frame.height*0.05).isActive = true
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.centerYAnchor.constraint(equalTo: topView.bottomAnchor, constant: view.frame.height * 0.05).isActive = true
        
        
        nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "name"
        nameTextField.layer.cornerRadius = 5
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        view.addSubview(nameTextField)
        
        nameTextField.topAnchor.constraint(equalTo: loginRegisterSegmentedControl.bottomAnchor, constant: view.frame.height * 0.025).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: view.frame.height*0.05).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: view.frame.width*0.8).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        usernameTextField = UITextField()
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "username"
        usernameTextField.layer.cornerRadius = 5
        usernameTextField.layer.borderColor = UIColor.gray.cgColor
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        view.addSubview(usernameTextField)
        
        usernameTextField.widthAnchor.constraint(equalToConstant: view.frame.width*0.8).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: view.frame.height*0.05).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: loginRegisterSegmentedControl.bottomAnchor, constant: view.frame.height*0.1).isActive = true
        
        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "password"
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width*0.8).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: view.frame.height*0.05).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: view.frame.height*0.025).isActive = true
        
        
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.backgroundColor = UIColor(red: 82/255, green: 179/255, blue: 217/255, alpha: 1)
        loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        view.addSubview(loginButton)
        
        loginButton.widthAnchor.constraint(equalToConstant: view.frame.width*0.8).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: view.frame.height*0.05).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: view.frame.height * 0.07).isActive = true
        
        registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 5
        registerButton.backgroundColor = UIColor(red: 82/255, green: 179/255, blue: 217/255, alpha: 1)
        registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        view.addSubview(registerButton)
        
        registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: view.frame.height*0.07).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: view.frame.width*0.8).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: view.frame.height*0.05).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        setupForLoginView()
    }
    
    func registerUser() {
        guard let name = nameTextField.text, let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        
        let parameters: Parameters = [
            "name": name,
            "username": username,
            "password": password
        ]
        
        Alamofire.request("http://localhost:3000/register", method: .post, parameters: parameters)
        
        print("made request")
        
        
    }
    
    func loginUser() {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        
        let parameters: Parameters = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request("http://localhost:3000/login", method: .post, parameters: parameters).responseJSON { (response) in
            print(response)
            if let JSON = response.result.value as? [String: Any] {
                if let status = JSON["status"] as? String  {
                    if status == "error" {
                        let alert = UIAlertController(title: "Failed to login", message: "Check your login information", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let navigationController = UINavigationController(rootViewController: FeedViewController())
                        self.present(navigationController, animated: true, completion: nil)
                    }
                }
                
            }
        }
    }
    
    func setupForLoginView() {
        nameTextField.alpha = 0
        registerButton.alpha = 0
        loginButton.alpha = 1
        nameTextField.text = ""
        usernameTextField.text = ""
        passwordTextField.text = ""
        
    }
    
    func setupForRegisterView() {
        loginButton.alpha = 0
        nameTextField.alpha = 1
        registerButton.alpha = 1
        nameTextField.text = ""
        usernameTextField.text = ""
        passwordTextField.text = ""
        
    }
    
    
}
