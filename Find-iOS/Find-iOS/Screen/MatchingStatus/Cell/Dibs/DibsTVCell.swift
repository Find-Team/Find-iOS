//
//  DibsTVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

// MARK: - 찜
class DibsTVCell: UITableViewCell {
    static let identifier = "DibsTVCell"
    
    @IBOutlet weak var dibsImageView: UIImageView!
    @IBOutlet weak var dibsNameLabel: UILabel!
    @IBOutlet weak var dibsInfoLabel: UILabel!
    @IBOutlet weak var dibsView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var dibsBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        dibsImageView.makeRounded(cornerRadius: 5)
        dibsView.backgroundColor = .white
        dibsView.makeRounded(cornerRadius: 5)
        dibsView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.05, radius: 8)
        self.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        sendBtn.makeRounded(cornerRadius: nil)
        dibsBtn.makeRounded(cornerRadius: nil)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DibsTVCell", bundle: nil)
    }
    
    func setCell(dibsDatas: ExpandableSection) {
        dibsImageView.image = UIImage(named: dibsDatas.data.imageName)
        dibsNameLabel.text = dibsDatas.data.nickName
        dibsInfoLabel.text = "\(dibsDatas.data.info[0]) | \(dibsDatas.data.info[1]) | \(dibsDatas.data.info[2])"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
