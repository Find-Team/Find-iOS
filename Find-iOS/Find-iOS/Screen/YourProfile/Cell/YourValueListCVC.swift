//
//  YourValueListCVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/22.
//

import UIKit

class YourValueListCVC: UICollectionViewCell {
    static let identifier = "YourValueListCVC"
    var currentSegue: ValueFilterAll = .same
    
    @IBOutlet var segueCV: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        segueCV.delegate = self
        segueCV.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(segueChanged(_:)), name: NSNotification.Name("SegueChanged"), object: nil)
    }
    
    override func prepareForReuse() {
        
    }
    
}

extension YourValueListCVC {
    func sameQuestionSelected() {
        print("same")
        currentSegue = .same
        self.segueCV.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .left, animated: true) /// 버튼 클릭 시 세그 이동
    }
    
    func differentQuestionSelected() {
        print("different")
        currentSegue = .different
        self.segueCV.scrollToItem(at: NSIndexPath(item: 1, section: 0) as IndexPath, at: .left, animated: true) /// 버튼 클릭 시 세그 이동
    }
    
    @objc func segueChanged(_ noti: Notification) {
        currentSegue = noti.object as! ValueFilterAll
        
        if currentSegue == .same {
            sameQuestionSelected()
        } else {
            differentQuestionSelected()
        }
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
        
        if indexPath.row == 0 {
            cell.CVCIndexPath = 0
        } else {
            cell.CVCIndexPath = 1
        }
        
        cell.parentVC = .yourValue
        
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
        print(">> \(currentIndex) \(currentSegue)")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SegueChangedbyScroll"), object: currentSegue)
//        segueCV.reloadData()
    }
}
