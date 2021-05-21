//
//  FoundProfileCardCVCell.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/21.
//

import UIKit

class FoundProfileCardCVCell: UICollectionViewCell {
    
    static let identifier = "FoundProfileCardCVCell"

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var foundProfileImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var starBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellContentView.makeRounded(cornerRadius: 5)
        // Initialization code
    }
    
//    func setCellView() {
//        cellContentView.makeRounded(cornerRadius: 5)
//    }

    @IBAction func starBtnClicked(_ sender: Any) {
        if self.starBtn.isSelected == false {
            self.starBtn.isSelected = true
            self.starBtn.setImage(UIImage(named: "btnFoundStarMint"), for: .normal)
        }
        
        else {
            self.starBtn.isSelected = false
            self.starBtn.setImage(UIImage(named: "btnFoundStarMintLine"), for: .normal)
        }
    }
}
