//
//  FeelingCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

class FeelingCVCell: UICollectionViewCell {
    static let identifier = "FeelingCVCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    func setStyle() {
        acceptBtn.makeRounded(cornerRadius: nil)
        acceptBtn.layer.borderWidth = 1
        acceptBtn.layer.borderColor = UIColor.find_Purple.cgColor
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FeelingCVCell", bundle: nil)
    }

}
