//
//  ValidatorTextField.swift
//  PanCard
//
//  Created by Ha Duyen Quang Huy on 20/05/2022.
//

import Foundation
import UIKit

extension UITextField {
    func validatedText(validationType: ValidatorType) -> ValidationError? {
        let validator = ValidatorFactory.validatorFor(type: validationType)
        return validator.validated(self.text!)
    }
}
