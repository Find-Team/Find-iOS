//
//  UITextField+Extension.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/13.
//

import UIKit

extension UITextField{
    func addLeftPadding(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func addRightPadding(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
}
