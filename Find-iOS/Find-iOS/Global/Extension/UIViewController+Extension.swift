//
//  UIViewController+Extension.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/16.
//

import UIKit

extension UIViewController {
    func showToastGray(message: String) {
        let width_variable: CGFloat = 50
        let toastLabel = UILabel(frame: CGRect(x: width_variable, y: UIScreen.main.bounds.height-70, width: view.frame.size.width-2*width_variable, height: 30))
        // 뷰가 위치할 위치를 지정해준다. 여기서는 아래로부터 100만큼 떨어져있고, 너비는 양쪽에 10만큼 여백을 가지며, 높이는 35로
        toastLabel.backgroundColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
        toastLabel.textColor = UIColor.subGray6
        toastLabel.textAlignment = .center
        toastLabel.font = .spoqaRegular(size: 12)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 1.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showToastPurple(message: String) {
        let width_variable: CGFloat = 50
        let toastLabel = UILabel(frame: CGRect(x: width_variable, y: UIScreen.main.bounds.height-70, width: view.frame.size.width-2*width_variable, height: 30))
        // 뷰가 위치할 위치를 지정해준다. 여기서는 아래로부터 100만큼 떨어져있고, 너비는 양쪽에 10만큼 여백을 가지며, 높이는 35로
        toastLabel.backgroundColor = .find_DarkPurple
        toastLabel.textColor = UIColor.subGray6
        toastLabel.textAlignment = .center
        toastLabel.font = .spoqaRegular(size: 12)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 1.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}
