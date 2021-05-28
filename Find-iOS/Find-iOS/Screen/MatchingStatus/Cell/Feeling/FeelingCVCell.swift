//
//  FeelingCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

// MARK: - 받은 호감, 보낸 호감 알맹이
class FeelingCVCell: UICollectionViewCell {
    static let identifier = "FeelingCVCell"
    var sequenceNum: Int?
    var feelingCategory: feelingCell?
    
    @IBOutlet weak var feelingImageView: UIImageView!
    @IBOutlet weak var feelingView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        setStyle()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FeelingCVCell", bundle: nil)
    }
    
    @IBAction func acceptDibsTapped(_ sender: Any) {
        acceptBtn.backgroundColor = .find_Purple
        acceptBtn.titleLabel?.textColor = .white
        APIService.shared.matchingRequest(1, "FEELING", sequenceNum ?? 0) { result in
            switch result {
            case .success(_):
                print("호감 수락 성공")
                self.parentViewController?.showToastPurple(message: "상대와 연결 되었습니다")
                // 연결되면 연결된 상대로 올라가야함. 데이터 업데이트
                NotificationCenter.default.post(name: NSNotification.Name("needToReloadConnected"), object: [0,1])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        var disconnectMessage: String?
        var idx: [Int]?
        
        switch feelingCategory {
        case .received:
            disconnectMessage = "DISCONNECTED_RECEIVED_FEELING"
            idx = [1,1]
        case .send:
            disconnectMessage = "DISCONNECTED_SEND_FEELING"
            idx = [2,2]
        default:
            return
        }
        
        if let disconMessage = disconnectMessage {
            APIService.shared.matchingRequest(1, disconMessage, sequenceNum ?? 0) { result in
                switch result {
                case .success(_):
                    print("\(disconMessage) 호감 리스트에서 제거 성공")
                    self.parentViewController?.showToastPurple(message: "리스트에서 제거 됐습니다")

                    // 받은 호감 리스트(섹션1)에서 삭제. 데이터 업데이트
                    NotificationCenter.default.post(name: NSNotification.Name("needToReloadConnected"), object: idx)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension FeelingCVCell {
    func setStyle() {
        feelingImageView.roundCorners(cornerRadius: 5, maskedCorners: [.layerMinXMinYCorner,.layerMaxXMinYCorner])
        feelingView.makeRounded(cornerRadius: 5)
        feelingView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.05, radius: 8)
        acceptBtn.makeRounded(cornerRadius: nil)
        acceptBtn.layer.borderWidth = 1
        acceptBtn.layer.borderColor = UIColor.find_Purple.cgColor
    }
    
    func setCell(feelingDatas: Connected) {
        let url = URL(string: feelingDatas.profileImageURL)
        sequenceNum = feelingDatas.userSequence
        feelingImageView.kf.setImage(with: url)
        nameLabel.text = feelingDatas.nickName
        infoLabel.text = "\(feelingDatas.age) | \(feelingDatas.job) | \(feelingDatas.location)"
        descriptionLabel.text = feelingDatas.directMessage
    }
}
