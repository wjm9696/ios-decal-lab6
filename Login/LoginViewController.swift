//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
        static let labelWidth: CGFloat = 200
        static let labelHeight: CGFloat = 100
        static let loginViewHeight: CGFloat = 500
        static let textFieldWidth: CGFloat = 200
        static let textFieldHeight: CGFloat = 500
        static let viewRadius: CGFloat = 10
        static let buttonTextSize: CGFloat = 15
        static let buttonCornerRadius: CGFloat = 10
    }

    // TODO: instantiate the views needed for your project
    var label: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Login View Controller"
        myLabel.numberOfLines = 2
        myLabel.textColor = UIColor.white
        myLabel.textAlignment = NSTextAlignment.center
        myLabel.font = UIFont(name: "Avenir", size: Constants.buttonTextSize)
        return myLabel

    }()
    
    var loginView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = Constants.viewRadius
        return view
    }()
    
    var emailTextField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: "email")
        return field
    }()
    
    var passwordTextField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: "password")
        return field
    }()
    
    var loginButton: UIButton = {
        let myButton = UIButton()
        myButton.setTitle("Login", for: .normal)
        myButton.titleLabel?.font = UIFont(name: "Avenir", size: Constants.buttonTextSize)
        myButton.titleLabel?.numberOfLines = 2
        myButton.titleLabel?.textAlignment = .center
        myButton.setTitleColor(UIColor.white, for: .normal)
        myButton.backgroundColor = Constants.backgroundColor
        // makes the corners of the cell rounded, instead of squared off
        myButton.layer.cornerRadius = Constants.buttonCornerRadius
        myButton.layer.masksToBounds = true
        return myButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        
        // TODO: layout your views using frames or AutoLayout
        label.frame = CGRect(x: 0, y: 10, width: view.frame.width, height: Constants.labelHeight)
        //label.center = view.center
        view.addSubview(label)
        loginView.frame = CGRect(x: 0, y: 0, width: 0.9*view.frame.width, height: 0.9*view.frame.width*0.4)
        loginView.center = view.center
        view.addSubview(loginView)
        
        loginView.addSubview(emailTextField)
        loginView.addSubview(passwordTextField)
        loginView.addSubview(loginButton)
        emailTextField.frame = CGRect(x: 10, y: -30, width: 0.8*loginView.frame.width, height: Constants.labelHeight)
        passwordTextField.frame = CGRect(x: 10, y: 20, width: 0.8*loginView.frame.width, height: Constants.labelHeight)
        loginButton.frame = CGRect(x: (loginView.frame.width-100)/2, y: 90c, width: 100, height: 40)
        
        loginButton.addTarget(self, action: #selector(self.handleRegister(sender:)), for: .touchDown)

        
    }
    
    // TODO: create an IBAction for your login button
    func handleRegister(sender: UIButton){
        //...
        let email = emailTextField.text
        let password = passwordTextField.text
        authenticateUser(username: email, password: password)
        
    }
    
    
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
