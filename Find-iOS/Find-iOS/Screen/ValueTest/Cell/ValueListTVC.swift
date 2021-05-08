//
//  ValueListTVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/08.
//

import UIKit

class ValueListTVC: UITableViewCell {
    
    static let identifier = "ValueListTVC"
    
    @IBOutlet var questionView: UIView!
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var answerView: UIView!
    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet var selectedBtn: UIButton!
    
    @IBOutlet var dividerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dividerView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
