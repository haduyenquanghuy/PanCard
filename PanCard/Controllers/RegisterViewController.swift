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
    @IBOutlet weak var scrollView: UIScrollView!
    
    var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        phoneField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        registerForKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(with:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWasShown(with notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        let kbSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect).size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect = view.frame
        aRect.size.height = -kbSize.height
        
        if let activeField = activeField, aRect.contains(activeField.frame.origin) {
            scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    
    @objc func keyboardWillBeHidden() {
        
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets

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

//MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text, !text.isEmpty else { return false }
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
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
