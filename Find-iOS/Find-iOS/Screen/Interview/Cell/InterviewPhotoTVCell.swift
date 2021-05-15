//
//  InterviewPhotoCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/15.
//

import UIKit
import Photos

class InterviewPhotoCVCell: UICollectionViewCell {
    static let identifier = "InterviewPhotoCVCell"
    
    @IBOutlet var addPhotoBtns: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBtnStyle()
        // Initialization code
    }
    
    static func nib() -> UINib {
            return UINib(nibName: "InterviewPhotoCVCell", bundle: nil)
        
    }
    
    func setBtnStyle(){
        for i in 0...2{
            addPhotoBtns[i].makeRounded(cornerRadius: 10)
            addPhotoBtns[i].backgroundColor = .photoBtnBack
            addPhotoBtns[i].layer.borderWidth = 1
            addPhotoBtns[i].layer.borderColor = UIColor.find_Purple.cgColor
        }
    }
    @IBAction func firstBtnTapped(_ sender: Any) {
        print("firstTapped")
    }
    
    @IBAction func secBtnTapped(_ sender: Any) {
        print("secondTapped")
    }
    
    @IBAction func thirdBtnTapped(_ sender: Any) {
        print("thirdTapped")
    }
}
