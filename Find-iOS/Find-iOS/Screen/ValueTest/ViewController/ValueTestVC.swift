//
//  ValueTestVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/07.
//

import UIKit

class ValueTestVC: UIViewController, UICollectionViewDelegate {
    
    //MARK: - Custom Variables
    
    var questionIdx: Int = 1 /// 현재 문제 번호 (1-30)
    var answerCnt: Int = 0 /// 답변한 문제 개수 (0-30)
    
    var dvc = ValueListVC()
    var visitedFlag: Bool = false
    
    
    //MARK: - IBOutlets
    
    @IBOutlet var viewTitleLabel: UILabel!
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var finishBtn: UIButton!
    
    @IBOutlet var segueIndicator: [UIView]!
    @IBOutlet var segueRelationshipBtn: UIButton!
    @IBOutlet var segueFamilyBtn: UIButton!
    @IBOutlet var segueCareerBtn: UIButton!
    
    @IBOutlet var questionView: UIView!
    @IBOutlet var questionSegueTitleView: UIView!
    @IBOutlet var questionSegueTitleLabel: UILabel!
    @IBOutlet var questionContentLabel: UILabel!

    @IBOutlet var questionChoiceTableView: UITableView!
    
    @IBOutlet var questionFinishView: UIView!
    @IBOutlet var questionFinishLabel: UILabel!
    @IBOutlet var questionFinishBtn: UIButton!
    
    @IBOutlet var countLabel: UILabel!
    
    @IBOutlet var previousBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    
    
    
    //MARK: - Lifecylcle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        questionChoiceTableView.dataSource = self
        questionChoiceTableView.delegate = self
        
        setUpperBar()
        setSegueStyle()
        setQuestionViewStyle()
        RelationshipSelected()
        setPreviousBtnActivated()
        setNextBtnActivated()
        answerNotDone()
        
        countAnswers()
        
        changeQuestion()
        
        NotificationCenter.default.addObserver(self, selector: #selector(questionSelected(_:)), name: NSNotification.Name("QuestionSelected"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        changeQuestion()
    }
    
    //MARK: - IBActions
    
    /// 뒤로가기 버튼 클릭
    @IBAction func backBtnDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func finishBtnDidTap(_ sender: Any) {
        if !visitedFlag {
            let nextStoryboard = UIStoryboard(name: "ValueList", bundle: nil)
            dvc = (nextStoryboard.instantiateViewController(identifier: "ValueListVC") as? ValueListVC)!
            
            visitedFlag = true
        }
        
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    @IBAction func relationshipBtnDidTap(_ sender: Any) {
        questionIdx = 1
        changeQuestion()
    }
    
    @IBAction func familyBtnDidTap(_ sender: Any) {
        questionIdx = 11
        changeQuestion()
    }
    
    @IBAction func careerBtnDidTap(_ sender: Any) {
        questionIdx = 21
        changeQuestion()
    }
    
    
    /// 이전 버튼 클릭
    @IBAction func previousBtnDidTap(_ sender: Any) {
        /// 문항이 관계-1번일 때는 액션 없음
        if questionIdx != 1 {
            questionIdx -= 1
        }
        
        changeQuestion()
    }
    
    /// 다음 버튼 클릭
    @IBAction func nextBtnDidTap(_ sender: Any) {
        /// 다음 버튼 클릭 시 문제 번호 하나씩 증가
        if questionIdx != 30 { /// 단 30번째 문제 빼고
            questionIdx += 1
        } else {
//            if answerCnt >= 5 { /// 30번 문항에서 다음 뷰를 띄울지 검사
//                answerDone()
//            } else {
//                answerNotDone()
//            }
            answerNotDone()
        }
        
        changeQuestion()
    }
    
    
    //MARK: - @objc
    
    
}


extension ValueTestVC {
    
    //MARK: - Style
    
    func finishBtnActivated() {
        finishBtn.isUserInteractionEnabled = true
        finishBtn.setTitle("완료", for: .normal)
        finishBtn.setTitleColor(.black, for: .normal)
        finishBtn.titleLabel?.font = .spoqaMedium(size: 18)
    }
    
    func finishBtnDeactivated() {
        finishBtn.isUserInteractionEnabled = false
        finishBtn.setTitle("완료", for: .normal)
        finishBtn.setTitleColor(.gray, for: .normal)
        finishBtn.titleLabel?.font = .spoqaMedium(size: 18)
    }
    
    func setUpperBar() {
//        backBtn.image(for: .normal) =
        
        viewTitleLabel.textColor = .subGray3
        viewTitleLabel.font = .spoqaMedium(size: 18)
        
        if answerCnt >= 5 {
            finishBtnActivated()
        } else {
            finishBtnDeactivated()
        }
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
    
    /// 질문뷰 스타일
    func setQuestionViewStyle() {
        view.layoutIfNeeded()
        
        questionView.makeRounded(cornerRadius: 10)
        questionView.backgroundColor = .white
        
        questionSegueTitleView.backgroundColor = .find_LightPurple
        questionSegueTitleView.makeRounded(cornerRadius: questionSegueTitleView.frame.height / 2)
        
        questionSegueTitleLabel.textColor = .subGray3
        questionSegueTitleLabel.font = .spoqaRegular(size: 14)
        
        questionChoiceTableView.backgroundColor = .white
        
        questionContentLabel.numberOfLines = 0
        questionContentLabel.textAlignment = .left
        questionContentLabel.font = .spoqaRegular(size: 18)
        
        countLabel.textColor = .subGray3
        countLabel.font = .spoqaRegular(size: 12)
    }
    
    func setQuestionFinishViewStyle() {
        questionFinishView.makeRounded(cornerRadius: 10)
        
        questionFinishLabel.text = "가치관 문답 완료 !\n완료 버튼을 눌러\n가치관 필터를 설정하세요"
        questionFinishLabel.numberOfLines = 3
        questionFinishLabel.textColor = .purple
        
        questionFinishBtn.makeRounded(cornerRadius: questionFinishBtn.frame.height/2)
        questionFinishBtn.backgroundColor = .purple
        questionFinishBtn.setTitle("가치관 필터 설정하기", for: .normal)
        questionFinishBtn.setTitleColor(.white, for: .normal)
    }
    
    /// 관계 카테고리 선택됐을 때
    func RelationshipSelected() {
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
        segueIndicator[0].backgroundColor = .subGray1
        segueIndicator[1].backgroundColor = .subGray1
        segueIndicator[2].backgroundColor = .find_DarkPurple
        
        segueCareerBtn.setTitle("커리어", for: .normal)
        segueCareerBtn.setTitleColor(.find_DarkPurple, for: .normal)
        segueCareerBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueRelationshipBtn.setTitleColor(.subGray2, for: .normal)
        segueFamilyBtn.setTitleColor(.subGray2, for: .normal)
    }
    
    /// 질문 번호 라벨 세팅
    func setCountLabel() {
        countLabel.text = "\(questionIdx) / 30"
    }
    
    /// 이전 버튼 활성화 됐을 때
    func setPreviousBtnActivated() {
        previousBtn.isUserInteractionEnabled = true
        previousBtn.setTitle("이전", for: .normal)
        previousBtn.setTitleColor(.subGray3, for: .normal)
        previousBtn.titleLabel?.font = .spoqaRegular(size: 14)
        previousBtn.makeRounded(cornerRadius: 10)
        previousBtn.backgroundColor = .white
    }
    
    /// 이전 버튼 비활성화 됐을 때
    func setPreviousBtnDeactivated() {
        previousBtn.isUserInteractionEnabled = false
        previousBtn.setTitle("이전", for: .normal)
        previousBtn.setTitleColor(.subGray1, for: .normal)
        previousBtn.titleLabel?.font = .spoqaRegular(size: 14)
        previousBtn.makeRounded(cornerRadius: 10)
        previousBtn.backgroundColor = .subGray4
    }
    
    /// 다음 버튼 활성화 됐을 때
    func setNextBtnActivated() {
        nextBtn.isUserInteractionEnabled = true
        nextBtn.setTitle("다음", for: .normal)
        nextBtn.setTitleColor(.subGray3, for: .normal)
        nextBtn.titleLabel?.font = .spoqaRegular(size: 14)
        nextBtn.makeRounded(cornerRadius: 10)
        nextBtn.backgroundColor = .white
    }
    
    /// 다음 버튼 비활성화 됐을 때
    func setNextBtnDeactivated() {
        nextBtn.isUserInteractionEnabled = false
        nextBtn.setTitle("다음", for: .normal)
        nextBtn.setTitleColor(.subGray1, for: .normal)
        nextBtn.titleLabel?.font = .spoqaRegular(size: 14)
        nextBtn.makeRounded(cornerRadius: 10)
        nextBtn.backgroundColor = .subGray4
    }
    
    /// 선택된 답변
    func choiceSelected(cell: ValueTestQuestionTVC) {
        cell.choiceCell.layer.borderWidth = 1
        cell.choiceCell.layer.borderColor = UIColor.find_DarkPurple.cgColor
        cell.choiceCell.layer.cornerRadius = cell.choiceCell.frame.height / 2
        cell.choiceCell.backgroundColor = .white
        cell.choiceLabel.textColor = .find_DarkPurple
        cell.choiceLabel.font = .spoqaRegular(size: 14)
    }
    
    /// 선택되지 않은 답변
    func choiceUnselected(cell: ValueTestQuestionTVC) {
        cell.choiceCell.layer.borderWidth = 1
        cell.choiceCell.layer.borderColor = UIColor.subGray2.cgColor
        cell.choiceCell.layer.cornerRadius = cell.choiceCell.frame.height / 2
        cell.choiceCell.backgroundColor = .white
        cell.choiceLabel.textColor = .subGray5
        cell.choiceLabel.font = .spoqaRegular(size: 14)
    }
    
    func answerDone() {
        questionFinishView.isHidden = false
        previousBtn.isHidden = true
        nextBtn.isHidden = true
    }
    
    func answerNotDone() {
        questionFinishView.isHidden = true
        previousBtn.isHidden = false
        nextBtn.isHidden = false
    }
    
    //MARK: - Functions
    
    func changeQuestion() {
        
        if answerCnt >= 5 { /// 5개 이상 답했으면
            finishBtnActivated() /// 완료 버튼 활성화
        } else { /// 5개를 답하지 않았으면
            finishBtnDeactivated() /// 완료 버튼 비활성화
        }
        
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
        
        if questionIdx == 1 { /// 첫번째 질문이면
            setPreviousBtnDeactivated()
        } else if questionIdx == 30 && answerCnt < 5 { /// 마지막 질문인데 최소 5개를 답하지 않았으면
            setNextBtnDeactivated()
        } else {
            setPreviousBtnActivated()
            setNextBtnActivated()
        }
    }
    
    /// 리스트 뷰에서 문항 클릭해 넘어왔을 때 문항 번호 받는 노티
    @objc func questionSelected(_ noti: Notification) {
        print("noti received")
        questionIdx = noti.object as! Int
        viewWillAppear(true)
    }
    
    /// 뷰 진입 시점에서의 답변 개수 카운트
    func countAnswers() {
        for i in 0...valueQuestions.count - 1 {
            if valueQuestions[i].userChoice != 0 {
                answerCnt += 1
            }
        }
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
        
        /// 셀 선택될 때 색 변하는 것 제거
        cell.selectionStyle = .none
        
        /// 셀에 문항 내용을 넣는다
        cell.choiceLabel.text = valueQuestions[questionIdx-1].choice[indexPath.row].choiceContent
        
        cell.layoutIfNeeded()

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
        if valueQuestions[questionIdx-1].userChoice == 0 {
            answerCnt += 1 /// 원래 선택이 되어 있지 않았던 거라면 답변 개수 하나 증가
        }
        valueQuestions[questionIdx-1].userChoice = indexPath.row + 1
        
        /// 다음 버튼을 클릭하지 않았어도 5번째 답을 선택하면 완료 버튼 활성화
        if answerCnt == 5 {
            finishBtnActivated()
        }
        
        self.questionChoiceTableView.reloadData()
    }
    
    
}

extension ValueTestVC: UITableViewDelegate {
    
}
