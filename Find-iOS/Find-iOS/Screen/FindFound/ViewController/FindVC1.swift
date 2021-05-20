//
//  FindVC.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/13.
//

import UIKit

class FindVC1: UIViewController {

    @IBOutlet weak var similarView: UIView!
    @IBOutlet weak var differentView: UIView!
    @IBOutlet weak var similarCollectedView: UIView!
    @IBOutlet weak var differentCollectedView: UIView!
    @IBOutlet weak var recycleView: UIView!
    @IBOutlet weak var similarBtn: UIButton!
    @IBOutlet weak var differentBtn: UIButton!
    @IBOutlet weak var findBtn: UIButton!
    
    var checkSimilarActive: Bool = false
    var checkDifferentActive: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setButton()
        // Do any additional setup after loading the view.
    }
    
    func setView() {
        self.similarView.makeRounded(cornerRadius: similarView.frame.width/2)
        self.differentView.makeRounded(cornerRadius: differentView.frame.width/2)
        similarCollectedView.makeRounded(cornerRadius: similarCollectedView.frame.width/2)
        differentCollectedView.makeRounded(cornerRadius: differentCollectedView.frame.width/2)
        similarCollectedView.backgroundColor = .white
        differentCollectedView.backgroundColor = .white
        
        var beforeTestView = BeforeTestView(frame: recycleView.frame)
        self.recycleView.addSubview(beforeTestView)
    }
    
    func setButton() {
        similarBtn.titleLabel?.textAlignment = .center
        differentBtn.titleLabel?.textAlignment = .center
    
        findBtn.makeRounded(cornerRadius: 25)
        findBtn.isEnabled = false

    }

    
    // MARK: - IBActions
    
    @IBAction func similarBtnClicked(_ sender: Any) {
        if self.similarBtn.isSelected == false {
            self.similarBtn.isSelected = true
            self.checkSimilarActive = true
            similarCollectedView.backgroundColor = .find_Mint
            findBtn.backgroundColor = .find_Mint
        }

        else {
            self.similarBtn.isSelected = false
            self.checkSimilarActive = false
            similarCollectedView.backgroundColor = .white
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
            differentCollectedView.backgroundColor = .find_Mint
            findBtn.backgroundColor = .find_Mint
        }

        else {
            self.differentBtn.isSelected = false
            self.checkDifferentActive = false
            differentCollectedView.backgroundColor = .white
            if checkSimilarActive == false {
                findBtn.backgroundColor = .subGray4
                findBtn.isEnabled = false
            }
        }
    }
}
