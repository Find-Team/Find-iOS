//
//  MyProfileCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/11.
//

import UIKit

class MyProfileCVCell: UICollectionViewCell {
    static let identifier = "MyProfileCVCell"
    
    @IBOutlet weak var icImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var wholeCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(imageName: String, title: String, percentage: String, shadowColor: UIColor){
        icImageView.image = UIImage(named: imageName)
        titleLabel.text = title
        percentageLabel.text = percentage
        wholeCellView.makeRounded(cornerRadius: wholeCellView.frame.height/2)
        wholeCellView.dropShadow(color: shadowColor, offSet: CGSize(width: 0, height: 4), opacity: 0.5, radius: 50)   
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: "MyProfileCVCell", bundle: nil)
    }
}
