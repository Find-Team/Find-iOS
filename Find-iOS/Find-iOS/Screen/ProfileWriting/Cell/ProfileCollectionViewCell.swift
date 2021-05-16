//
//  ProfileCollectionViewCell.swift
//  Find-iOS
//
//  Created by Seri Park on 2021/05/12.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"

    @IBOutlet var purpleBox: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //테두리
        purpleBox.clipsToBounds = true
        purpleBox.layer.cornerRadius = 10
        purpleBox.layer.borderWidth = 1
        purpleBox.layer.borderColor = UIColor.find_DarkPurple.cgColor
    }

}
