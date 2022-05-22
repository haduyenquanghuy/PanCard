//
//  PanIconLabel.swift
//  PanCalendar
//
//  Created by Ha Duyen Quang Huy on 07/05/2022.
//

import Foundation
import UIKit

@IBDesignable class IconLabel: UILabel {
    
    @IBInspectable var image: UIImage?  {
        didSet {
            // Create Attachment
            let image = image?.withTintColor(textColor)
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = image
            // Set bound to reposition
            imageAttachment.bounds = CGRect(x: 0, y: 0, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
            // Create string with attachment
            let attachmentString = NSAttributedString(attachment: imageAttachment)
            // Initialize mutable string
            let completeText = NSMutableAttributedString(string: "")
            // Add image to mutable string
            completeText.append(attachmentString)
            // Add your text to mutable string
            let textAfterIcon = NSAttributedString(string: "   \(self.text ?? "")")
            completeText.append(textAfterIcon)
            
            textAlignment = .left
            attributedText = completeText
        }
    }
    
    override var text: String? {
        
        didSet {
            if let image = self.image {
                self.image = image
            }
        }
    }
    
}
