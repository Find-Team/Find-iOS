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
    var parentVC: ParentVC = .valueList
    
    
    //MARK: - IBOutlets
    

    @IBOutlet var questionNumberLabel: UILabel!
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
    
}
