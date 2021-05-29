//
//  FeelingTVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

// MARK: - 받은 호감, 보낸 호감을 감싸는 틀 Cell
class FeelingTVCell: UITableViewCell {
    static let identifier = "FeelingTVCell"
    var cellCategory: feelingCell?
    var receivedData, sendData: [Connected]? // 받은 호감, 보낸 호감 데이터
    
    @IBOutlet weak var feelingCV: UICollectionView! {
        didSet {
            feelingCV.delegate = self
            feelingCV.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        feelingCV.register(FeelingCVCell.nib(), forCellWithReuseIdentifier: FeelingCVCell.identifier)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FeelingTVCell", bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        feelingCV.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        self.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
    }
}

// MARK: - Protocols
extension FeelingTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellCategory {
        case .received:
            if let receivedFeelings = receivedData {
                return receivedFeelings.count
            }
        case .send:
            if let sendedFeelings = sendData {
                return sendedFeelings.count
            }
        default:
            return 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeelingCVCell.identifier, for: indexPath) as? FeelingCVCell else { return UICollectionViewCell() }
        switch cellCategory {
        case .received:
            cell.descriptionLabel.isHidden = true
            if let receivedFeelings = receivedData {
                cell.setCell(feelingDatas: receivedFeelings[indexPath.row])
                cell.feelingCategory = .received
            }
        case .send:
            cell.acceptBtn.isHidden = true
            if let sendedFeelings = sendData {
                cell.setCell(feelingDatas: sendedFeelings[indexPath.row])
                cell.feelingCategory = .send
            }
        default:
            return UICollectionViewCell()
        }
        return cell
    }
    
    // MARK: - Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: collectionView.frame.height-47)
    }
    
    // MARK: - Cell간의 상하간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    // MARK: - 마진
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 17, left: 12, bottom: 29.5, right: 12)
    }
}
