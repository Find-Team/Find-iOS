//
//  BasicInfoCVCell.swift
//  Find-iOS
//
//  Created by Seri Park on 2021/05/20.
//

import UIKit

class BasicInfoCVCell: UICollectionViewCell, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    static let identifier = "BasicInfoCVCell"
    var picker: PickerType?
    let toolBar = UIToolbar()
    
    enum PickerType: Int {
        case school = 2
        case mbti = 3
        case height = 4
        case bodyShpe = 5
        case smoking = 6
        case religion = 7
        case marriage = 8
        case drinking = 9
    }
    
    // 피커에 들어가는 자료
    let school = ["고등학교", "전문대", "대학교", "대학원", "석사", "박사", "기타"]
    let mbti = ["ENTJ", "ENTP", "INTJ", "INTP", "ESTJ", "ESFJ", "ISTJ", "ISFJ", "ENFJ", "ENFP", "INFJ", "INFP", "ESTP", "ESFP", "ISTP", "ISFP"]
    let height = ["145~190  (처음 켰을때 170에 커서 가있음)"]
    let bodyShape = ["마른", "슬림", "보통", "근육질", "통통", "우람"]
    let smoking = ["절대 안 핌", "사교적 흡연가", "자주 핌"]
    let religion = ["종교없음", "개신교", "천주교", "불교", "원불교", "기타"]
    let marriage = ["미혼", "재혼"]
    let drinking = ["마시지 않음", "사교적 음주가", "어느정도 즐기는편", "술자리를 즐김"]
    
    var basicInfoData : [BasicInfoData] = []


    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoTextField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { self.infoTextField.endEditing(true) }
    
    func setStyle() {
        titleLabel.font = UIFont.spoqaMedium(size: 13)
        titleLabel.textColor = .subGray3
    }
    
    func setCell(info: BasicInfoData) {
        titleLabel.text = info.question
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let type = picker else { return Int() }
        
        switch type {
        case .school:
            return school.count
        case .mbti:
            return mbti.count
        case .height:
            return height.count
        case .bodyShpe:
            return bodyShape.count
        case .smoking:
            return smoking.count
        case .religion:
            return religion.count
        case .marriage:
            return marriage.count
        case .drinking:
            return drinking.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let type = picker else { return String() }
        
        switch type {
        case .school:
            return school[row]
        case .mbti:
            return mbti[row]
        case .height:
            return height[row]
        case .bodyShpe:
            return bodyShape[row]
        case .smoking:
            return smoking[row]
        case .religion:
            return religion[row]
        case .marriage:
            return marriage[row]
        case .drinking:
            return drinking[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let type = picker else { return }
        
        switch type {
        case .school:
            infoTextField.text = school[row]
        case .mbti:
             infoTextField.text = mbti[row]
        case .height:
             infoTextField.text = height[row]
        case .bodyShpe:
             infoTextField.text = bodyShape[row]
        case .smoking:
            infoTextField.text = smoking[row]
        case .religion:
            infoTextField.text = religion[row]
        case .marriage:
            infoTextField.text = marriage[row]
        case .drinking:
            infoTextField.text = drinking[row]
        }
    }
    
    func createPickerView(idx: Int) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        picker = PickerType(rawValue: idx)
        
        infoTextField.inputView = pickerView
        infoTextField.tag = idx
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil) //선택 오른쪽
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(pickerExit))

        toolBar.setItems([flexibleSpace, button], animated: true)
        toolBar.isUserInteractionEnabled = true
        infoTextField.inputAccessoryView = toolBar
    }
    
    @objc func pickerExit() {
        /// picker와 같은 뷰를 닫는 함수
        self.infoTextField.endEditing(true)
    }

}
