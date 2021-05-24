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
    
    var scrollOffset: CGFloat = 0
    
    var sameQuestionCount: Int = 10
    var differentQustionCount: Int = 10
    
//    var matchingType:
    //MARK: - IBOutlets
    
    @IBOutlet var segueOnTopView: UIView!
    @IBOutlet var segueIndicator: [UIView]!
    @IBOutlet var sameQuestionBtn: UIButton!
    @IBOutlet var differentQuestionBtn: UIButton!
    
    @IBOutlet var yourValueCV: UICollectionView!
    
    //MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        yourValueCV.dataSource = self
        yourValueCV.delegate = self
        
        segueOnTopView.isHidden = true
        
        sameQuestionSelected()
    }

}

extension YourValueVC {
    func sameQuestionSelected() {
        currentSegue = .same
//        self.valueListCollectionView.scrollToItem(at: NSIndexPath(item: 1, section: 0) as IndexPath, at: .left, animated: true) /// 버튼 클릭 시 세그 이동
        
        segueIndicator[0].backgroundColor = .find_DarkPurple
        segueIndicator[1].backgroundColor = .subGray1

        
        sameQuestionBtn.setTitle("같은 답변", for: .normal)
        sameQuestionBtn.setTitleColor(.find_DarkPurple, for: .normal)
        sameQuestionBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        differentQuestionBtn.setTitle("다른 답변", for: .normal)
        differentQuestionBtn.titleLabel?.font = .spoqaRegular(size: 14)
        differentQuestionBtn.setTitleColor(.subGray2, for: .normal)
    }
    
    func differentQuestionSelected() {
        currentSegue = .different
//        self.valueListCollectionView.scrollToItem(at: NSIndexPath(item: 1, section: 0) as IndexPath, at: .left, animated: true) /// 버튼 클릭 시 세그 이동
        
        segueIndicator[0].backgroundColor = .subGray1
        segueIndicator[1].backgroundColor = .find_DarkPurple

        
        differentQuestionBtn.setTitle("다른 답변", for: .normal)
        differentQuestionBtn.setTitleColor(.find_DarkPurple, for: .normal)
        differentQuestionBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        sameQuestionBtn.setTitle("같은 답변", for: .normal)
        sameQuestionBtn.titleLabel?.font = .spoqaRegular(size: 14)
        sameQuestionBtn.setTitleColor(.subGray2, for: .normal)
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
        
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width, height: 595)
        }
        else if indexPath.row == 1 {
            var height: Float = 0
            if currentSegue == .same {
                height = Float(sameQuestionCount) * 113.5
            } else {
                height = Float(differentQustionCount) * 113.5
            }
            
            return CGSize(width: collectionView.frame.width, height: CGFloat(height))
        }
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset >= 521 {
            segueOnTopView.isHidden = false
        } else {
            segueOnTopView.isHidden = true
        }
    }
}
