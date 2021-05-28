//
//  InterviewAnswerTVC.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/19.
//

import UIKit

class InterviewAnswerTVC: UITableViewCell {
    
    static let identifier = "InterviewAnswerTVC"

    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInterviewData(index: Int, question: String, answer: String) {
        self.questionNumberLabel.text = "Q. \(index)"
        self.questionLabel.text = question
        self.answerTextView.text = answer
    }

}
