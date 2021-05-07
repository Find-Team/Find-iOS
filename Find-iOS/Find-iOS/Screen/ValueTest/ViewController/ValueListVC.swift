//
//  ValueListVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/07.
//

import UIKit

class ValueListVC: UIViewController {
    
    //MARK: - Custom Variables
    
    enum Category {
        case relationship, family, career
    }
    
    var currentCategory: Category = .relationship
    
    //MARK: - IBOutlets
    
    @IBOutlet var viewTitleLabel: UILabel!
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var finishBtn: UIButton!
    
    @IBOutlet var segueIndicator: [UIView]!
    @IBOutlet var segueRelationshipBtn: UIButton!
    @IBOutlet var segueFamilyBtn: UIButton!
    @IBOutlet var segueCareerBtn: UIButton!
    

    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSegueStyle()
        RelationshipSelected()
        finishBtnDeactivated()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - IBActions
    
    @IBAction func backBtnDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func finishBtnDidTap(_ sender: Any) {
        
    }
    
    @IBAction func relationshipBtnDidTap(_ sender: Any) {
        currentCategory = .relationship
    }
    
    @IBAction func familyBtnDidTap(_ sender: Any) {
        currentCategory = .family
    }
    
    @IBAction func careerBtnDidTap(_ sender: Any) {
        currentCategory = .career
    }
}

extension ValueListVC {
    
    //MARK: - Styles
    
    func finishBtnActivated() {
        finishBtn.isUserInteractionEnabled = true
        finishBtn.setTitle("완료", for: .normal)
        finishBtn.setTitleColor(.black, for: .normal)
    }
    
    func finishBtnDeactivated() {
        finishBtn.isUserInteractionEnabled = false
        finishBtn.setTitle("완료", for: .normal)
        finishBtn.setTitleColor(.gray, for: .normal)
    }
    
    func setSegueStyle() {
        segueRelationshipBtn.setTitle("관계", for: .normal)
        segueRelationshipBtn.setTitleColor(.black, for: .normal)
        
        segueFamilyBtn.setTitle("가족", for: .normal)
        segueFamilyBtn.setTitleColor(.black, for: .normal)
        
        segueCareerBtn.setTitle("커리어", for: .normal)
        segueCareerBtn.setTitleColor(.black, for: .normal)
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
}
