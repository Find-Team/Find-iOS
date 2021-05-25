//
//  ValueListCVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/16.
//

import UIKit

var chosenQuestions: [Int] = []

class ValueListCVC: UICollectionViewCell {
    
    //MARK: - Custom Variables
    
    static let identifier = "ValueListCVC"
    var currentCategory: Category = .relationship
    var parentVC: ParentVC = .valueList
    var currentSegue: ValueFilterAll = .same
    
    //MARK: - IBOutlets
    
    @IBOutlet var valueListTableView: UITableView!
    
    
    //MARK: - Lifecycle Methods
    override func awakeFromNib() {
        valueListTableView.dataSource = self
        valueListTableView.delegate = self
        valueListTableView.sectionHeaderHeight = 43
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueListTableView.reloadData()
    }
}

extension ValueListCVC {
    @objc func selectBtnDidTap(_ sender: UIButton) {
        
        var currIndexPath = 0
        
        switch self.currentCategory {
        case .relationship:
            currIndexPath = sender.tag
        case .family:
            currIndexPath = sender.tag + 10
        case .career:
            currIndexPath = sender.tag + 20
        }
        
        if valueQuestions[currIndexPath].userChoice == 0 { /// 답변이 안 된 질문이면
            self.parentViewController?.showToastGray(message: "답변을 하지 않아 선택이 불가합니다")
        } else { /// 답변을 한 문항이면
            if chosenQuestions.count >= 5 { /// 이미 5개가 선택된 상황이면
                if valueQuestions[currIndexPath].isChosen { /// 선택 했던 걸 선택하면
                    /// 선택 취소
                    valueQuestions[currIndexPath].isChosen = !valueQuestions[currIndexPath].isChosen
                    chosenQuestions.remove(at: chosenQuestions.firstIndex(of: valueQuestions[currIndexPath].id)!)
                    
                    /// 5개에서 4개가 됐을 때 노티 보내기
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FinishBtnStateChanged"), object: false)
                    
                } else { /// 새로운 걸 선택하면
                    self.parentViewController?.showToastGray(message: "최대 5개까지 선택이 가능합니다")
                }

            } else { /// 아직 5개가 안 됐으면
                valueQuestions[currIndexPath].isChosen = !valueQuestions[currIndexPath].isChosen
                
                if valueQuestions[currIndexPath].isChosen { /// 새로 선택된 거면
                    chosenQuestions.append(valueQuestions[currIndexPath].id)
                } else { /// 선택 해제된 거면
                    chosenQuestions.remove(at: chosenQuestions.firstIndex(of: valueQuestions[currIndexPath].id)!)
                }
                
                /// 5개가 다 찼을 때 노티 보내기
                if chosenQuestions.count == 5 {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FinishBtnStateChanged"), object: true)
                }
            }
        }
        
        valueListTableView.reloadData()
    }
    
    /// 답변이 있는 질문 답변 뷰 생성
    func answerFilled(cell: ValueListTVC, indexPath: Int) {
        cell.answerView.makeRounded(cornerRadius: 16.5)
        cell.answerView.backgroundColor = .white
        cell.answerView.layer.borderWidth = 1
        cell.answerView.layer.borderColor = UIColor.find_DarkPurple.cgColor
        
        cell.answerLabel.textColor = .find_DarkPurple
        cell.answerLabel.text = valueQuestions[indexPath].choice[valueQuestions[indexPath].userChoice - 1].choiceContent
    }
    
    /// 답변이 없는 질문  답변 뷰 생성
    func answerUnfilled(cell: ValueListTVC) {
        cell.answerView.makeRounded(cornerRadius: 16.5)
        cell.answerView.backgroundColor = .white
        cell.answerView.layer.borderWidth = 1
        cell.answerView.layer.borderColor = UIColor.subGray2.cgColor
        
        cell.answerLabel.text = "아직 답변을 안 했어요!"
        cell.answerLabel.textColor = .subGray2
        cell.answerLabel.font = .spoqaRegular(size: 12)
        
    }
    
    /// 선택된 답변일 때
    func selectedQuestion(cell: ValueListTVC, currIndexPath: Int) {
        cell.selectedBoxView.layer.borderWidth = 2
        cell.selectedBoxView.layer.borderColor = UIColor.find_DarkPurple.cgColor
        cell.selectedBoxView.backgroundColor = .find_Purple
        cell.selectedBoxView.makeRounded(cornerRadius: 10)
        
        cell.selectedCountLabel.isHidden = false
        cell.selectedCountLabel.font = .spoqaBold(size: 9)
        cell.selectedCountLabel.textColor = .subGray6
        
        cell.selectedCountLabel.text = "\((chosenQuestions.firstIndex(of: valueQuestions[currIndexPath].id) ?? 0) + 1 )"
    }
    
    /// 선택되지 않은 답변일 때
    func unselectedQuestion(cell: ValueListTVC) {
        cell.selectedBoxView.layer.borderWidth = 2
        cell.selectedBoxView.layer.borderColor = UIColor.subGray1.cgColor
        cell.selectedBoxView.backgroundColor = .white
        cell.selectedBoxView.makeRounded(cornerRadius: 10)
        
        cell.selectedCountLabel.isHidden = true
    }
    
//    @objc func segueChanged(_ noti: Notification) {
//        currentSegue = noti.object as! ValueFilterAll
//
//        if currentSegue == .same {
//
//        } else {
//
//        }
//    }
}

extension ValueListCVC: UITableViewDataSource {
    
    /// 섹션 개수
    public func numberOfSections(in tableView: UITableView) -> Int {
        if parentVC == .valueList {
            return 1
        } else {
            return 3
        }
    }
    
    /// 각 섹션 별 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if parentVC == .valueList {
            return 10
        } else {
            if section == 1 {
                return 0
            }
            return 4 // 여기 숫자 바꾸기 (해당 카테고리 같은/다른 문항 개수)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ValueListTVC") as? ValueListTVC
        
        else {
            return UITableViewCell()
        }
        
        /// 상대 가치관 문답 보기에서 넘어왔을 때는 버튼 제거
        if parentVC == .yourValue {
            cell.selectedBtn.isHidden = true
            cell.selectedBoxView.isHidden = true
            cell.parentVC = .yourValue
        } else {
            cell.selectedBtn.isHidden = false
            cell.selectedBoxView.isHidden = false
            cell.parentVC = .valueList
        }
        
        /// 질문 뷰 스타일
        cell.questionNumberLabel.text = "Q \(indexPath.row + 1)"
        cell.questionNumberLabel.font = .spoqaRegular(size: 16)
        cell.questionNumberLabel.textColor = .subGray3
        
        cell.questionLabel.font = .spoqaRegular(size: 13)
        cell.questionLabel.textColor = .subGray3
        
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
            selectedQuestion(cell: cell, currIndexPath: currIndexPath)
        } else {
            unselectedQuestion(cell: cell)
        }
        
        cell.selectedBtn.tag = indexPath.row
        cell.selectedBtn.addTarget(self, action: #selector(selectBtnDidTap), for: .touchUpInside)
        
        return cell
    }
}

extension ValueListCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var currIndexPath: Int = 0
        
        switch currentCategory {
        case .relationship:
            currIndexPath = indexPath.row
        case .family:
            currIndexPath = indexPath.row + 10
        case .career:
            currIndexPath = indexPath.row + 20
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "QuestionSelected"), object: currIndexPath + 1)
        
        tableView.parentViewController?.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 43)) //set these values as necessary
        returnedView.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 20, y: 17, width: 33, height: 15))
        
        label.text = ["관계", "가족", "커리어"][section]
        label.font = .spoqaRegular(size: 12)
        label.textColor = .subGray2
        label.letterSpacing = -0.36
        
        returnedView.addSubview(label)
        
        return returnedView
    }
}
