//
//  FeelingCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

// MARK: - 받은 호감, 보낸 호감 알맹이
class FeelingCVCell: UICollectionViewCell {
    static let identifier = "FeelingCVCell"
    
    @IBOutlet weak var feelingImageView: UIImageView!
    @IBOutlet weak var feelingView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        feelingImageView.roundCorners(cornerRadius: 5, maskedCorners: [.layerMinXMinYCorner,.layerMaxXMinYCorner])
        feelingView.makeRounded(cornerRadius: 5)
        feelingView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.05, radius: 8)
        acceptBtn.makeRounded(cornerRadius: nil)
        acceptBtn.layer.borderWidth = 1
        acceptBtn.layer.borderColor = UIColor.find_Purple.cgColor
    }
    
    func setCell(feelingDatas: Matching) {
        feelingImageView.image = UIImage(named: feelingDatas.imageName)
        nameLabel.text = feelingDatas.nickName
        infoLabel.text = "\(feelingDatas.info[0]) | \(feelingDatas.info[1]) | \(feelingDatas.info[2])"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FeelingCVCell", bundle: nil)
    }

}
