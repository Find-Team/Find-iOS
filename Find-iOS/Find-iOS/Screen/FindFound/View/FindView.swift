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
    
    var checkSimilarActive: Bool = false
    var checkDifferentActive: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nib = UINib(nibName: "FindView", bundle: Bundle.main)
        
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return}
        
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        
        setView()
        setButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    
    func setView() {
        similarView.makeRounded(cornerRadius: similarView.frame.width/2)
        differentView.makeRounded(cornerRadius: differentView.frame.width/2)
        similarView.backgroundColor = .white
        differentView.backgroundColor = .white
        
        var beforeTestView = BeforeTestView(frame: aboutValueView.frame)
        self.aboutValueView.addSubview(beforeTestView)
    }
    
    func setButton() {
        similarBtn.titleLabel?.textAlignment = .center
        differentBtn.titleLabel?.textAlignment = .center
        
        similarBtn.makeRounded(cornerRadius: similarBtn.frame.width/2)
        differentBtn.makeRounded(cornerRadius: differentBtn.frame.width/2)
    
        findBtn.makeRounded(cornerRadius: 25)
    }

    @IBAction func similarBtnClicked(_ sender: Any) {
        if self.similarBtn.isSelected == false {
            // similarBtn 눌렸을 때
            self.similarBtn.isSelected = true
            self.checkSimilarActive = true
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
            self.checkDifferentActive = true
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
        print("actionaction")
        let parentViewController: UIViewController = self.parentViewController!
        
        let lottieStoryBoard = UIStoryboard(name: "MatchingLottie", bundle: nil)
        let findFoundStoryBoard = UIStoryboard(name: "FindFound", bundle: nil)
        
        guard let loadingVC = lottieStoryBoard.instantiateViewController(identifier: "MatchingLottieVC") as? MatchingLottieVC else { return }
        guard let dvc = findFoundStoryBoard.instantiateViewController(identifier: "FindFoundVC") as? FindFoundVC else { return }
        
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.tabBarController?.tabBar.isHidden = true

        parentViewController.present(loadingVC, animated: false, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            parentViewController.dismiss(animated: false) {
                dvc.findCheckIndex = 1
                parentViewController.navigationController?.pushViewController(dvc, animated: true)
            }
        }
    }
}
