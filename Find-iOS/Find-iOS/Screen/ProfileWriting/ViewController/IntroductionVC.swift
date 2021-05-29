//
//  IntroductionVC.swift
//  Find-iOS
//
//  Created by Seri Park on 2021/05/15.
//

import UIKit

class IntroductionVC: UIViewController {
   
    // MARK:- Variable Part
    
    var placeholderPhrase = "직업이나 전공, 꿈과 목표가 있다면 알려주세요."
    var inputData: String = ""
   
    @IBOutlet var infoTitle: UILabel!
    @IBOutlet var saveBtn: UIButton!
    
    @IBOutlet var introTitle: UILabel!
    @IBOutlet var introExplain: UILabel!
    
    @IBOutlet var bodyView: UIView!
    @IBOutlet var bodyTextView: UITextView!
    
    @IBOutlet var characterLimit: UILabel!
    
    // MARK:- IBAction
    
    //뒤로가기
    @IBAction func backBtnPressed(_ sender: Any) {
        //이전 화면으로 돌아가기
        if inputData != "" {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InfoWritten"), object: inputData)
        }
        
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        //내용 입력이 없을 경우, "내용을 입력해주세요" 토스트
        if (bodyTextView.text.isEmpty || bodyTextView.text == placeholderPhrase || bodyTextView.text.count < 10) {
            self.showToast(message: "내용을 입력해주세요.", font: UIFont.spoqaRegular(size: 16), width: 170, bottomY: 181)
        } else if (bodyTextView.text.count >= 10) {
//            self.showToast(message: "저장되었습니다.", font: UIFont.spoqaRegular(size: 16), width: 130, bottomY: 181)
            if inputData != "" {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InfoWritten"), object: inputData)
            }
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
        setView()
        placeholderSetting()
        
    }
    
    // 뷰 클릭 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - Extension

extension IntroductionVC {
    func setHeader() {
        infoTitle.text = "소개글 작성"
        infoTitle.font = UIFont.spoqaMedium(size: 18)
        infoTitle.textColor = UIColor.subGray3
        infoTitle.letterSpacing = -0.54
        
        saveBtn.setTitle("저장", for: .normal)
        saveBtn.titleLabel?.font = UIFont.spoqaRegular(size: 18)
        saveBtn.titleLabel?.letterSpacing = -0.54
        saveBtn.setTitleColor(UIColor.subGray1, for: .normal)
    }
    
    func setView() {
        introTitle.text = "소개글"
        introTitle.font = UIFont.spoqaLight(size: 22)
        introTitle.textColor = UIColor.subGray3
        infoTitle.letterSpacing = -1.1
        
        
        introExplain.text = "당신을 소개해주세요! (최소 10자)"
        introExplain.font = UIFont.spoqaRegular(size: 12)
        introExplain.textColor = UIColor.find_DarkPurple
        introExplain.letterSpacing = -0.36
        
        bodyView.clipsToBounds = true
        bodyView.layer.cornerRadius = 10
        
        characterLimit.font = UIFont.spoqaRegular(size: 12)
        characterLimit.textColor = UIColor.subGray1
        characterLimit.text = "0/500"
    }
    
    // 사용법: showToast(message : "원하는 메세지 내용", font: UIFont.spoqaRegular(size: 15), width: 188, bottomY: 181)
    
    func showToast(message : String, font: UIFont, width: Int, bottomY: Int) {
        let guide = view.safeAreaInsets.bottom
        let y = self.view.frame.size.height-guide
        
        let toastLabel = UILabel(
            frame: CGRect( x: self.view.frame.size.width/2 - CGFloat(width)/2,
                           y: y-CGFloat(bottomY),
                           width: CGFloat(width),
                           height: 33
            )
        )
        
        toastLabel.backgroundColor = UIColor.find_DarkPurple
        toastLabel.textColor = UIColor.subGray6
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}

// MARK: - UITextViewDelegate

extension IntroductionVC: UITextViewDelegate {
    
    // 디폴트 placeholder 지정
    func placeholderSetting(){
        bodyTextView.delegate = self
        bodyTextView.text = placeholderPhrase
        bodyTextView.textColor = UIColor.subGray1
        bodyTextView.font = UIFont.spoqaRegular(size: 16)
    }
    
    // 편집 시작
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderPhrase {
            textView.text = nil
            textView.textColor = UIColor.subGray3
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        inputData = textView.text
        //print(inputData)
    }
    
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = placeholderPhrase
            textView.textColor = UIColor.lightGray
        } else {
            inputData = textView.text
            //print(inputData)
        }
    }
    
    // 글자수 체크 기능, 500자 까지만 제한
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText string: String) -> Bool{
        if(textView == bodyTextView){
            let strLength = textView.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthCount = strLength + lengthToAdd
            self.characterLimit.text = "\(lengthCount)/500"
            
            //10자 넘어갈 경우에만 라벨 색 변경, 저장 활성화
            if (lengthCount >= 10) {
                self.characterLimit.textColor = UIColor.blue
                saveBtn.setTitleColor(UIColor.subGray3, for: .normal)
            } else {
                self.characterLimit.textColor = UIColor.subGray1
                saveBtn.setTitleColor(UIColor.subGray1, for: .normal)
            }
            return lengthCount < 500
        }
        return true
    }
}
