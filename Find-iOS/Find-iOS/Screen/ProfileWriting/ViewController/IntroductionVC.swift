//
//  IntroductionVC.swift
//  Find-iOS
//
//  Created by Seri Park on 2021/05/15.
//

import UIKit

class IntroductionVC: UIViewController {
    
    // MARK:- Variable Part
   
    @IBOutlet var infoTitle: UILabel!
    @IBOutlet var saveBtn: UIButton!
    
    @IBOutlet var introTitle: UILabel!
    @IBOutlet var introExplain: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
        setView()
        
    }
    
 
}


extension IntroductionVC {
    func setHeader() {
        infoTitle.text = "소개글 작성"
        infoTitle.font = UIFont.spoqaMedium(size: 18)
        infoTitle.textColor = UIColor.subGray3
        
        saveBtn.setTitle("저장", for: .normal)
        saveBtn.titleLabel?.font = UIFont.spoqaRegular(size: 18)
        saveBtn.setTitleColor(UIColor.black, for: .normal)
        
    }
    
    func setView() {
        introTitle.text = "소개글"
        introTitle.font = UIFont.spoqaLight(size: 22)
        introTitle.textColor = UIColor.subGray3
        
        introExplain.text = "당신을 소개해주세요! (최소 10자)"
        introExplain.font = UIFont.spoqaRegular(size: 12)
        introExplain.textColor = UIColor.find_DarkPurple
    }
}

