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
    
    var nickname: String = "다나"
    var sameValueCount: Int = 0
    
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
    
    @IBAction func dismissBtnDidTap(_ sender: Any) {
        self.parentViewController?.dismiss(animated: true)
    }
    
}

extension YourValueHeaderCVC {
    //MARK: - Styles
    func setBanner() {
        headerSubTitleLabel.text = "당신과 다르기에 더욱 매력적인"
        headerSubTitleLabel.textColor = .subGray6
        headerSubTitleLabel.font = .spoqaLight(size: 14)
        headerSubTitleLabel.letterSpacing = -0.42
        
        headerTitleLabel.text = "\(nickname) 님의 가치관 문답"
        headerTitleLabel.textColor = .subGray6
        headerTitleLabel.font = .spoqaRegular(size: 22)
        headerTitleLabel.letterSpacing = -0.88
        
        /// 닉네임만 볼드 처리
        let attributedStr = NSMutableAttributedString(string: headerTitleLabel.text!)
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String),
                                   value: UIFont.spoqaBold(size: 22), range: (headerTitleLabel.text! as NSString).range(of: nickname))
        headerTitleLabel.attributedText = attributedStr
    }
    
    func setValueFilter() {
        filterTitleLabel.text = "가치관 필터"
        filterTitleLabel.textColor = .subGray3
        filterTitleLabel.font = .spoqaLight(size: 22)
        filterTitleLabel.letterSpacing = -1.1
        
        filterDescriptionLabel.text = "어떤 가치관을 기준으로 매칭 되었을까요?"
        filterDescriptionLabel.textColor = .subGray2
        filterDescriptionLabel.font = .spoqaRegular(size: 12)
        filterDescriptionLabel.letterSpacing = -0.36
        
        filterCountLabel.text = "가치관 \(sameValueCount) / 5"
        filterCountLabel.textColor = .subGray2
        filterCountLabel.font = .spoqaRegular(size: 12)
        filterCountLabel.letterSpacing = -0.36
    }
    
    /// 가치관 필터 문제 스타일 설정
    func setValueList() {
        for i in 0...4 {
            if valueFilter[i].isSame { /// 나와 같은 답이면
                filterQuestionView[i].backgroundColor = UIColor(red: 153/255, green: 128/255, blue: 250/255, alpha: 0.15)
                filterQuestionView[i].makeRounded(cornerRadius: 4)
                
                filterQuestionLabel[i].textColor = .find_DarkPurple
                filterQuestionLabel[i].font = .spoqaRegular(size: 12)
                filterQuestionLabel[i].letterSpacing = -0.36
                
            } else { /// 나와 다른 답이면
                filterQuestionView[i].backgroundColor = .subGray4
                filterQuestionView[i].makeRounded(cornerRadius: 4)
                
                filterQuestionLabel[i].textColor = .white
                filterQuestionLabel[i].font = .spoqaRegular(size: 12)
                filterQuestionLabel[i].letterSpacing = -0.36
            }
        }
    }
    
    func setValueQnA() {
        valueQnATitleLabel.text = "가치관 문답"
        valueQnATitleLabel.textColor = .subGray3
        valueQnATitleLabel.font = .spoqaLight(size: 22)
        valueQnATitleLabel.letterSpacing = -1.1
        
        valueQnATitleLabel.text = "상대는 어떤 사람일까요, 확인해 보세요 :)"
        valueQnATitleLabel.textColor = .subGray2
        valueQnATitleLabel.font = .spoqaRegular(size: 12)
        valueQnATitleLabel.letterSpacing = -0.36
    }
    
    //MARK: - Functions
    
    
}
