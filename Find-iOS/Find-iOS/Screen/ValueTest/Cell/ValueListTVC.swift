//
//  ValueListTVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/08.
//

import UIKit

class ValueListTVC: UITableViewCell {
    
    //MARK: - custom variables
    
    static let identifier = "ValueListTVC"
    var selectedCount: Int = 0
    var currentIndex: Int?
    
    
    //MARK: - IBOutlets
    
    @IBOutlet var questionView: UIView!
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var answerView: UIView!
    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet var selectedBtn: UIButton!
    @IBOutlet var selectedBoxView: UIView!
    @IBOutlet var selectedCountLabel: UILabel!
    
    @IBOutlet var dividerView: UIView!
    
    
    //MARK: - lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dividerView.backgroundColor = .systemGray6
    }

    
    //MARK: - IBActions
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ValueListTVC {
    /// 선택된 답변일 때
    func selectedQuestion() {
        selectedBoxView.layer.borderWidth = 2
        selectedBoxView.layer.borderColor = UIColor.find_DarkPurple.cgColor
        selectedBoxView.backgroundColor = .find_Purple
        selectedBoxView.makeRounded(cornerRadius: 10)
        
        selectedCountLabel.isHidden = false
        selectedCountLabel.text = "\(selectedCount)"
        selectedCountLabel.font = .spoqaBold(size: 9)
        selectedCountLabel.textColor = .subGray6
    }
    
    /// 선택되지 않은 답변일 때
    func unselectedQuestion() {
        selectedBoxView.layer.borderWidth = 2
        selectedBoxView.layer.borderColor = UIColor.subGray1.cgColor
        selectedBoxView.backgroundColor = .white
        selectedBoxView.makeRounded(cornerRadius: 10)
        
        selectedCountLabel.isHidden = true
    }
}
