//
//  BaseViewController.swift
//  PanCard
//
//  Created by Ha Duyen Quang Huy on 20/05/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Error",
                                      message: "Please enter all information to login",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
}

