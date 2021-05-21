//
//  BasicInfoCVCell.swift
//  Find-iOS
//
//  Created by Seri Park on 2021/05/20.
//

import UIKit

class BasicInfoCVCell: UICollectionViewCell, UITextFieldDelegate {
    
    var basicInfoData : [BasicInfoData] = []

    static let identifier = "BasicInfoCVCell"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoTextField: UITextField!

    func setStyle() {
        titleLabel.font = UIFont.spoqaMedium(size: 13)
        titleLabel.textColor = .subGray3
    }
    
    func setCell(info: BasicInfoData){
        titleLabel.text = info.question
    }
}
