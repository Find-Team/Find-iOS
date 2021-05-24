//
//  YourValueListCVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/22.
//

import UIKit

class YourValueListCVC: UICollectionViewCell {
    static let identifier = "YourValueListCVC"
    
    @IBOutlet var segueCV: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        segueCV.delegate = self
        segueCV.dataSource = self
    }
    
    override func prepareForReuse() {
        
    }
    
}

extension YourValueListCVC {
    func sameQuestionSelected() {
        
    }
    
    func differentQuestionSelected() {
        
    }
}

extension YourValueListCVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ValueListCVC", for: indexPath) as? ValueListCVC
        else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

extension YourValueListCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /// 왼쪽 or 오른쪽으로 스와이프 하면
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        
        switch currentIndex {
        case 0:
            sameQuestionSelected()
        case 1:
            differentQuestionSelected()
        default:
            break
        }
        
        segueCV.reloadData()
    }
}
