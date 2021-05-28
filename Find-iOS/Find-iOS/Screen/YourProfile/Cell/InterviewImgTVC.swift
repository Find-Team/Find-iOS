//
//  InterviewImgTVC.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/19.
//

import UIKit

class InterviewImgTVC: UITableViewCell {
    
    static let identifier = "InterviewImgTVC"
    
    var segueIndex: Int = -1
    
    var prosImgList: [UIImage] = []
    var loveImgList: [UIImage] = []
    var tasteImgList: [UIImage] = []
    var lifeImgList: [UIImage] = []

    @IBOutlet weak var interviewImgCVC: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setProsImgList()
        setLoveImgList()
        setTasteImgList()
        setLifeImgList()
        interviewImgCVC.dataSource = self
        interviewImgCVC.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setProsImgList() {
        prosImgList.append(UIImage(named: "장점1")!)
        prosImgList.append(UIImage(named: "장점2")!)
    }
    
    func setLoveImgList() {
        loveImgList.append(UIImage(named: "연애2")!)
    }
    
    func setTasteImgList() {
        tasteImgList.append(UIImage(named: "호불호")!)
    }
    
    func setLifeImgList() {
        lifeImgList.append(UIImage(named: "라이프1")!)
        lifeImgList.append(UIImage(named: "라이프2")!)
    }

}

extension InterviewImgTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segueIndex {
        case 0: return prosImgList.count
        case 1: return loveImgList.count
        case 2: return tasteImgList.count
        case 3: return lifeImgList.count
        default: return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterviewImgCVCell.identifier, for: indexPath) as? InterviewImgCVCell else { return UICollectionViewCell() }
        cell.myContentView.makeRounded(cornerRadius: 10)
        switch segueIndex {
        case 0: cell.interviewImgView.image = prosImgList[indexPath.row]
        case 1: cell.interviewImgView.image = loveImgList[indexPath.row]
        case 2: cell.interviewImgView.image = tasteImgList[indexPath.row]
        case 3: cell.interviewImgView.image = lifeImgList[indexPath.row]
        default: break
        }
        return cell
    }
}

extension InterviewImgTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
    }
}


