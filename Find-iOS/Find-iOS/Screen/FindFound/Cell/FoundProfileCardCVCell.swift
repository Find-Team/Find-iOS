//
//  FoundProfileCardCVCell.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/21.
//

import UIKit

class FoundProfileCardCVCell: UICollectionViewCell {
    
    static let identifier = "FoundProfileCardCVCell"
    var checkLike : Bool?

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
    
    func getSuperViewController() -> UIViewController? {
        var viewController: UIViewController? = self.parentViewController
        return viewController
    }
    
    func makeStarBtn() {
//        if checkLike == nil {
//            checkLike = false
//        }
//        print("함수 안에서", checkLike)
//        if checkLike == false {
//            self.starBtn.isSelected = true
//            self.starBtn.setImage(UIImage(named: "btnFoundStarMintLine"), for: .normal)
//        }
//        else {
//            self.starBtn.isSelected = false
//            self.starBtn.setImage(UIImage(named: "btnFoundStarMint"), for: .normal)
//        }
    }

    @IBAction func starBtnClicked(_ sender: Any) {
        if self.starBtn.isSelected == false {
            self.starBtn.isSelected = true
            self.starBtn.setImage(UIImage(named: "btnFoundStarMint"), for: .normal)
            
            var currentCategory: UIViewController = getSuperViewController()!
            currentCategory.showToastPurple(message: "상대를 찜했습니다")
//            checkLike = true
//            print("아이비액션", checkLike)
        }
        
        else {
            self.starBtn.isSelected = false
            self.starBtn.setImage(UIImage(named: "btnFoundStarMintLine"), for: .normal)
        }
    }
}
