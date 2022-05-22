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
        
        var firstErrorField: UITextField?
        
        func updateUITextField(_ textField: UITextField, errorLabel label: UILabel, validateType: ValidatorType) {
            if let error = textField.validatedText(validationType: validateType) {
                errs.append(error)
                label.isHidden = false
                label.text = error.message.rawValue
                if firstErrorField == nil {
                    firstErrorField = textField
                }
                textField.layer.borderColor = UIColor.red.cgColor
            } else {
                label.isHidden = true
                textField.layer.borderColor = UIColor.white.cgColor
            }
        }
        
        updateUITextField(nameField, errorLabel: nameErrLabel, validateType: .username)
        updateUITextField(phoneField, errorLabel: phoneErrLabel, validateType: .phoneNumber)
        updateUITextField(emailField, errorLabel: emailErrLabel, validateType: .email)
        updateUITextField(passwordField, errorLabel: passwordErrLabel, validateType: .password)

        if firstErrorField != nil {
            firstErrorField!.becomeFirstResponder()
        }
        
        return errs
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == RegisterViewController.registerSegue {
            let errors = validateRegisterField()
            if errors.isEmpty {
                return true
            }
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
