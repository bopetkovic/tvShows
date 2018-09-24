//
//  LoginViewController.swift
//  TvShows
//
//  Created by Bojan Petkovic on 24/09/2018.
//

import UIKit

class LoginViewController: UIViewController {
    var secureTextEntry: Bool = true

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var secureTextEntryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - setupUI
    func setupUI() {
        loginButton.layer.cornerRadius = 5.0
        
        addBottomBorders(parentElement: emailInputField)
        addBottomBorders(parentElement: passwordInputField)
        
        setPasswordFieldState()
        secureTextButtonStyle()
    }
    
    func addBottomBorders(parentElement: UITextField) {
        parentElement.borderStyle = .none
        
        let borderBottom = UIView()
        borderBottom.frame.size = CGSize(width: parentElement.frame.size.width, height: 1.0)
        borderBottom.frame.origin = CGPoint(x: 0, y: parentElement.frame.maxY - 15.0)
        borderBottom.backgroundColor = UIColor(red: 86.7/255.0, green: 87.1/255.0, blue: 87.5/255.0, alpha: 0.5)
        parentElement.addSubview(borderBottom)
    }
    
    // MARK: - secure text for password field functionality
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
}
