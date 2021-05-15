//
//  InterviewCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/13.
//

import UIKit

class InterviewCVCell: UICollectionViewCell {
    static let idientifier = "InterviewCVCell"
    var curCategory: String?
    let maxLength_keyword = 40
    
    
    @IBOutlet weak var questionView: UIView!{
        didSet{
            questionView.makeRounded(cornerRadius: 10)
            questionView.backgroundColor = .subGray6
        }
    }
    @IBOutlet weak var questionNumLabel: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!{
        didSet{
            answerTextField.delegate = self
            answerTextField.addRightPadding(x: 0, y: 0, width: 40, height: answerTextField.frame.height)
            answerTextField.backgroundColor = .subGray6
        }
    }
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addLetterCountNoti()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "InterviewCVCell", bundle: nil)
    }
    
    // 글자 수 검사 노티들 가진 함수
    func addLetterCountNoti(){
        NotificationCenter.default.addObserver(self, selector: #selector(textfieldDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    // 1. 키워드 입력 TextField 글자 수 Counting(& 복붙 검사)
    @objc private func textfieldDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                
                countLabel.text =  "\(text.count)"
                
                if text.count > maxLength_keyword {
                    // 5글자 넘어가면 자동으로 키보드 내려감
                    textField.resignFirstResponder()
                    countLabel.text =  "40/"
                    countLabel.textColor = .textLimitRed
                    maxLabel.textColor = .textLimitRed
                }else{
                    countLabel.textColor = .subGray1
                    maxLabel.textColor = .subGray1
                }
                
                // 초과되는 텍스트 제거
                if text.count >= maxLength_keyword {
                    let index = text.index(text.startIndex, offsetBy: maxLength_keyword)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                }
            }
        }
    }
}

extension InterviewCVCell: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("edit")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("finish")
        print(curCategory)
        let num = Array(questionNumLabel.text ?? "999") // 질문 번호
        var n = 999 // 질문 번호 환산을 위한 값
        switch curCategory {
        case "pros": n = 0
        case "love": n = 4
        case "taste": n = 9
        case "life": n = 13
        default: return
        }
        
        if answerTextField.text?.count ?? 0 > 0 {
            interviewQuestions[((Int(String(num[2])) ?? 999)+n)-1].isEdit = true
            interviewQuestions[((Int(String(num[2])) ?? 999)+n)-1].answer = answerTextField.text
        }
        print(interviewQuestions)
    }
    
    // Return 눌렀을 때 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
