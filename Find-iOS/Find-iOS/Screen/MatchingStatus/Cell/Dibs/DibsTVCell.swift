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
    @IBOutlet weak var dibsBtnWidth: NSLayoutConstraint!
    
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
        APIService.shared.matchingRequest(1, "FEELING", sequenceNum ?? 0) { [self] result in
            switch result {
            case .success(_):
                print("호감 보내기 성공")
                self.parentViewController?.showToastPurple(message: "상대에게 호감을 보냈습니다")
                switch dibsCategory {
                case .whoILike:
                    // 나를 찜한 사람에서 호감보내기
                    NotificationCenter.default.post(name: NSNotification.Name("needToReloadDibs"), object: [0,0])
                    NotificationCenter.default.post(name: NSNotification.Name("needToReloadConnected"), object: nil)
                case .whoLikeMe:
                    // 내가 찜한 사람에서 호감보내기
                    NotificationCenter.default.post(name: NSNotification.Name("needToReloadDibs"), object: [1,1])
                    NotificationCenter.default.post(name: NSNotification.Name("needToReloadConnected"), object: nil)
                default:
                    return
                }
                // here
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func dibsBtnTapped(_ sender: Any) {
        switch dibsCategory {
        case .whoILike:
            // 내가 찜한 사람 찜 취소하기
            APIService.shared.matchingRequest(1, "DISCONNECTED_DIBS", sequenceNum ?? 0) { result in
                switch result {
                case .success(_):
                    print("찜 취소하기 성공")
                    self.parentViewController?.showToastPurple(message: "찜을 취소했습니다")
                    NotificationCenter.default.post(name: NSNotification.Name("needToReloadDibs"), object: [1,1])
                    // here
                case .failure(let error):
                    print(error)
                }
            }
        case .whoLikeMe:
            // 나를 찜한 사람에서 나도 찜 하기
            APIService.shared.matchingRequest(1, "DIBS", sequenceNum ?? 0) { result in
                switch result {
                case .success(_):
                    print("찜 하기 성공")
                    self.parentViewController?.showToastPurple(message: "상대를 찜했습니다")
                    NotificationCenter.default.post(name: NSNotification.Name("needToReloadDibs"), object: [0,0])
                   // here
                case .failure(let error):
                    print(error)
                }
            }
        default:
            return
        }
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        APIService.shared.matchingRequest(1, "DISCONNECTED_DIBS", sequenceNum ?? 0) { result in
            switch result {
            case .success(_):
                print("찜 리스트에서 제거하기 성공")
                self.parentViewController?.showToastPurple(message: "상대가 리스트에서 제거됐습니다")
                NotificationCenter.default.post(name: NSNotification.Name("needToReloadDibs"), object: [0,0])
                // here
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
            dibsBtn.setAttributedTitle(nil, for: .normal)
            dibsBtn.setTitle("찜", for: .normal)
            dibsBtn.titleLabel?.textColor = .white
            dibsBtn.setImage(UIImage(named: "iconStarWhite"), for: .normal)
            deleteBtn.isHidden = false
        case .whoILike:
            dibsBtn.backgroundColor = .white
            dibsBtn.setAttributedTitle(nil, for: .normal)
            dibsBtn.setTitle("찜 해제", for: .normal)
            dibsBtn.titleLabel?.textColor = .find_Mint
            dibsBtnWidth.constant = 10
            dibsBtn.setImage(UIImage(named: "iconStarMint"), for: .normal)
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
