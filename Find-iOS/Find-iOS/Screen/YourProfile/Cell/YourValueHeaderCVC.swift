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
    
    var nickname: String = "쿄호젤리"
    var sameValueCount: Int = 4
    
    var currentSegue: ValueFilterAll = .same
    
    //MARK: - IBOutlets
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var dismissBtn: UIButton!
    @IBOutlet var headerSubTitleLabel: UILabel! {
        didSet {
            headerSubTitleLabel.text = "당신과 비슷해서 더욱 매력적인"
            headerSubTitleLabel.textColor = .subGray6
            headerSubTitleLabel.font = .spoqaLight(size: 14)
            headerSubTitleLabel.letterSpacing = -0.42
        }
    }
    @IBOutlet var headerTitleLabel: UILabel! {
        didSet {
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
    }
    
    @IBOutlet var filterTitleLabel: UILabel! {
        didSet {
            filterTitleLabel.text = "가치관 필터"
            filterTitleLabel.textColor = .subGray3
            filterTitleLabel.font = .spoqaLight(size: 22)
            filterTitleLabel.letterSpacing = -1.1
        }
    }
    @IBOutlet var filterDescriptionLabel: UILabel! {
        didSet {
            filterDescriptionLabel.text = "어떤 가치관을 기준으로 매칭 되었을까요?"
            filterDescriptionLabel.textColor = .subGray2
            filterDescriptionLabel.font = .spoqaRegular(size: 12)
            filterDescriptionLabel.letterSpacing = -0.36
        }
    }
    @IBOutlet var filterCountLabel: UILabel! {
        didSet {
            filterCountLabel.text = "가치관  \(sameValueCount) / 5"
            filterCountLabel.textColor = .subGray2
            filterCountLabel.font = .spoqaRegular(size: 12)
            filterCountLabel.letterSpacing = -0.36
        }
    }
    @IBOutlet var filterQuestionView: [UIView]!
    @IBOutlet var filterQuestionLabel: [UILabel]!
    
    @IBOutlet var valueQnATitleLabel: UILabel! {
        didSet {
            valueQnATitleLabel.text = "가치관 문답"
            valueQnATitleLabel.textColor = .subGray3
            valueQnATitleLabel.font = .spoqaLight(size: 22)
            valueQnATitleLabel.letterSpacing = -1.1
        }
    }
    @IBOutlet var valueQnADescriptionLabel: UILabel! {
        didSet {
            valueQnADescriptionLabel.text = "상대는 어떤 사람일까요, 확인해 보세요 :)"
            valueQnADescriptionLabel.textColor = .subGray2
            valueQnADescriptionLabel.font = .spoqaRegular(size: 12)
            valueQnADescriptionLabel.letterSpacing = -0.36
        }
    }
    
    @IBOutlet var sameQuestionBtn: UIButton!
    @IBOutlet var differentQuestionBtn: UIButton!
    @IBOutlet var segueIndicator: [UIView]!
    
    //MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(segueChanged(_:)), name: NSNotification.Name("SegueChangedbyScroll"), object: nil)
    }
    
    override func prepareForReuse() {
        
    }
    
    //MARK: - IBActions
    
    @IBAction func dismissBtnDidTap(_ sender: Any) {
        self.parentViewController?.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sameQuestionBtnDidTap(_ sender: Any) {
        sameQuestionSelected()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SegueChanged"), object: currentSegue)
        print("same noti sent")
    }
    
    @IBAction func differentQuestionBtnDidTap(_ sender: Any) {
        differentQuestionSelected()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SegueChanged"), object: currentSegue)
        print("different noti sent")
    }
    
}

extension YourValueHeaderCVC {
    //MARK: - Styles

    /// 가치관 필터 문제 스타일 설정
    func setValueList() {
        for i in 0...4 {
            if valueFilter[i].isSame { /// 나와 같은 답이면
                filterQuestionView[i].backgroundColor = UIColor(red: 153/255, green: 128/255, blue: 250/255, alpha: 0.15)
                filterQuestionView[i].makeRounded(cornerRadius: 4)
                
                filterQuestionLabel[i].text = valueFilter[i].question
                filterQuestionLabel[i].textColor = .find_DarkPurple
                filterQuestionLabel[i].font = .spoqaRegular(size: 12)
                filterQuestionLabel[i].letterSpacing = -0.36
                
            } else { /// 나와 다른 답이면
                filterQuestionView[i].backgroundColor = .subGray4
                filterQuestionView[i].makeRounded(cornerRadius: 4)
                
                filterQuestionLabel[i].text = valueFilter[i].question
                filterQuestionLabel[i].textColor = .white
                filterQuestionLabel[i].font = .spoqaRegular(size: 12)
                filterQuestionLabel[i].letterSpacing = -0.36
            }
        }
    }

    
    //MARK: - Functions
    
    func sameQuestionSelected() {
        currentSegue = .same
        
        segueIndicator[0].backgroundColor = .find_DarkPurple
        segueIndicator[1].backgroundColor = .subGray1

        
        sameQuestionBtn.setTitle("같은 답변", for: .normal)
        sameQuestionBtn.setTitleColor(.find_DarkPurple, for: .normal)
        sameQuestionBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        differentQuestionBtn.setTitle("다른 답변", for: .normal)
        differentQuestionBtn.titleLabel?.font = .spoqaRegular(size: 14)
        differentQuestionBtn.setTitleColor(.subGray2, for: .normal)
    }
    
    func differentQuestionSelected() {
        currentSegue = .different
        
        segueIndicator[0].backgroundColor = .subGray1
        segueIndicator[1].backgroundColor = .find_DarkPurple

        
        differentQuestionBtn.setTitle("다른 답변", for: .normal)
        differentQuestionBtn.setTitleColor(.find_DarkPurple, for: .normal)
        differentQuestionBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        sameQuestionBtn.setTitle("같은 답변", for: .normal)
        sameQuestionBtn.titleLabel?.font = .spoqaRegular(size: 14)
        sameQuestionBtn.setTitleColor(.subGray2, for: .normal)
    }
    
    @objc func segueChanged(_ noti: Notification) {
        currentSegue = noti.object as! ValueFilterAll
        
        print("scroll noti received")
        
        if currentSegue == .same {
            sameQuestionSelected()
        } else {
            differentQuestionSelected()
        }
    }
    
}
