//
//  ValueListVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/07.
//

import UIKit

enum Category {
    case relationship, family, career
}

class ValueListVC: UIViewController {
    
    //MARK: - Custom Variables
    
    var currentCategory: Category = .relationship
    
    var selectedCount: Int = 0
    
    var chosenQuestions: [Int] = []
    
    //MARK: - IBOutlets
    
    @IBOutlet var viewTitleLabel: UILabel!
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var finishBtn: UIButton!
    
    @IBOutlet var segueIndicator: [UIView]!
    @IBOutlet var segueRelationshipBtn: UIButton!
    @IBOutlet var segueFamilyBtn: UIButton!
    @IBOutlet var segueCareerBtn: UIButton!
    
    @IBOutlet var valueListCollectionView: UICollectionView!
    
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSegueStyle()
        RelationshipSelected()
        finishBtnDeactivated()
        
        valueListCollectionView.dataSource = self
        valueListCollectionView.delegate = self
    }
    
    
    //MARK: - IBActions
    
    @IBAction func backBtnDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func finishBtnDidTap(_ sender: Any) {
        
    }
    
    @IBAction func relationshipBtnDidTap(_ sender: Any) {
        RelationshipSelected()
        valueListCollectionView.reloadData()
    }
    
    @IBAction func familyBtnDidTap(_ sender: Any) {
        FamilySelected()
        valueListCollectionView.reloadData()
    }
    
    @IBAction func careerBtnDidTap(_ sender: Any) {
        CareerSelected()
        valueListCollectionView.reloadData()
    }
    
    
}

extension ValueListVC {
    
    //MARK: - Styles
    
    func finishBtnActivated() {
        finishBtn.isUserInteractionEnabled = true
        finishBtn.setTitle("완료", for: .normal)
        finishBtn.setTitleColor(.subGray3, for: .normal)
        finishBtn.titleLabel?.font = .spoqaRegular(size: 18)
    }
    
    func finishBtnDeactivated() {
        finishBtn.isUserInteractionEnabled = false
        finishBtn.setTitle("완료", for: .normal)
        finishBtn.setTitleColor(.subGray1, for: .normal)
        finishBtn.titleLabel?.font = .spoqaRegular(size: 18)
    }
    
    func setSegueStyle() {
        segueRelationshipBtn.setTitle("관계", for: .normal)
        segueRelationshipBtn.setTitleColor(.subGray2, for: .normal)
        segueRelationshipBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueFamilyBtn.setTitle("가족", for: .normal)
        segueFamilyBtn.setTitleColor(.subGray2, for: .normal)
        segueRelationshipBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueCareerBtn.setTitle("커리어", for: .normal)
        segueCareerBtn.setTitleColor(.subGray2, for: .normal)
        segueRelationshipBtn.titleLabel?.font = .spoqaRegular(size: 14)
    }
    
    /// 관계 카테고리 선택됐을 때
    func RelationshipSelected() {
        currentCategory = .relationship
        self.valueListCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .left, animated: true) /// 버튼 클릭 시 세그 이동
        
        segueIndicator[0].backgroundColor = .find_DarkPurple
        segueIndicator[1].backgroundColor = .subGray1
        segueIndicator[2].backgroundColor = .subGray1
        
        segueRelationshipBtn.setTitle("관계", for: .normal)
        segueRelationshipBtn.setTitleColor(.find_DarkPurple, for: .normal)
        segueRelationshipBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueFamilyBtn.setTitleColor(.subGray2, for: .normal)
        segueCareerBtn.setTitleColor(.subGray2, for: .normal)
    }
    
    /// 가족 카테고리 선택됐을 때
    func FamilySelected() {
        currentCategory = .family
        self.valueListCollectionView.scrollToItem(at: NSIndexPath(item: 1, section: 0) as IndexPath, at: .left, animated: true) /// 버튼 클릭 시 세그 이동
        
        segueIndicator[0].backgroundColor = .subGray1
        segueIndicator[1].backgroundColor = .find_DarkPurple
        segueIndicator[2].backgroundColor = .subGray1
        
        segueFamilyBtn.setTitle("가족", for: .normal)
        segueFamilyBtn.setTitleColor(.find_DarkPurple, for: .normal)
        segueFamilyBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueRelationshipBtn.setTitleColor(.subGray2, for: .normal)
        segueCareerBtn.setTitleColor(.subGray2, for: .normal)
    }
    
    /// 커리어 카테고리 선택됐을 때
    func CareerSelected() {
        currentCategory = .career
        self.valueListCollectionView.scrollToItem(at: NSIndexPath(item: 2, section: 0) as IndexPath, at: .left, animated: true) /// 버튼 클릭 시 세그 이동
        
        segueIndicator[0].backgroundColor = .subGray1
        segueIndicator[1].backgroundColor = .subGray1
        segueIndicator[2].backgroundColor = .find_DarkPurple
        
        segueCareerBtn.setTitle("커리어", for: .normal)
        segueCareerBtn.setTitleColor(.find_DarkPurple, for: .normal)
        segueCareerBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueRelationshipBtn.setTitleColor(.subGray2, for: .normal)
        segueFamilyBtn.setTitleColor(.subGray2, for: .normal)
    }
    
    
    
    //MARK: - functions
    
}

extension ValueListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ValueListCVC", for: indexPath) as? ValueListCVC
        else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
}

extension ValueListVC: UICollectionViewDelegateFlowLayout {
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
}
