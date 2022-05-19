//
//  BorderTextField.swift
//  PanCard
//
//  Created by Ha Duyen Quang Huy on 19/05/2022.
//

import Foundation
import UIKit

extension UITextField {
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.borderWidth = 2.0
            layer.borderColor = UIColor.white.cgColor
            layer.masksToBounds = newValue > 0
        }
    }
}
