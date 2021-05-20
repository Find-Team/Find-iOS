//
//  ValueTestQuestionTVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/07.
//

import UIKit

class ValueTestQuestionTVC: UITableViewCell {
    
    static let identifier = "ValueTestQuestionCVC"
    
    @IBOutlet var choiceCell: UIView!
    @IBOutlet var choiceLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
