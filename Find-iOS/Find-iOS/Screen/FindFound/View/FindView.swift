//
//  FindView.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/21.
//

import UIKit

class FindView: UIView {

    @IBOutlet weak var aboutValueView: UIView!
    @IBOutlet weak var similarView: UIView!
    @IBOutlet weak var similarBtn: UIButton!
    @IBOutlet weak var differentView: UIView!
    @IBOutlet weak var differentBtn: UIButton!
    @IBOutlet weak var findBtn: UIButton!
    @IBOutlet weak var matchingBtnTop: NSLayoutConstraint!
    
    var checkSimilarActive: Bool = false
    var checkDifferentActive: Bool = false
    var screenWidth = UIScreen.main.bounds.width
    
    var answerCount: Int = 0 // 유저가 답변을 했는지
    var choiceCount: Int = 0 // 5개를 골랐는지
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nib = UINib(nibName: "FindView", bundle: Bundle.main)
        
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return}
        
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        
        print("setView")
        
        setView()
        setButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    
    func setView() {
        if screenWidth == 390 {
            matchingBtnTop.constant = 48
        }
        similarView.makeRounded(cornerRadius: similarView.frame.width/2)
        differentView.makeRounded(cornerRadius: differentView.frame.width/2)
        similarView.backgroundColor = .white
        differentView.backgroundColor = .white
        
        var beforeTestView = BeforeTestView(frame: aboutValueView.frame)
        var beforeAnswerView = BeforeAnswerView(frame: aboutValueView.frame)
        var afterAnswerView = AfterAnswerView(frame: aboutValueView.frame)
        
        self.aboutValueView.addSubview(beforeTestView)
        
        // 테스트, 필터 설정까지 완료된 후 붙일 뷰
        
        for i in 0...29 {
            if valueQuestions[i].userChoice != 0 {
                answerCount += 1
            }
            if valueQuestions[i].isChosen {
                choiceCount += 1
            }
        }
        
        print(answerCount)
        print(choiceCount)
        
        if answerCount >= 5 {
            if choiceCount == 5 {
                // 아예 완료된 뷰
                print("필터까지 완료")
                self.aboutValueView.addSubview(afterAnswerView)
            } else {
                // 중간까지만 완료된 뷰
                print("중간까지 완료")
                self.aboutValueView.addSubview(beforeAnswerView)
            }
        }
    }
    
    func setButton() {
        similarBtn.titleLabel?.textAlignment = .center
        differentBtn.titleLabel?.textAlignment = .center
        
        similarBtn.makeRounded(cornerRadius: similarBtn.frame.width/2)
        differentBtn.makeRounded(cornerRadius: differentBtn.frame.width/2)
    
        findBtn.makeRounded(cornerRadius: 25)
        findBtn.isEnabled = false
    }

    @IBAction func similarBtnClicked(_ sender: Any) {
        if self.similarBtn.isSelected == false {
            // similarBtn 눌렸을 때
            self.similarBtn.isSelected = true
            findBtn.isEnabled = true
            self.checkSimilarActive = true
            
            similarBtn.setTitleColor(.subGray3, for: .highlighted)
            similarBtn.setTitleColor(.subGray3, for: .selected)
            
            similarView.backgroundColor = .find_Mint
            findBtn.backgroundColor = .find_Mint
        }
        
        else {
            // similarBtn 해제됐을 때
            self.similarBtn.isSelected = false
            self.checkSimilarActive = false
            similarView.backgroundColor = .white
            if checkDifferentActive == false {
                findBtn.backgroundColor = .subGray4
            }
        }
    }
    
    @IBAction func differentBtnClicked(_ sender: Any) {
        if self.differentBtn.isSelected == false {
            // differentBtn 눌렸을 때
            self.differentBtn.isSelected = true
            findBtn.isEnabled = true
            self.checkDifferentActive = true
            
            differentBtn.setTitleColor(.subGray3, for: .highlighted)
            differentBtn.setTitleColor(.subGray3, for: .selected)
            
            differentView.backgroundColor = .find_Mint
            findBtn.backgroundColor = .find_Mint
        }

        else {
            self.differentBtn.isSelected = false
            self.checkDifferentActive = false
            differentView.backgroundColor = .white
            if checkSimilarActive == false {
                findBtn.backgroundColor = .subGray4
            }

        }
    }
    
    @IBAction func findBtnClicked(_ sender: Any) {
        
        // found Segue로 이동
        let parentViewController: UIViewController = self.parentViewController!
        
        let lottieStoryBoard = UIStoryboard(name: "MatchingLottie", bundle: nil)
        let findFoundStoryBoard = UIStoryboard(name: "FindFound", bundle: nil)
        
        guard let loadingVC = lottieStoryBoard.instantiateViewController(identifier: "MatchingLottieVC") as? MatchingLottieVC else { return }
        guard let dvc = findFoundStoryBoard.instantiateViewController(identifier: "FindFoundVC") as? FindFoundVC else { return }
        
        loadingVC.modalPresentationStyle = .fullScreen
        loadingVC.tabBarController?.tabBar.isHidden = true
//        loadingVC.hidesBottomBarWhenPushed = true
        
        if checkDifferentActive {
            loadingVC.matchingType = .oppositePerson
        }
        
        parentViewController.present(loadingVC, animated: false, completion: nil)
//        parentViewController.navigationController?.pushViewController(loadingVC, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            parentViewController.dismiss(animated: false) {
                dvc.findCheckIndex = 1

                print(dvc.findCheckIndex)

                parentViewController.navigationController?.pushViewController(dvc, animated: true)
            }
        }

    }
}
