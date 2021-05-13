//
//  InterviewTVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/13.
//

import UIKit

class InterviewTVCell: UITableViewCell {
    static let idientifier = "InterviewTVCell"
    
    @IBOutlet weak var questionView: UIView!{
        didSet{
            questionView.makeRounded(cornerRadius: 10)
        }
    }
    @IBOutlet weak var questionNumLabel: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!{
        didSet{
            answerTextField.addRightPadding(x: 0, y: 0, width: 30, height: answerTextField.frame.height)
        }
    }
    @IBOutlet weak var countLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
