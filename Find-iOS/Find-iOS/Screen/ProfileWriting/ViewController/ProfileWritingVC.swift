//
//  ProfileWritingVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit
import Photos

var profileImages: [ProfileImages] = [ProfileImages(images:[])] // 이미지

class ProfileWritingVC: UIViewController, UITextFieldDelegate  {
    // MARK:- Variable Part
    var receivedInt : Int? // 선택된 이미지의 인덱스 값 - preview View에서 사용하기 위함
    let picker = UIImagePickerController()
    var basicInfoData : [BasicInfoData] = []
    var imageSelected: UIImage?
    
    let toolbar = UIToolbar()
    
    var schoolPicker = UIPickerView() {
        didSet{
            schoolPicker.dataSource = self
            schoolPicker.delegate = self
        }
    }
    var mbtiPicker = UIPickerView() {
        didSet{
            mbtiPicker.dataSource = self
            mbtiPicker.delegate = self
        }
    }
    var heightPicker = UIPickerView() {
        didSet{
            heightPicker.dataSource = self
            heightPicker.delegate = self
        }
    }
    var bodyShapePicker = UIPickerView() {
        didSet{
            bodyShapePicker.dataSource = self
            bodyShapePicker.delegate = self
        }
    }
    var smokingPicker = UIPickerView() {
        didSet{
            smokingPicker.dataSource = self
            smokingPicker.delegate = self
        }
    }
    var religionPicker = UIPickerView() {
        didSet{
            religionPicker.dataSource = self
            religionPicker.delegate = self
        }
    }
    var marriagePicker = UIPickerView() {
        didSet{
            marriagePicker.dataSource = self
            marriagePicker.delegate = self
        }
    }
    var drinkingPicker = UIPickerView() {
        didSet{
            drinkingPicker.dataSource = self
            drinkingPicker.delegate = self
        }
    }
    
    //피커에 들어가는 자료
    let school = ["고등학교", "전문대", "대학교", "대학원", "석사", "박사", "기타"]
    let mbti = ["ENTJ", "ENTP", "INTJ", "INTP", "ESTJ", "ESFJ", "ISTJ", "ISFJ", "ENFJ", "ENFP", "INFJ", "INFP", "ESTP", "ESFP", "ISTP", "ISFP"]
    let height = ["145~190  (처음 켰을때 170에 커서 가있음)"]
    let bodyShape = ["마른", "슬림", "보통", "근육질", "통통", "우람"]
    let smoking = ["절대 안 핌", "사교적 흡연가", "자주 핌"]
    let religion = ["종교없음", "개신교", "천주교", "불교", "원불교", "기타"]
    let marriage = ["미혼", "재혼"]
    let drinking = ["마시지 않음", "사교적 음주가", "어느정도 즐기는편", "술자리를 즐김"]
    
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var profileWriting: UILabel!
    @IBOutlet var completeBtn: UIButton!
    
    @IBOutlet var profilePicture: UILabel!
    @IBOutlet var pictureExplain: UILabel!
    @IBOutlet var pictureGuideBtn: UIButton!
    
    @IBOutlet weak var profileCV: UICollectionView! {
        didSet {
            profileCV.delegate = self
            profileCV.dataSource = self
        }
    }
    
    @IBOutlet var previewView: UIView!
    @IBOutlet var previewLabel: UILabel!
    @IBOutlet var previewImageView: UIImageView!
    @IBOutlet var editBtn: UIButton!
    
    @IBOutlet var identityVerify: UILabel!
    @IBOutlet var verifyInfoBtn: UIButton!
    @IBOutlet var verifyBtn: UIButton!
    
    @IBOutlet var infoWriting: UILabel!
    @IBOutlet var infoExplain: UILabel!
    @IBOutlet var goToInfoBtn: UIButton!
    
    @IBOutlet var accountWriting: UILabel!
    @IBOutlet var accountExplain: UILabel!
    
    @IBOutlet var nicknameView: UIView!
    @IBOutlet var birthdayView: UIView!
    @IBOutlet var genderView: UIView!
    @IBOutlet var regionView: UIView!
    
    @IBOutlet var nickname: UILabel!
    @IBOutlet var nicknameInfo: UILabel!
    
    @IBOutlet var birthday: UILabel!
    @IBOutlet var birthdayInfo: UILabel!
    
    @IBOutlet var gender: UILabel!
    @IBOutlet var genderInfo: UILabel!
    
    @IBOutlet var region: UILabel!
    @IBOutlet var regionInfo: UILabel!
    
    @IBOutlet var basicInfo: UILabel!
    @IBOutlet var basicInfoExplain: UILabel!
    
    @IBOutlet var basicInfoCV: UICollectionView!{
        didSet {
            basicInfoCV.delegate = self
            basicInfoCV.dataSource = self
        }
        
    }
    
    
    // MARK:- IBAction
    
    @IBAction func goToIntroduction(_ sender: UIButton) {
        //Introduction 로 이동
        let nextStoryboard = UIStoryboard(name: "Introduction", bundle: nil)
        guard let IntroductionVC = nextStoryboard.instantiateViewController(withIdentifier: "IntroductionVC") as? IntroductionVC else {return}
        self.navigationController?.pushViewController(IntroductionVC, animated: true)
    }
    
    @IBAction func editBtnTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changePhoto"),object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        setHeader()
        setView()
        setAccountInfo()
        setBasicInfo()
        
        profileImages = [ ProfileImages(images: [], isRep: true),
                          ProfileImages(images: [], isRep: false),
                          ProfileImages(images: [], isRep: false)
        ]
        
        
        basicInfoData = [ BasicInfoData(question: "직업", isEdit: false, answer: nil),
                          BasicInfoData(question: "직장", isEdit: false, answer: nil),
                          BasicInfoData(question: "학력", isEdit: false, answer: nil),
                          BasicInfoData(question: "MBTI", isEdit: false, answer: nil),
                          BasicInfoData(question: "키", isEdit: false, answer: nil),
                          BasicInfoData(question: "체형", isEdit: false, answer: nil),
                          BasicInfoData(question: "흡연", isEdit: false, answer: nil),
                          BasicInfoData(question: "종교", isEdit: false, answer: nil),
                          BasicInfoData(question: "결혼", isEdit: false, answer: nil),
                          BasicInfoData(question: "음주", isEdit: false, answer: nil)
        ]
    }
    
}

extension ProfileWritingVC {
    
    func setUPNoti(){
        NotificationCenter.default.addObserver(self, selector: #selector(dataReceived), name: NSNotification.Name(rawValue:"previewImageNoti"), object: nil)
    }
    
    // MARK: - Open Photo Library
    func openPhotoLibrary() {
        /// 사진 접근 권한이 허용되었는지 검사
        switch PHPhotoLibrary.authorizationStatus() {
        /// 권한이 거부된 경우
        case .denied:
            print("denied")
            /// 설정창에서 권한을 재설정 하게끔 유도한다
            if let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String {
                let alert = UIAlertController(title: "설정", message: "\(appName)의 사진 접근 권한이\n허용되어 있지 않습니다.\n설정에서 변경 가능합니다.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "취소", style: .default) { (action) in
                    
                }
                let confirmAction = UIAlertAction(title: "설정", style: .default) { (action) in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
                
                alert.addAction(cancelAction)
                alert.addAction(confirmAction)
                self.parent?.present(alert, animated: true, completion: nil)
            }
        /// restricted
        case .restricted:
            print("restricted")
            break
        /// 권한이 허용된 경우
        case .authorized:
            print("authorized")
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            
            picker.modalPresentationStyle = .fullScreen
            self.parent?.present(self.picker, animated: true, completion: nil)
        /// 권한 허용을 묻기 전인 경우 (최초 1회)
        case .notDetermined:
            print("notDetermined")
            PHPhotoLibrary.requestAuthorization({ state in
                if state == .authorized {
                    DispatchQueue.main.async {
                        self.picker.sourceType = .photoLibrary
                        self.picker.allowsEditing = true
                        
                        self.picker.modalPresentationStyle = .fullScreen
                        self.parent?.present(self.picker, animated: true, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        if let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String {
                            let alert = UIAlertController(title: "설정", message: "\(appName)의 사진 접근 권한이\n허용되어 있지 않습니다.\n설정에서 변경 가능합니다.", preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "취소", style: .default) { (action) in
                                
                            }
                            let confirmAction = UIAlertAction(title: "설정", style: .default) { (action) in
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            }
                            
                            alert.addAction(cancelAction)
                            alert.addAction(confirmAction)
                            self.parent?.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            })
        default:
            print("break")
            break
        }
    }
    
    // NotificationCenter를 이용해 데이터 전달 받기(receivedInt)
    @objc func dataReceived(notification : NSNotification)
    {
        let receivedData = notification.object as? Int
        if receivedData != receivedInt {
            receivedInt = receivedData
            profileCV.reloadSections(IndexSet(2...2))
        }
    }
    
    
    func setHeader() {
        profileWriting.text = "프로필 작성"
        profileWriting.font = UIFont.spoqaMedium(size: 18)
        profileWriting.textColor = UIColor.subGray3
        
        completeBtn.setTitle("완료", for: .normal)
        completeBtn.titleLabel?.font = UIFont.spoqaRegular(size: 18)
        completeBtn.setTitleColor(UIColor.black, for: .normal)
        
    }
    
    func setView() {
        profilePicture.text = "프로필 사진"
        profilePicture.font = UIFont.spoqaLight(size: 22)
        profilePicture.textColor = UIColor.subGray3
        
        let text = "프로필 가이드"
        let titleString = NSMutableAttributedString(string: "프로필 가이드")
        let underLine = NSUnderlineStyle.thick.rawValue
        titleString.addAttribute(NSMutableAttributedString.Key.underlineStyle, value: underLine, range: NSRange(location: 0, length: text.count))
        pictureGuideBtn.setAttributedTitle(titleString, for: .normal)
        
        pictureGuideBtn.titleLabel?.font = UIFont.spoqaRegular(size: 12)
        pictureGuideBtn.setTitleColor(UIColor.subGray3, for: .normal)
        
        pictureExplain.text = "프로필 사진은 최소 3장 이상 업로드 해주세요! (최대6장)"
        pictureExplain.font = UIFont.spoqaRegular(size: 12)
        pictureExplain.textColor = UIColor.find_DarkPurple
        
        previewView.makeRounded(cornerRadius: 10)
        previewView.backgroundColor = .subGray6
        previewLabel.textColor = .find_DarkPurple
        previewLabel.font = .spoqaRegular(size: 12)
        previewImageView.makeRounded(cornerRadius: 10)
        editBtn.makeRounded(cornerRadius: 50)
        editBtn.titleLabel?.font = UIFont.spoqaRegular(size: 12)
        editBtn.setTitleColor(UIColor.subGray6, for: .normal)
        editBtn.isHidden = true
        
        identityVerify.text = "본인 인증"
        identityVerify.font = UIFont.spoqaLight(size: 22)
        identityVerify.textColor = UIColor.subGray3
        
        verifyBtn.clipsToBounds = true
        verifyBtn.layer.cornerRadius = 10
        verifyBtn.layer.borderWidth = 1.0
        verifyBtn.layer.borderColor = UIColor.find_DarkPurple.cgColor
        verifyBtn.layer.backgroundColor = UIColor.find_LightPurple.cgColor
        
        verifyBtn.setTitle("인증 완료", for: .normal)
        verifyBtn.titleLabel?.font = UIFont.spoqaMedium(size: 14)
        verifyBtn.setTitleColor(UIColor.find_DarkPurple, for: .normal)
        
        infoWriting.text = "소개글"
        infoWriting.font = UIFont.spoqaLight(size: 22)
        infoWriting.textColor = UIColor.subGray3
        
        infoExplain.text = "당신을 소개해주세요! (최소 30자)"
        infoExplain.font = UIFont.spoqaRegular(size: 12)
        infoExplain.textColor = UIColor.find_DarkPurple
        
        goToInfoBtn.clipsToBounds = true
        goToInfoBtn.layer.cornerRadius = 10
        goToInfoBtn.layer.borderWidth = 1.0
        goToInfoBtn.layer.borderColor = UIColor.find_DarkPurple.cgColor
        goToInfoBtn.layer.backgroundColor = UIColor.find_LightPurple.cgColor
        
        goToInfoBtn.setTitle("소개글 작성하러 가기", for: .normal)
        goToInfoBtn.titleLabel?.font = UIFont.spoqaMedium(size: 14)
        goToInfoBtn.setTitleColor(UIColor.find_DarkPurple, for: .normal)
    }
    
    func setBoxRadius(box: UIView) {
        box.clipsToBounds = true
        box.layer.cornerRadius = 10
    }
    
    func setTitleFont(title: UILabel) {
        title.font = UIFont.spoqaMedium(size: 13)
        title.textColor = UIColor.subGray3
    }
    
    func setInfoFont(info: UILabel) {
        info.font = UIFont.spoqaRegular(size: 13)
        info.textColor = UIColor.subGray5
    }
    
    func setAccountInfo() {
        accountWriting.text = "계정 정보"
        accountWriting.font = UIFont.spoqaLight(size: 22)
        accountWriting.textColor = UIColor.subGray3
        
        accountExplain.text = "가입시 기재된 정보로 변경이 불가합니다."
        accountExplain.font = UIFont.spoqaRegular(size: 12)
        accountExplain.textColor = UIColor.find_DarkPurple
        
        setBoxRadius(box: nicknameView)
        nickname.text = "닉네임"
        setTitleFont(title: nickname)
        nicknameInfo.text = "맹고감자"
        setInfoFont(info: nicknameInfo)
        
        setBoxRadius(box: birthdayView)
        birthday.text = "생년월일"
        setTitleFont(title: birthday)
        birthdayInfo.text = "1998.10.22"
        setInfoFont(info: birthdayInfo)
        
        setBoxRadius(box: genderView)
        gender.text = "성별"
        setTitleFont(title: gender)
        genderInfo.text = "여자"
        setInfoFont(info: genderInfo)
        
        setBoxRadius(box: regionView)
        region.text = "지역"
        setTitleFont(title: region)
        regionInfo.text = "서울특별시 성북구"
        setInfoFont(info: regionInfo)
    }
    
    func setBasicInfo() {
        basicInfo.text = "기본 정보"
        basicInfo.font = UIFont.spoqaLight(size: 22)
        basicInfo.textColor = UIColor.subGray3
        
        basicInfoExplain.text = "여기에 쓰는 글은 마이 프로필에 노출됩니다."
        basicInfoExplain.font = UIFont.spoqaRegular(size: 12)
        basicInfoExplain.textColor = UIColor.find_DarkPurple
    }
}


extension ProfileWritingVC: UICollectionViewDataSource {
    //셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //프로필 사진일 때
        if collectionView == profileCV {
            return 3
        } else {
            //밑에 웅앵
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == profileCV {
            //profileCVCell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCVCell.identifier, for: indexPath)
                    as? ProfileCVCell else { return UICollectionViewCell()}
            
            //cell style
            cell.layer.backgroundColor = UIColor(red: 153/255, green: 128/255, blue: 250/255, alpha: 0.2).cgColor
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.find_DarkPurple.cgColor
            cell.layer.borderWidth = 1.0
            
            
            if profileImages[indexPath.row].images != [] {
                //이미지 있는 경우
                cell.profileImg.image = profileImages[indexPath.row].images[0]
                cell.receivedInt = receivedInt
                editBtn.isHidden = false //사진이 있으면 수정버튼 활성화
            } else {
                //profileImages가 없는 경우
                cell.profileImg.isHidden = true
                //editBtn.isHidden = true //수정버튼 비활성화
            }
            return cell
            
        } else {
            //basicInfoCVCell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicInfoCVCell.identifier, for: indexPath)
                    as? BasicInfoCVCell else { return UICollectionViewCell()}
            
            cell.layer.cornerRadius = 10
            cell.layer.backgroundColor = UIColor.subGray6.cgColor
            cell.setStyle()
            cell.setCell(info: basicInfoData[indexPath.row])
            
            
            
            
            //cell.infoTextField.inputAccessoryView = toolbar
            //cell.infoTextField.inputView = schoolPicker
            
            return cell
        }
    }
}


extension ProfileWritingVC: UICollectionViewDelegateFlowLayout {
    // Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == profileCV {
            return CGSize(width: 70, height: 70)
        }
        else {
            return CGSize(width: (self.basicInfoCV.frame.width - 13)/2, height: 50)
            
        }
    }
    
    //위아래 라인 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == profileCV {
            return 0
        } else {
            return 12
        }
    }
    
    //옆 라인 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == profileCV {
            return 4
        } else {
            return 13
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == profileCV {
            //사진이 있는 경우
            if profileImages[indexPath.row].images != [] {
                
                let alert =  UIAlertController(title: "프로필 사진 변경", message: nil, preferredStyle: .actionSheet)
                let library =  UIAlertAction(title: "앨범에서 사진 선택", style: .default) { [self] (action) in openPhotoLibrary()}
                let deletePhoto =  UIAlertAction(title: "삭제", style: .default) { [self] (action) in
                    profileImages[indexPath.row].images.remove(at: receivedInt!)
                    
                    if receivedInt! != 0 {
                        receivedInt! -= 1
                    }
                    profileCV.reloadSections(IndexSet(1...2))
                }
                
                let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                
                alert.addAction(library)
                alert.addAction(deletePhoto)
                alert.addAction(cancel)
                
                self.parent?.present(alert, animated: true, completion: nil)
            }
            //사진이 없는 경우
            else {
                receivedInt = nil
                let alert =  UIAlertController(title: "프로필 사진 추가", message: nil, preferredStyle: .actionSheet)
                let library =  UIAlertAction(title: "앨범에서 사진 선택", style: .default) { (action) in self.openPhotoLibrary()
                }
                let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                
                alert.addAction(library)
                alert.addAction(cancel)
                self.parent?.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}


extension ProfileCVCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            //사진 추가
            self.parentViewController?.dismiss(animated: true, completion: nil)
        }
    }
}




extension ProfileWritingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == schoolPicker {
            return school.count
        }
        else if pickerView == mbtiPicker {
            return mbti.count
        }
        else if pickerView == heightPicker {
            return height.count
        }
        else if pickerView == bodyShapePicker {
            return bodyShape.count
        }
        else if pickerView == smokingPicker {
            return smoking.count
        }
        else if pickerView == religionPicker {
            return religion.count
        }
        else if pickerView == marriagePicker {
            return marriage.count
        }
        else if pickerView == drinkingPicker {
            return drinking.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == schoolPicker {
            return school[row]
        }
        else if pickerView == mbtiPicker {
            return mbti[row]
        }
        else if pickerView == heightPicker {
            return height[row]
        }
        else if pickerView == bodyShapePicker {
            return bodyShape[row]
        }
        else if pickerView == smokingPicker {
            return smoking[row]
        }
        else if pickerView == religionPicker {
            return religion[row]
        }
        else if pickerView == marriagePicker {
            return marriage[row]
        }
        else if pickerView == drinkingPicker {
            return drinking[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // BasicInfoCVCell.i.text = fruits[row]
    }

}
