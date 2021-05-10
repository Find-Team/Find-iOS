//
//  UILabel+Extension.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit

extension UILabel {
    @IBInspectable
        var letterSpacing: CGFloat {
            set {
                let attributedString: NSMutableAttributedString
                if let currentAttrString = attributedText {
                    attributedString = NSMutableAttributedString(attributedString: currentAttrString)
                }
                else {
                    attributedString = NSMutableAttributedString(string: self.text ?? "")
                    self.attributedText = attributedString
                }
                
                attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: attributedString.length))
                self.attributedText = attributedString
            }
            get {
                if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                    return currentLetterSpace
                }
                else {
                    return 0
                }
            }
        }
}
