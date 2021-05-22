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
        findBtn.isEnabled = false

    }


    @IBAction func similarBtnClicked(_ sender: Any) {
        if self.similarBtn.isSelected == false {
            self.similarBtn.isSelected = true
            self.checkSimilarActive = true
            similarView.backgroundColor = .find_Mint
            findBtn.backgroundColor = .find_Mint
            findBtn.isEnabled = true
        }
        
        else {
            self.similarBtn.isSelected = false
            self.checkSimilarActive = false
            similarView.backgroundColor = .white
            if checkDifferentActive == false {
                findBtn.backgroundColor = .subGray4
                findBtn.isEnabled = false
            }
        }
    }
    
    @IBAction func differentBtnClicked(_ sender: Any) {
        if self.differentBtn.isSelected == false {
            self.differentBtn.isSelected = true
            self.checkDifferentActive = true
            differentView.backgroundColor = .find_Mint
            findBtn.backgroundColor = .find_Mint
            findBtn.isEnabled = true
        }

        else {
            self.differentBtn.isSelected = false
            self.checkDifferentActive = false
            differentView.backgroundColor = .white
            if checkSimilarActive == false {
                findBtn.backgroundColor = .subGray4
                findBtn.isEnabled = false
            }
        }
    }
}
