//
//  DibsTVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

// MARK: - 찜
enum dibsCategory {
    case whoLikeMe, whoILike
}

class DibsTVCell: UITableViewCell {
    static let identifier = "DibsTVCell"
    var dibsCategory: dibsCategory?
    var sequenceNum: Int?
    
    @IBOutlet weak var dibsImageView: UIImageView!
    @IBOutlet weak var dibsNameLabel: UILabel!
    @IBOutlet weak var dibsInfoLabel: UILabel!
    @IBOutlet weak var dibsView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var dibsBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setStyle()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DibsTVCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        APIService.shared.matchingRequest(1, "FEELING", sequenceNum ?? 0) { result in
            switch result {
            case .success(_):
                print("호감 보내기 성공")
                self.parentViewController?.showToastPurple(message: "상대에게 호감을 보냈습니다")
                NotificationCenter.default.post(name: NSNotification.Name("needToReloadDibs"), object: [0,1])
                NotificationCenter.default.post(name: NSNotification.Name("needToReloadConnected"), object: [0,2])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func dibsBtnTapped(_ sender: Any) {
        if dibsBtn.backgroundColor == .find_Mint {
            APIService.shared.matchingRequest(1, "DIBS", sequenceNum ?? 0) { result in
                switch result {
                case .success(_):
                    print("찜 하기 성공")
                    self.parentViewController?.showToastPurple(message: "상대를 찜했습니다")
                    NotificationCenter.default.post(name: NSNotification.Name("needToReloadDibs"), object: [0,1])
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            APIService.shared.matchingRequest(1, "DISCONNECTED_DIBS", sequenceNum ?? 0) { result in
                switch result {
                case .success(_):
                    print("찜 취소하기 성공")
                    self.parentViewController?.showToastPurple(message: "찜을 취소했습니다")
                    NotificationCenter.default.post(name: NSNotification.Name("needToReloadDibs"), object: [1,1])
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        APIService.shared.matchingRequest(1, "DISCONNECTED_DIBS", sequenceNum ?? 0) { result in
            switch result {
            case .success(_):
                print("찜 리스트에서 제거하기 성공")
                self.parentViewController?.showToastPurple(message: "상대가 리스트에서 제거됐습니다")
                NotificationCenter.default.post(name: NSNotification.Name("needToReloadDibs"), object: [0,0])
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DibsTVCell {
    func setStyle() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        self.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        dibsImageView.makeRounded(cornerRadius: 5)
        dibsView.backgroundColor = .white
        dibsView.makeRounded(cornerRadius: 5)
        dibsView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.05, radius: 8)
        dibsBtn.layer.borderWidth = 1
        dibsBtn.layer.borderColor = UIColor.find_Mint.cgColor
        setDibsBtn()
        sendBtn.makeRounded(cornerRadius: nil)
        dibsBtn.makeRounded(cornerRadius: nil)
    }
    
    func setDibsBtn() {
        switch dibsCategory {
        case .whoLikeMe:
            dibsBtn.backgroundColor = .find_Mint
            dibsBtn.setImage(UIImage(named: "iconStarWhite"), for: .normal)
            dibsBtn.titleLabel?.textColor = .white
            deleteBtn.isHidden = false
        case .whoILike:
            dibsBtn.backgroundColor = .white
            dibsBtn.setImage(UIImage(named: "iconStarMint"), for: .normal)
            dibsBtn.titleLabel?.textColor = .find_Mint
            deleteBtn.isHidden = true
        case .none:
            return
        }
    }
    
    func setCell(dibsDatas: ExpandableSection) {
        let url = URL(string: dibsDatas.data.profileImageURL)
        sequenceNum = dibsDatas.data.userSequence
        dibsImageView.kf.setImage(with: url)
        dibsNameLabel.text = dibsDatas.data.nickName
        dibsInfoLabel.text = "\(dibsDatas.data.age) | \(dibsDatas.data.job) | \(dibsDatas.data.location)"
    }
}
