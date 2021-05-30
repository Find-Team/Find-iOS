//
//  YourValueVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/18.
//

import UIKit

class YourValueVC: UIViewController {
    
    //MARK: - custom variables
    
    var scrollOffset: CGFloat = 0
    
    var sameQuestionCount: Int = 10
    var differentQustionCount: Int = 10
    
    var currentSegue: ValueFilterAll = .same
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(segueChanged(_:)), name: NSNotification.Name("SegueChangedbyScroll"), object: nil)
    }
    
    //MARK: - IBActions
    
    @IBAction func sameQuestionBtnDidTap(_ sender: Any) {
        sameQuestionSelected()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SegueChanged"), object: currentSegue)
    }
    
    @IBAction func differentQuestionBtnDidTap(_ sender: Any) {
        differentQuestionSelected()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SegueChanged"), object: currentSegue)
    }
    
}

extension YourValueVC {
    func sameQuestionSelected() {
        currentSegue = .same
        
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
        
        segueIndicator[0].backgroundColor = .subGray1
        segueIndicator[1].backgroundColor = .find_DarkPurple

        
        differentQuestionBtn.setTitle("다른 답변", for: .normal)
        differentQuestionBtn.setTitleColor(.find_DarkPurple, for: .normal)
        differentQuestionBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        sameQuestionBtn.setTitle("같은 답변", for: .normal)
        sameQuestionBtn.titleLabel?.font = .spoqaRegular(size: 14)
        sameQuestionBtn.setTitleColor(.subGray2, for: .normal)
    }
    
    @objc func segueChanged(_ noti: Notification) {
        currentSegue = noti.object as! ValueFilterAll
        
        print("scroll noti received")
        
        if currentSegue == .same {
            sameQuestionSelected()
        } else {
            differentQuestionSelected()
        }
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
                height = Float(sameQuestions.count) * 113.5 + 43 * 3
            } else {
                height = Float(differentQuestions.count) * 113.5 + 43 * 3
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
