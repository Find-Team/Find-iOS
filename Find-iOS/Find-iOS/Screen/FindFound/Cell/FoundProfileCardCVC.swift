//
//  FoundCVC.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/13.
//

import UIKit

class FoundProfileCardCVC: UICollectionViewCell {
    
    static let identifier = "FoundProfileCardCVC"
    

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var starBtn: UIButton!
    @IBOutlet weak var profileCardImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    func setProfileCardData(img: String, name: String, information: String, introduction: String) {
        profileCardImgView.image = UIImage(named: img)
        nameLabel.text = name
        infoLabel.text = information
        introLabel.text = introduction
    }
    
    func setCellView() {
        cellContentView.makeRounded(cornerRadius: 5)
    }
    
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
