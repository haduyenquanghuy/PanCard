//
//  RegisterViewController.swift
//  PanCard
//
//  Created by Ha Duyen Quang Huy on 18/05/2022.
//

import UIKit

class RegisterViewController: UIViewController {
    
    static let registerSegue = "didRegister"
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        phoneField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
    }
    
    private func validateRegisterField() -> Bool {
        if let name = nameField.text,
           let phoneNum = phoneField.text,
           let email = emailField.text,
           let password = passwordField.text,
           !name.isEmpty,
           !phoneNum.isEmpty,
           !email.isEmpty,
           !password.isEmpty,
           password.count >= LoginViewController.passwordMinLength {
            return true
        }
        return false
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == RegisterViewController.registerSegue {
            if validateRegisterField() {
                login()
                return true
            }
            alertUserLoginError()
        }
        return false
    }
    
    func login() {
        
    }
    
    static func identifier() -> String {
        return String(describing: RegisterViewController.self)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text, !text.isEmpty else { return false }
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == nameField {
            phoneField.becomeFirstResponder()
        } else if textField == phoneField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
    }
    
}
