//
//  ValueTestVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/07.
//

import UIKit

class ValueTestVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet var viewTitleLabel: UILabel!
    @IBOutlet var backBtn: UIButton!
    
    @IBOutlet var segueIndicator: [UIView]!
    @IBOutlet var segueRelationshipLabel: UILabel!
    @IBOutlet var segueFamilyLabel: UILabel!
    @IBOutlet var segueCareerLabel: UILabel!
    
    @IBOutlet var questionView: UIView!
    @IBOutlet var questionSegueTitleView: UIView!
    @IBOutlet var questionSegueTitleLabel: UILabel!
    @IBOutlet var questionContentLabel: UILabel!
    //    @IBOutlet var questionChoiceView: UIView!
    //    @IBOutlet var questionChoiceLabel: [UIView]!
    @IBOutlet var questionChoiceCV: UICollectionView!
    
    
    
    @IBOutlet var previousBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    
    
    
    //MARK: - Lifecylcle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionChoiceCV.dataSource = self
        questionChoiceCV.delegate = self
        
        setQuestionView()
        RelationshipSelected()
        setPreviousBtnActivated()
        setNextBtnActivated()
        
    }
    
    //MARL: - IBActions
}


extension ValueTestVC {
    
    //MARK: - Style
    
    /// 질문뷰 스타일
    func setQuestionView() {
        view.layoutIfNeeded()
        
        questionView.makeRounded(cornerRadius: 10)
        //        questionView.backgroundColor =
        
        //        questionSegueTitleView.backgroundColor =
        questionView.makeRounded(cornerRadius: questionView.frame.height / 2)
    }
    
    /// 관계 카테고리 선택됐을 때
    func RelationshipSelected() {
        segueIndicator[0].backgroundColor = .purple
        segueIndicator[1].backgroundColor = .gray
        segueIndicator[2].backgroundColor = .gray
        
    }
    
    /// 가족 카테고리 선택됐을 때
    func FamilySelected() {
        segueIndicator[0].backgroundColor = .gray
        segueIndicator[1].backgroundColor = .purple
        segueIndicator[2].backgroundColor = .gray
    }
    
    /// 커리어 카테고리 선택됐을 때
    func CareerSelected() {
        segueIndicator[0].backgroundColor = .gray
        segueIndicator[1].backgroundColor = .gray
        segueIndicator[2].backgroundColor = .purple
    }
    
    /// 이전 버튼 활성화 됐을 때
    func setPreviousBtnActivated() {
        previousBtn.setTitle("이전", for: .normal)
        previousBtn.titleLabel?.textColor = .black
        previousBtn.makeRounded(cornerRadius: 10)
        previousBtn.backgroundColor = .white
    }
    
    /// 이전 버튼 비활성화 됐을 때
    func setPreviousBtnDeactivated() {
        previousBtn.setTitle("이전", for: .normal)
        previousBtn.titleLabel?.textColor = .white
        previousBtn.makeRounded(cornerRadius: 10)
        previousBtn.backgroundColor = .lightGray
    }
    
    /// 다음 버튼 활성화 됐을 때
    func setNextBtnActivated() {
        nextBtn.setTitle("다음", for: .normal)
        nextBtn.titleLabel?.textColor = .black
        nextBtn.makeRounded(cornerRadius: 10)
        nextBtn.backgroundColor = .white
    }
    
    /// 다음 버튼 비활성화 됐을 때
    func setNextBtnDeactivated() {
        nextBtn.setTitle("다음", for: .normal)
        nextBtn.titleLabel?.textColor = .white
        nextBtn.makeRounded(cornerRadius: 10)
        nextBtn.backgroundColor = .lightGray
    }
    
    //MARK: - Functions
    
    
    
    
}


//MARK: - UICollectionViewDataSource
extension ValueTestVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ValueTestQuestionCVC.identifier, for: indexPath) as? ValueTestQuestionCVC
        else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ValueTestVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
