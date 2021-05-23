//
//  ConnectedTVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

// MARK: - 연결된 사람
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
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        cntdImageView.makeRounded(cornerRadius: 5)
        print(sendRequestBtn.bounds.height)
        print(sendRequestBtn.frame.height/2)
        sendRequestBtn.makeRounded(cornerRadius: sendRequestBtn.frame.height/2)
        cntdView.backgroundColor = .white
        cntdView.makeRounded(cornerRadius: 5)
        cntdView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.05, radius: 8)
        self.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
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
    }
    
}
