//
//  ValueTestVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/07.
//

import UIKit

class ValueTestVC: UIViewController {
    
    //MARK: - Custom Variables
    
    var questionIdx: Int = 1 /// 현재 문제 번호 (1-30)
    var answerCnt: Int = 0 /// 답변한 문제 개수 (0-30)
    
    
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
    @IBOutlet var questionChoiceTableView: UITableView!
    
    @IBOutlet var countLabel: UILabel!
    
    @IBOutlet var previousBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    
    
    
    //MARK: - Lifecylcle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionChoiceTableView.dataSource = self
        questionChoiceTableView.delegate = self
        
        setQuestionView()
        RelationshipSelected()
        setPreviousBtnActivated()
        setNextBtnActivated()
        
        changeQuestion()
        
    }
    
    //MARK: - IBActions
    
    /// 뒤로가기 버튼 클릭
    @IBAction func backBtnDidTap(_ sender: Any) {
        
    }
    
    /// 이전 버튼 클릭
    @IBAction func previousBtnDidTap(_ sender: Any) {
        if questionIdx != 1 {
            questionIdx -= 1
        }
        
        changeQuestion()
    }
    
    /// 다음 버튼 클릭
    @IBAction func nextBtnDidTap(_ sender: Any) {
        /// 다음 버튼 클릭 시 문제 번호 하나씩 증가
        if questionIdx != 30 {
            questionIdx += 1
        }
        
        changeQuestion()
    }
    
    
    //MARK: - @objc
    
    
}


extension ValueTestVC {
    
    //MARK: - Style
    
    /// 질문뷰 스타일
    func setQuestionView() {
        view.layoutIfNeeded()
        
        questionView.makeRounded(cornerRadius: 10)
        //        questionView.backgroundColor =
        
        //        questionSegueTitleView.backgroundColor =
        questionSegueTitleView.makeRounded(cornerRadius: questionSegueTitleView.frame.height / 2)
        
        questionChoiceTableView.backgroundColor = .white
        
        questionContentLabel.numberOfLines = 0
        questionContentLabel.textAlignment = .center
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
    
    /// 질문 번호 라벨 세팅
    func setCountLabel() {
        countLabel.text = "\(questionIdx) / 30"
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
    
    func choiceSelected(cell: ValueTestQuestionTVC) {
        cell.choiceCell.layer.borderWidth = 1
        cell.choiceCell.layer.borderColor = UIColor.purple.cgColor
        cell.choiceCell.layer.cornerRadius = 10
        cell.choiceCell.backgroundColor = .white
        cell.choiceLabel.textColor = .purple
    }
    
    func choiceUnselected(cell: ValueTestQuestionTVC) {
        cell.choiceCell.layer.borderWidth = 1
        cell.choiceCell.layer.borderColor = UIColor.gray.cgColor
        cell.choiceCell.layer.cornerRadius = 10
        cell.choiceCell.backgroundColor = .white
        cell.choiceLabel.textColor = .gray
    }
    
    //MARK: - Functions
    
    func changeQuestion() {
        
        /// 문제 번호에 따라 카테고리 활성화
        if getQuestionCategory(questionIndex: questionIdx) == "관계" {
            RelationshipSelected()
        }
        else if getQuestionCategory(questionIndex: questionIdx) == "가족" {
            FamilySelected()
        }
        else if getQuestionCategory(questionIndex: questionIdx) == "커리어" {
            CareerSelected()
        }
        
        /// 질문 박스 안 질문 카테고리 이름 최신화
        questionSegueTitleLabel.text = getQuestionCategory(questionIndex: questionIdx)
        
        /// 질문 가져오기
        questionContentLabel.text = valueQuestions[questionIdx-1].question
        
        /// 카운트 라벨 최신화
        countLabel.text = "\(questionIdx % 10 != 0 ? questionIdx % 10 : 10) / 10"
        
        /// 답변 문항 최신화
        questionChoiceTableView.reloadData()
    }
    
}

extension ValueTestVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valueQuestions[questionIdx-1].choice.count /// 2개일 수도 있고 3개일 수도 있고
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ValueTestQuestionTVC") as? ValueTestQuestionTVC

        else {
            return UITableViewCell()
        }
        
        /// 셀에 문항 내용을 넣는다
        cell.choiceLabel.text = valueQuestions[questionIdx-1].choice[indexPath.row].choiceContent
        
        cell.layoutIfNeeded()
        print(valueQuestions[questionIdx-1].userChoice, indexPath.row)
        /// 유저초이스가 무엇 하나라도 선택이 되었을 때
        if valueQuestions[questionIdx-1].userChoice != 0 {
            if valueQuestions[questionIdx-1].userChoice - 1 == indexPath.row {
                choiceSelected(cell: cell)
            } else {
                choiceUnselected(cell: cell)
            }
        } else {
            choiceUnselected(cell: cell)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        /// 선택된 문항을 유저초이스에 저장
        valueQuestions[questionIdx-1].userChoice = indexPath.row + 1
        
        self.questionChoiceTableView.reloadData()
    }
    
    
}

extension ValueTestVC: UITableViewDelegate {
    
}
