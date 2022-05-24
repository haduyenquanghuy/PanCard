//
//  LoginViewController.swift
//  PanCard
//
//  Created by Ha Duyen Quang Huy on 18/05/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    static let defaultFontSize = 16.0
    static let passwordMinLength = 6
    static let registerLink = "RegisterLink"
    static let signInSegue = "didSignIn"
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpRegisterTextView()
        emailField.delegate = self
        passwordField.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setUpRegisterTextView() {
        let text = NSMutableAttributedString(string: "Not a member? ")
        let textFont = FontProvider.defaultRegularFont(with: LoginViewController.defaultFontSize)
        
        text.addAttribute(NSAttributedString.Key.font,
                          value: textFont,
                          range: NSRange(location: 0, length: text.length))
        
        let registerText = NSMutableAttributedString(string: "Register now")
        registerText.addAttribute(NSAttributedString.Key.font,
                                  value: textFont,
                                  range: NSRange(location: 0, length: registerText.length))
        
        registerText.addAttribute(NSAttributedString.Key.link,
                                  value: LoginViewController.registerLink,
                                  range: NSRange(location: 0, length: registerText.length))
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        text.addAttribute(NSAttributedString.Key.paragraphStyle,
                          value: paragraph,
                          range: NSRange(location: 0, length: text.length))
        
        text.append(registerText)
        
        registerTextView.attributedText = text
        
        registerTextView.delegate = self
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == LoginViewController.signInSegue {
            if validateLoginField() {
                login()
                return true
            }
            alertUserLoginError()
        }
        return false
    }
    
    private func validateLoginField() -> Bool {
        if let username = emailField.text,
           let password = passwordField.text,
           !username.isEmpty,
           !password.isEmpty,
           password.count >= LoginViewController.passwordMinLength {
            return true
        }
        return false
    }
    
    private func login() {
        // Firebase login code
    }
}

//MARK: - UITextViewDelegate

extension LoginViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        if URL.absoluteString == LoginViewController.registerLink {
            let registerVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: RegisterViewController.identifier())
            navigationController?.pushViewController(registerVC, animated: true)
            
            return true
        }
        return false
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text, !text.isEmpty else { return false }

        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
    }
    
}
