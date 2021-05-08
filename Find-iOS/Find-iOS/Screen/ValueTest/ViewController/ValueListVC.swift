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
    
    
    @IBOutlet var valueListTableView: UITableView!
    
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueListTableView.dataSource = self
        valueListTableView.delegate = self
        
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
        RelationshipSelected()
        valueListTableView.reloadData()
    }
    
    @IBAction func familyBtnDidTap(_ sender: Any) {
        FamilySelected()
        valueListTableView.reloadData()
    }
    
    @IBAction func careerBtnDidTap(_ sender: Any) {
        CareerSelected()
        valueListTableView.reloadData()
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
        currentCategory = .relationship
        
        segueIndicator[0].backgroundColor = .purple
        segueIndicator[1].backgroundColor = .gray
        segueIndicator[2].backgroundColor = .gray
    }
    
    /// 가족 카테고리 선택됐을 때
    func FamilySelected() {
        currentCategory = .family
        
        segueIndicator[0].backgroundColor = .gray
        segueIndicator[1].backgroundColor = .purple
        segueIndicator[2].backgroundColor = .gray
    }
    
    /// 커리어 카테고리 선택됐을 때
    func CareerSelected() {
        currentCategory = .career
        
        segueIndicator[0].backgroundColor = .gray
        segueIndicator[1].backgroundColor = .gray
        segueIndicator[2].backgroundColor = .purple
    }
    
    func answerFilled(cell: ValueListTVC, indexPath: Int) {
        cell.answerView.makeRounded(cornerRadius: 4)
        cell.answerView.backgroundColor = .white
        cell.answerView.layer.borderWidth = 1
        cell.answerView.layer.borderColor = UIColor.blue.cgColor
        
        cell.answerLabel.textColor = .blue
        
        switch currentCategory {
        case .relationship:
            cell.answerLabel.text = valueQuestions[indexPath].choice[valueQuestions[indexPath].userChoice - 1].choiceContent
        case .family:
            cell.answerLabel.text = valueQuestions[indexPath + 10].choice[valueQuestions[indexPath].userChoice - 1].choiceContent
        case .career:
            cell.answerLabel.text = valueQuestions[indexPath + 20].choice[valueQuestions[indexPath].userChoice - 1].choiceContent
        }
    }
    
    func answerUnfilled(cell: ValueListTVC) {
        cell.answerView.makeRounded(cornerRadius: 4)
        cell.answerView.backgroundColor = .lightGray
        cell.answerView.layer.borderWidth = 0
        
        cell.answerLabel.text = "아직 답변 전입니다."
        cell.answerLabel.textColor = .black
        
    }
    
    //MARK: - functions
    
    
}

extension ValueListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ValueListTVC") as? ValueListTVC
        
        else {
            return UITableViewCell()
        }
        
        /// 질문 뷰 스타일
        cell.questionView.makeRounded(cornerRadius: 4)
        cell.questionView.backgroundColor = .purple
        cell.questionLabel.textColor = .white
        
        /// 선택 카테고리에 따른 질문
        var currIndexPath: Int = 0
        
        switch currentCategory {
        case .relationship:
            currIndexPath = indexPath.row
            cell.questionLabel.text = valueQuestions[currIndexPath].question
        case .family:
            currIndexPath = indexPath.row + 10
            cell.questionLabel.text = valueQuestions[currIndexPath].question
        case .career:
            currIndexPath = indexPath.row + 20
            cell.questionLabel.text = valueQuestions[currIndexPath].question
        }
        
        /// 답변이 있을 때 / 없을 때 분기처리
        if valueQuestions[currIndexPath].userChoice != 0 {
            answerFilled(cell: cell, indexPath: currIndexPath)
        } else {
            answerUnfilled(cell: cell)
        }
        
        /// 선택이 된 답변 / 안 된 답변 분기처리
        if valueQuestions[currIndexPath].isChosen {
            cell.selectedBtn.isHidden = false
            cell.selectedBtn.isUserInteractionEnabled = true
            cell.selectedBtn.setTitle("\((chosenQuestions.firstIndex(of: valueQuestions[currIndexPath].id) ?? 0) + 1 ) / 5", for: .normal)
            cell.selectedBtn.setTitleColor(.white, for: .normal)
            cell.selectedBtn.backgroundColor = .purple
        } else {
            cell.selectedBtn.isHidden = true
            cell.selectedBtn.isUserInteractionEnabled = false
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
    }
}

extension ValueListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectAction = UIContextualAction(style: .normal, title:  valueQuestions[indexPath.row].isChosen ? "취소" : "선택", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            // Call edit action
            
            var currIndexPath = 0
            
            switch self.currentCategory {
            case .relationship:
                currIndexPath = indexPath.row
            case .family:
                currIndexPath = indexPath.row + 10
            case .career:
                currIndexPath = indexPath.row + 20
            }
            
            valueQuestions[currIndexPath].isChosen = !valueQuestions[currIndexPath].isChosen
            
            if valueQuestions[currIndexPath].isChosen {
                self.selectedCount += 1
                self.chosenQuestions.append(valueQuestions[currIndexPath].id)
                print(self.chosenQuestions)
            } else {
                self.selectedCount -= 1
                self.chosenQuestions.remove(at: self.chosenQuestions.firstIndex(of: valueQuestions[currIndexPath].id)!)
            }
            
            
            // Reset state
            
            success(true)
            tableView.reloadData()
            
        })
        
        return UISwipeActionsConfiguration(actions: [selectAction])
    }
}
