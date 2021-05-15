//
//  photoPreviewCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/15.
//

import UIKit

class photoPreviewCVCell: UICollectionViewCell {
    static let identifier = "photoPreviewCVCell"
    @IBOutlet weak var previewView: UIView!{
        didSet{
            previewView.makeRounded(cornerRadius: 10)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
            return UINib(nibName: "photoPreviewCVCell", bundle: nil)
    }

}
