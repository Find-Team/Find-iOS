//
//  YourValueHeaderCVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/22.
//

import UIKit

class YourValueHeaderCVC: UICollectionViewCell {
    
    //MARK: - custom variables
    static let identifier = "YourValueHeaderCVC"
    
    
    //MARK: - IBOutlets
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var dismissBtn: UIButton!
    @IBOutlet var headerSubTitleLabel: UILabel!
    @IBOutlet var headerTitleLabel: UILabel!
    
    @IBOutlet var filterTitleLabel: UILabel!
    @IBOutlet var filterDescriptionLabel: UILabel!
    @IBOutlet var filterCountLabel: UILabel!
    @IBOutlet var filterQuestionView: [UIView]!
    @IBOutlet var filterQuestionLabel: [UILabel]!
    
    @IBOutlet var valueQnATitleLabel: UILabel!
    @IBOutlet var valueQnADescriptionLabel: UILabel!
    
    //MARK: - Lifecycle Methods
    
    override class func awakeFromNib() {
        
    }
    
    //MARK: - IBActions
    
    
    
}

extension YourValueHeaderCVC {
    //MARK: - Styles
    func setBanner() {
        
    }
    
    //MARK: - Functions
    
    
}
