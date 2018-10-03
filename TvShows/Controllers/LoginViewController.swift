//
//  LoginViewController.swift
//  TvShows
//
//  Created by Bojan Petkovic on 24/09/2018.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    var secureTextEntry: Bool = true
    var rememberMe: Bool = false
    var authenticatedUser: Bool = false
    var userEmail: String = ""

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var secureTextEntryButton: UIButton!
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var rememberMeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        redirectLoggedUser()
        setupUI()
        setRememberMeValueInUserDefaults()
        setUserAuthenticationStatusInUserDefaults()
        
        print("Remember me: \(rememberMe)")
        print("User: \(authenticatedUser)")
    }
    
    // MARK: - setupUI
    func setupUI() {
        navigationItem.hidesBackButton = true
        
        loginButton.layer.cornerRadius = 5.0
        
        emailInputField.addBottomBorder()
        passwordInputField.addBottomBorder()
        
        setPasswordFieldState()
        secureTextButtonStyle()
        setRememberMeImage()
        
        loginButton.isEnabled = false
    }
    
    // MARK: - secure text - password field functionality
    func secureTextButtonStyle() {
        let hideCharacters = UIImage(named: "ic-hide-password")
        let showCharacters = UIImage(named: "ic-characters-hide")
        
        if secureTextEntry {
            secureTextEntryButton.setImage(hideCharacters, for: .normal)
        } else {
            secureTextEntryButton.setImage(showCharacters, for: .normal)
        }
    }
    
    func setPasswordFieldState() {
        passwordInputField.isSecureTextEntry = secureTextEntry
    }
    
    @IBAction func changeSecureTextState(_ sender: UIButton) {
        secureTextEntry = !secureTextEntry
        
        secureTextButtonStyle()
        setPasswordFieldState()
    }
    
    // MARK: - remember me
    @IBAction func rememberMeState(_ sender: UIButton) {
        rememberMe = !rememberMe
        setRememberMeImage()
//        print("Remember me value is \(rememberMe)")
        setRememberMeValueInUserDefaults()
    }
    
    func setRememberMeValueInUserDefaults() {
        if UserDefaults.standard.bool(forKey: "rememberMe") == false && rememberMe == true {
            UserDefaults.standard.set(true, forKey: "rememberMe")
        }
        print("rememberMe value \(UserDefaults.standard.bool(forKey: "rememberMe"))")
    }
    
    func setRememberMeImage() {
        if rememberMe == true {
            rememberMeImage.image = UIImage(named: "ic-checkbox-filled")
        } else {
            rememberMeImage.image = UIImage(named: "ic-checkbox-empty")
        }
    }
    
    // MARK: - login button
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if emailInputField.text!.count >= 3 && passwordInputField.text!.count >= 3 {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        userEmail = emailInputField.text!
        UserDefaults.standard.set(userEmail, forKey: "userEmail")
        
        authorizeUser()
    }
    
    // MARK: - Alamofire request
    func authorizeUser() {
        let requestParameters: Parameters = ["email" : emailInputField.text!, "password" : passwordInputField.text!]
        
        let requestUrl = "https://api.infinum.academy/api/users/sessions"
        
        Alamofire.request(
                requestUrl,
                method: .post,
                parameters: requestParameters,
                encoding: JSONEncoding.default
            ).responseJSON { (response) in
            
            let responseCode = response.response?.statusCode
            
            if responseCode == 200 {
                self.performSegue(withIdentifier: "showHomeScreen", sender: self)
                self.authenticatedUser = true
                self.setUserAuthenticationStatusInUserDefaults()
            } else {
                let alert = UIAlertController(title: "Wrong credentials", message: "Sorry! Email or password is incorrct. Please try again!", preferredStyle: .alert)
                let action = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func setUserAuthenticationStatusInUserDefaults() {
        if UserDefaults.standard.bool(forKey: "authenticatedUser") == false && authenticatedUser == true {
            UserDefaults.standard.set(authenticatedUser, forKey: "authenticatedUser")
        }
    }
    
    // MARK: - redirect if user is logged in
    func redirectLoggedUser() {
        if UserDefaults.standard.bool(forKey: "authenticatedUser") == true && UserDefaults.standard.bool(forKey: "rememberMe") == true {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showHomeScreen", sender: self)
            }
        }
    }
}

extension UITextField {
    func addBottomBorder() {
        self.borderStyle = .none
        
        let line = CALayer()
        let width = CGFloat(1.0)
        line.borderColor = UIColor(red: 86.7/255.0, green: 87.1/255.0, blue: 87.5/255.0, alpha: 0.5).cgColor
        line.frame = CGRect(x: 0, y: self.frame.size.height - 1.0, width: self.frame.size.width, height: 1.0)
        line.borderWidth = width
        self.layer.addSublayer(line)
        self.layer.masksToBounds = true
    }
}
