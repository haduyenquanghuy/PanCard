//
//  LoginViewController.swift
//  PanCard
//
//  Created by Ha Duyen Quang Huy on 18/05/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    static let defaultFontSize = 16.0
    static let registerLink = "RegisterLink"
    
    @IBOutlet weak var registerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpRegisterTextView()
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
    
}

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
