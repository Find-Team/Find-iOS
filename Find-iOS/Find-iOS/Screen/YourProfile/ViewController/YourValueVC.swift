//
//  YourValueVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/18.
//

import UIKit

enum ValueFilterAll {
    case same, different
}
var currentSegue: ValueFilterAll = .same

class YourValueVC: UIViewController {
    
    //MARK: - custom variables
    
//    var matchingType:
    //MARK: - IBOutlets
    
    @IBOutlet var yourValueCV: UICollectionView!
    
    //MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        yourValueCV.dataSource = self
        yourValueCV.delegate = self
    }

}

extension YourValueVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 { /// 헤더
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourValueHeaderCVC", for: indexPath) as? YourValueHeaderCVC
            else {
                return UICollectionViewCell()
            }
            
            cell.backgroundColor = .white
            cell.setValueList()
            if currentSegue == .same {
                cell.sameQuestionSelected()
            } else {
                cell.differentQuestionSelected()
            }
            
            
            return cell
        }
        else if indexPath.row == 1 { /// 하단 리스트
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourValueListCVC", for: indexPath) as? YourValueListCVC
            else {
                return UICollectionViewCell()
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}

extension YourValueVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth : CGFloat = collectionView.frame.width
        let cellHeight : CGFloat = collectionView.frame.height
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
