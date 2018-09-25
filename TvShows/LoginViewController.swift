//
//  LoginViewController.swift
//  TvShows
//
//  Created by Bojan Petkovic on 24/09/2018.
//

import UIKit

extension UITextField {
    func addBottomBorders() {
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

class LoginViewController: UIViewController {
    var secureTextEntry: Bool = true
    var rememberMe: Bool = false

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var secureTextEntryButton: UIButton!
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var rememberMeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - setupUI
    func setupUI() {
        loginButton.layer.cornerRadius = 5.0
        
        emailInputField.addBottomBorders()
        passwordInputField.addBottomBorders()
        
        setPasswordFieldState()
        secureTextButtonStyle()
        setRememberMeImage()
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
    }
    
    func setRememberMeImage() {
        if rememberMe == true {
            rememberMeImage.image = UIImage(named: "ic-checkbox-filled")
        } else {
            rememberMeImage.image = UIImage(named: "ic-checkbox-empty")
        }
    }
}
