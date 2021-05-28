//
//  ConnectedTVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit
import Kingfisher

// MARK: - 연결된 사람
class ConnectedTVCell: UITableViewCell {
    static let identifier = "ConnectedTVCell"
    var sequenceNum: Int? // 상대의 userSequenceNum
    
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
        setStyle()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ConnectedTVCell", bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 상대와 연결 해제
    @IBAction func deleteBtnTapped(_ sender: Any) {
        let alert =  UIAlertController(title: "상대와의 연결을 해제하겠습니까?", message: nil, preferredStyle: .alert)
        let yes = UIAlertAction(title: "예", style: .default) { [self] (action) in
            APIService.shared.matchingRequest(1, "DISCONNECTED_MATCHING", sequenceNum ?? 0) { result in
                switch result {
                case .success(_):
                    print("연결된 상대 삭제 성공 시퀀스넘버: \(sequenceNum)")
                    self.parentViewController?.showToastPurple(message: "상대와의 연결이 해제되었습니다")
                    NotificationCenter.default.post(name: NSNotification.Name("needToReloadConnected"), object: [0,0])
                case .failure(let error):
                    print(error)
                }
            }
        }
        let no = UIAlertAction(title: "아니오", style: .default, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        self.parentViewController?.present(alert, animated: true, completion: nil)
    }
}

extension ConnectedTVCell {
    func setStyle() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        cntdImageView.makeRounded(cornerRadius: 5)
        sendRequestBtn.makeRounded(cornerRadius: sendRequestBtn.frame.height/2)
        cntdView.backgroundColor = .white
        cntdView.makeRounded(cornerRadius: 5)
        cntdView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.05, radius: 8)
        self.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
    }
    
    
    func setCell(cntdDatas: ExpandableSection) {
        let url = URL(string: cntdDatas.data.profileImageURL)
        sequenceNum = cntdDatas.data.userSequence
        cntdImageView.kf.setImage(with: url)
        cntdNameLabel.text = cntdDatas.data.nickName
        cntdInfoLabel.text = "\(cntdDatas.data.age) | \(cntdDatas.data.job) | \(cntdDatas.data.location)"
        cntdIntroduceLabel.text = cntdDatas.data.directMessage
    }
}
