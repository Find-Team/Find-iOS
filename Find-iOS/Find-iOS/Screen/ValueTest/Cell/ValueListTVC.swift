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
    var selectedCount = 0
    
    
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
    
    
    @IBAction func selectedBtnDidTap(_ sender: Any) {
        
    }
    
}

extension ValueListTVC {
    /// 선택된 답변일 때
    func selectedQuestion(cell: ValueListTVC) {
        cell.selectedBoxView.layer.borderWidth = 2
        cell.selectedBoxView.layer.borderColor = UIColor.find_DarkPurple.cgColor
        cell.selectedBoxView.backgroundColor = .find_Purple
        cell.selectedBoxView.makeRounded(cornerRadius: 10)
        
        cell.selectedCountLabel.isHidden = false
        cell.selectedCountLabel.text = "\(selectedCount)"
        cell.selectedCountLabel.font = .spoqaBold(size: 9)
        cell.selectedCountLabel.textColor = .subGray6
    }
    
    /// 선택되지 않은 답변일 때
    func unselectedQuestion(cell: ValueListTVC) {
        cell.selectedBoxView.layer.borderWidth = 2
        cell.selectedBoxView.layer.borderColor = UIColor.subGray1.cgColor
        cell.selectedBoxView.backgroundColor = .white
        cell.selectedBoxView.makeRounded(cornerRadius: 10)
        
        cell.selectedCountLabel.isHidden = true
    }
}
