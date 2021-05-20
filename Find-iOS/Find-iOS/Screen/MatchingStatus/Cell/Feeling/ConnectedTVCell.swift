//
//  ConnectedTVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

class ConnectedTVCell: UITableViewCell {
    static let identifier = "ConnectedTVCell"
    @IBOutlet weak var cntdImageView: UIImageView!
    @IBOutlet weak var cntdNameLabel: UILabel!
    @IBOutlet weak var cntdInfoLabel: UILabel!
    @IBOutlet weak var cntdIntroduceLabel: UILabel!
    @IBOutlet weak var sendRequestBtn: UIButton!
    @IBOutlet weak var cntdView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    func setStyle() {
        sendRequestBtn.makeRounded(cornerRadius: nil)
        cntdView.makeRounded(cornerRadius: 5)
    }
    
    func setCell(imageName: String, name: String, info: [String], introduce: String) {
        cntdImageView.image = UIImage(named: imageName)
        cntdNameLabel.text = name
        cntdInfoLabel.text = "\(info[0]) | \(info[1]) | \(info[2])"
        cntdIntroduceLabel.text = introduce
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ConnectedTVCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
