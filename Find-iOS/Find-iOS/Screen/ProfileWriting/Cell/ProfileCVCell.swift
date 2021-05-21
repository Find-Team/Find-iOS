//
//  ProfileCVCell.swift
//  Find-iOS
//
//  Created by Seri Park on 2021/05/20.
//

import UIKit

class ProfileCVCell: UICollectionViewCell {
    static let identifier = "ProfileCVCell"
    var receivedInt : Int? // 선택된 이미지의 인덱스 값 - preview View에서 사용하기 위함
    
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var plusView: [UIView]!
}
