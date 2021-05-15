//
//  IntroductionVC.swift
//  Find-iOS
//
//  Created by Seri Park on 2021/05/15.
//

import UIKit

class IntroductionVC: UIViewController {
   
    // MARK:- Variable Part
    
    //var missionDelegate: MissionEndDelegate?
    //var missionDelegate: MissionEndDelegate?
    var placeholderPhrase = "직업이나 전공, 꿈과 목표가 있다면 알려주세요."
   
    @IBOutlet var infoTitle: UILabel!
    @IBOutlet var saveBtn: UIButton!
    
    @IBOutlet var introTitle: UILabel!
    @IBOutlet var introExplain: UILabel!
    
    @IBOutlet var bodyView: UIView!
    @IBOutlet var bodyTextView: UITextView!
    
    @IBOutlet var characterLimit: UILabel!
    
    //뒤로가기
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
        setView()
        placeholderSetting()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뷰 클릭 시 키보드 내리기
        view.endEditing(true)
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
        
        bodyView.clipsToBounds = true
        bodyView.layer.cornerRadius = 10
        
        characterLimit.font = UIFont.spoqaRegular(size: 12)
        characterLimit.textColor = UIColor.subGray1
        characterLimit.text = "0/500"
    }
}


// MARK: Extension

extension IntroductionVC: UITextViewDelegate {
    
    // MARK: Function
    
    //디폴트 placeholder 지정
    func placeholderSetting(){
        bodyTextView.delegate = self
        bodyTextView.text = placeholderPhrase
        //bodyTextView.lineSetting(kernValue: -0.9, lineSpacing: 10)
        bodyTextView.textColor = UIColor.subGray1
        bodyTextView.font = UIFont.spoqaRegular(size: 16)
    }
    
    //편집 시작
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderPhrase {
            textView.text = nil
            textView.textColor = UIColor.subGray3
        }
    }
    
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = placeholderPhrase
            textView.textColor = UIColor.lightGray
        }
    }
    
    // 글자수 체크 기능, 500자 까지만 제한
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText string: String) -> Bool{
        if(textView == bodyTextView){
            let strLength = textView.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthCount = strLength + lengthToAdd
            self.characterLimit.text = "\(lengthCount)/500"
            return lengthCount < 500
        }
        
        return true
    }
}
