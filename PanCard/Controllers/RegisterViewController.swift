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
    
    @IBOutlet weak var nameErrLabel: IconLabel!
    @IBOutlet weak var phoneErrLabel: IconLabel!
    @IBOutlet weak var emailErrLabel: IconLabel!
    @IBOutlet weak var passwordErrLabel: IconLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        phoneField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
    }
    
    private func validateRegisterField() -> [ValidationError] {
        
        var errs = [ValidationError]()
        
        if let nameErr = nameField.validatedText(validationType: .username) {
            nameErrLabel.isHidden = false
            nameErrLabel.text = nameErr.message.rawValue
            nameErrLabel.image = UIImage(systemName: "exclamationmark.triangle")
            errs.append(nameErr)
        } else {
            nameErrLabel.isHidden = true
        }
        
        if let passwordErr = passwordField.validatedText(validationType: .password) {
            errs.append(passwordErr)
        }
        
        if let emailErr = emailField.validatedText(validationType: .email) {
            errs.append(emailErr)
        }
        
        if let phoneErr = phoneField.validatedText(validationType: .phoneNumber) {
            errs.append(phoneErr)
        }
        return errs
    }
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == RegisterViewController.registerSegue {
            let errors = validateRegisterField()
            if !errors.isEmpty {
                var message = ""
                for error in errors {
                    message.append("\(error.message.rawValue) \n")
                }
                
                showAlert(for: message)
                return false
                
            }
            login()
            return true
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
