//
//  InterviewCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/13.
//

import UIKit

class InterviewQestionCVCell: UICollectionViewCell {
    static let idientifier = "InterviewQestionCVCell"
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
    @IBOutlet weak var answerTextView: UITextView!{
        didSet{
            answerTextView.delegate = self
            answerTextView.backgroundColor = .subGray6
            answerTextView.textContainerInset = UIEdgeInsets(top: 8, left: 32, bottom: 24, right: 32);
        }
    }
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "InterviewQestionCVCell", bundle: nil)
    }
}

extension InterviewQestionCVCell: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            countLabel.text =  "\(text.count)"
            
            if text.count > maxLength_keyword {
                // 5글자 넘어가면 자동으로 키보드 내려감
                textView.resignFirstResponder()
                countLabel.text =  "40"
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
                textView.text = String(newString)
            }
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("edit")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("finish")
        let num = Array(questionNumLabel.text ?? "999") // 질문 번호
        var n = 999 // 질문 번호 환산을 위한 값
        switch curCategory {
        case "pros": n = 0
        case "love": n = 4
        case "taste": n = 9
        case "life": n = 13
        default: return
        }
        
        if answerTextView.text?.count ?? 0 > 0 {
            interviewQuestions[((Int(String(num[2])) ?? 999)+n)-1].isEdit = true
            interviewQuestions[((Int(String(num[2])) ?? 999)+n)-1].answer = answerTextView.text
        }
        print(interviewQuestions)
    }
}
