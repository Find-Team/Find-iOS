//
//  photoPreviewCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/15.
//

import UIKit

class photoPreviewCVCell: UICollectionViewCell {
    static let identifier = "photoPreviewCVCell"
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setPreviewStyle()
    }
    
    static func nib() -> UINib {
            return UINib(nibName: "photoPreviewCVCell", bundle: nil)
    }
    
    func setPreviewStyle() {
        previewView.makeRounded(cornerRadius: 10)
        previewImageView.makeRounded(cornerRadius: 10)
        editBtn.makeRounded(cornerRadius: nil)
        editBtn.isHidden = true
    }

    @IBAction func editBtnTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changePhoto"),object: nil)
    }
}
