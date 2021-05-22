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
    @IBOutlet var repView: UIView!
    @IBOutlet var repLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                repView.isHidden = false
                repLabel.isHidden = false
            } else {
                repView.isHidden = true
                repLabel.isHidden = true
            }
        }
    }
    
    func setRepStyle(){
        func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
        }
        repView.backgroundColor = .find_DarkPurple
        repView.roundCorners(cornerRadius:10, maskedCorners: [.layerMinXMinYCorner])
        repView.roundCorners(cornerRadius: 3, maskedCorners: [.layerMaxXMaxYCorner])

        
        repLabel.text = "대표"
        repLabel.font = .spoqaMedium(size: 9)
        repLabel.textColor = .white
        
        repView.isHidden = true
        repLabel.isHidden = true
        
    }
    
}

