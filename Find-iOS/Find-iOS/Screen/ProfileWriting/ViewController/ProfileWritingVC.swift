//
//  ProfileWritingVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit
import Photos

var profileImages: [ProfileImages] = [ProfileImages(images:[])] // 이미지

class ProfileWritingVC: UIViewController  {
    
    // MARK:- Custom Variable Part
    let picker = UIImagePickerController()
    var basicInfoData : [BasicInfoData] = []
    var imageSelected: UIImage?
    var currentIndexPath: Int?
    var representImgData : UIImage?
    
    var infoText : String = ""
    
    var nicknameData : String = "맹고감자"
    var birthdayData : String = "1998.10.22"
    var genderData : String = "여자"
    var regionData : String = "서울특별시 성북구"
    
    
    // MARK:- IBOutlet
    
    @IBOutlet var scrollView: UIScrollView!
    
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
    @IBOutlet var infoView: UIView!
    @IBOutlet var infoLabel: UILabel!
    
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
    @IBAction func gotoMain(_ sender: UIButton) {
        //MyProfileVC 로 이동
//        if inputData != "" {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InfoWritten"), object: inputData)
//        }
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func completeBtnPressed(_ sender: UIButton) {
        //showToastPurple(message: "저장되었습니다.")
        if representImgData != nil {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InfoWritten"), object: representImgData)
        }
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func goToIntroduction(_ sender: UIButton) {
        // IntroductionVC 로 이동
        let nextStoryboard = UIStoryboard(name: "Introduction", bundle: nil)
        guard let IntroductionVC = nextStoryboard.instantiateViewController(withIdentifier: "IntroductionVC") as? IntroductionVC else {return}
        self.navigationController?.pushViewController(IntroductionVC, animated: true)
    }
    
    
    @IBAction func gotoProfileGuide(_ sender: UIButton) {
        // IntroductionVC 로 이동
        let nextStoryboard = UIStoryboard(name: "ProfileGuide", bundle: nil)
        guard let ProfileGuideVC = nextStoryboard.instantiateViewController(withIdentifier: "ProfileGuideVC") as? ProfileGuideVC else {return}
        self.navigationController?.pushViewController(ProfileGuideVC, animated: true)
    }
    
    
    @IBAction func editBtnTapped(_ sender: Any) {
        // edit 버튼이 클릭되면
        let alert =  UIAlertController(title: "프로필 사진 변경", message: nil, preferredStyle: .actionSheet)
        let repSet = UIAlertAction(title: "대표사진 설정", style: .default) { [self] (action) in setRep()}
        let library =  UIAlertAction(title: "앨범에서 사진 선택", style: .default) { [self] (action) in openPhotoLibrary()}
        let deletePhoto =  UIAlertAction(title: "삭제", style: .default) { [self] (action) in
            if let indexPath = currentIndexPath {
                profileImages[indexPath].images.remove(at: 0)
            }
            previewImageView.image = nil
            profileCV.reloadData()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(repSet)
        alert.addAction(deletePhoto)
        alert.addAction(cancel)
        
        self.parent?.present(alert, animated: true, completion: nil)
    }
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        keyboardHide()
        setHeader()
        setProfileImg()
        setAccountInfo()
        setVerify()
        setInfoWriting()
        setAccountInfo()
        setBasicInfo()
        
        picker.delegate = self
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(infoReceived(_:)), name: NSNotification.Name("InfoWritten"), object: nil)
    }
}

// MARK:- extension

extension ProfileWritingVC {
    func setHeader() {
        profileWriting.text = "프로필 작성"
        profileWriting.font = UIFont.spoqaMedium(size: 18)
        profileWriting.textColor = UIColor.subGray3
        profileWriting.letterSpacing = -0.54
        
        completeBtn.setTitle("완료", for: .normal)
        completeBtn.titleLabel?.font = UIFont.spoqaRegular(size: 18)
        completeBtn.titleLabel?.letterSpacing = -0.54
        completeBtn.setTitleColor(UIColor.black, for: .normal)
    }
    
    func setProfileImg() {
        profilePicture.text = "프로필 사진"
        profilePicture.font = UIFont.spoqaLight(size: 22)
        profilePicture.textColor = UIColor.subGray3
        profileWriting.letterSpacing = -1.1
        
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
        pictureExplain.letterSpacing = -0.36
        
        previewView.makeRounded(cornerRadius: 10)
        previewView.backgroundColor = .subGray6
        previewLabel.textColor = .find_DarkPurple
        previewLabel.font = .spoqaRegular(size: 12)
        previewImageView.makeRounded(cornerRadius: 10)
        editBtn.makeRounded(cornerRadius: 10)
        editBtn.titleLabel?.font = UIFont.spoqaRegular(size: 12)
        editBtn.setTitleColor(UIColor.subGray6, for: .normal)
        editBtn.backgroundColor = .subGray1
        // editBtn.isHidden = true
    }
    func setVerify() {
        identityVerify.text = "본인 인증"
        identityVerify.font = UIFont.spoqaLight(size: 22)
        identityVerify.textColor = UIColor.subGray3
        identityVerify.letterSpacing = -1.1
        
        verifyBtn.clipsToBounds = true
        verifyBtn.layer.cornerRadius = 10
        verifyBtn.layer.borderWidth = 1.0
        verifyBtn.layer.borderColor = UIColor.find_DarkPurple.cgColor
        verifyBtn.layer.backgroundColor = UIColor.find_LightPurple.cgColor
        
        verifyBtn.setTitle("인증 완료", for: .normal)
        verifyBtn.titleLabel?.font = UIFont.spoqaMedium(size: 14)
        verifyBtn.titleLabel?.letterSpacing = -0.42
        verifyBtn.setTitleColor(UIColor.find_DarkPurple, for: .normal)
    }
    
    func setInfoWriting() {
        infoWriting.text = "소개글"
        infoWriting.font = UIFont.spoqaLight(size: 22)
        infoWriting.textColor = UIColor.subGray3
        infoWriting.letterSpacing = -1.1
        
        infoExplain.text = "당신을 소개해주세요! (최소 10자)"
        infoExplain.font = UIFont.spoqaRegular(size: 12)
        infoExplain.textColor = UIColor.find_DarkPurple
        infoExplain.letterSpacing = -0.36
        
        goToInfoBtn.clipsToBounds = true
        goToInfoBtn.layer.cornerRadius = 10
        goToInfoBtn.layer.borderWidth = 1.0
        goToInfoBtn.layer.borderColor = UIColor.find_DarkPurple.cgColor
        goToInfoBtn.layer.backgroundColor = UIColor.find_LightPurple.cgColor
        
        goToInfoBtn.setTitle("소개글 작성하러 가기", for: .normal)
        goToInfoBtn.titleLabel?.font = UIFont.spoqaMedium(size: 14)
        goToInfoBtn.titleLabel?.letterSpacing = -0.42
        goToInfoBtn.setTitleColor(UIColor.find_DarkPurple, for: .normal)
        
        infoView.isHidden = true
    }
    
    func setAccountInfo() {
        func setBoxStyle(box: UIView, title: UILabel, info: UILabel) {
            box.clipsToBounds = true
            box.layer.cornerRadius = 10
            title.font = UIFont.spoqaMedium(size: 13)
            title.textColor = UIColor.subGray3
            info.font = UIFont.spoqaRegular(size: 13)
            info.textColor = UIColor.subGray5
        }
        
        accountWriting.text = "계정 정보"
        accountWriting.font = UIFont.spoqaLight(size: 22)
        accountWriting.textColor = UIColor.subGray3
        accountWriting.letterSpacing = -1.1
        
        accountExplain.text = "가입시 기재된 정보로 변경이 불가합니다."
        accountExplain.font = UIFont.spoqaRegular(size: 12)
        accountExplain.textColor = UIColor.find_DarkPurple
        accountExplain.letterSpacing = -0.36
        
        setBoxStyle(box: nicknameView, title: nickname, info: nicknameInfo)
        nickname.text = "닉네임"
        nicknameInfo.text = nicknameData
        
        setBoxStyle(box: birthdayView, title: birthday, info: birthdayInfo)
        birthday.text = "생년월일"
        birthdayInfo.text = birthdayData
        
        setBoxStyle(box: genderView, title: gender, info: genderInfo)
        gender.text = "성별"
        genderInfo.text = genderData
        
        setBoxStyle(box: regionView, title: region, info: regionInfo)
        region.text = "지역"
        regionInfo.text = regionData
    }
    
    func setBasicInfo() {
        basicInfo.text = "기본 정보"
        basicInfo.font = UIFont.spoqaLight(size: 22)
        basicInfo.textColor = UIColor.subGray3
        basicInfo.letterSpacing = -1.1
        
        basicInfoExplain.text = "여기에 쓰는 글은 마이 프로필에 노출됩니다."
        basicInfoExplain.font = UIFont.spoqaRegular(size: 12)
        basicInfoExplain.textColor = UIColor.find_DarkPurple
        basicInfoExplain.letterSpacing = -0.36
    }
    
    func keyboardHide() {
        //스크롤뷰에서 view 누를 때 키보드 내리기
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    func setRep() {
        if let indexPath = currentIndexPath {
            profileImages[indexPath].isRep = true
            profileCV.selectItem(at: IndexPath(row: indexPath, section: 0), animated: true, scrollPosition: .init())
        }
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
    
    @objc func infoReceived(_ noti: Notification) {
        goToInfoBtn.isHidden = true
        infoView.isHidden = false
        infoView.backgroundColor = .subGray6
        infoView.makeRounded(cornerRadius: 10)
        
        infoText = noti.object as! String
        infoLabel.text = infoText
        infoLabel.textColor = .subGray3
        infoLabel.font = .spoqaRegular(size: 12)
        infoLabel.letterSpacing = 0.36
        
        self.view.layoutIfNeeded()
    }
}

// MARK:- UICollectionViewDataSource

extension ProfileWritingVC: UICollectionViewDataSource {
    //셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //profileCVCell
        if collectionView == profileCV {
            return 3
        } else {
            //basicInfoCVCell
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
            cell.setRepStyle()
            cell.layer.backgroundColor = UIColor(red: 153/255, green: 128/255, blue: 250/255, alpha: 0.2).cgColor
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.find_DarkPurple.cgColor
            cell.layer.borderWidth = 1.0
            
            if profileImages[indexPath.row].images != [] {
                //profileImages가 있는 경우
                cell.profileImg.isHidden = false
                cell.profileImg.image = profileImages[indexPath.row].images[0]
                //editBtn.isHidden = false //사진이 있으면 수정버튼 활성화
            } else {
                //profileImages가 없는 경우
                cell.profileImg.isHidden = true
                editBtn.isHidden = true
            }
            return cell
            
        } else {
            //basicInfoCVCell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicInfoCVCell.identifier, for: indexPath)
                    as? BasicInfoCVCell else { return UICollectionViewCell() }
            
            cell.layer.cornerRadius = 10
            cell.layer.backgroundColor = UIColor.subGray6.cgColor
            cell.setStyle()
            cell.setCell(info: basicInfoData[indexPath.row])

            
            //indexPath.row 2 이상이면 pickerView
            if indexPath.row >= 2 {
                cell.infoTextField.placeholder = "선택하세요"
                cell.createPickerView(idx: indexPath.row)
                cell.dismissPickerView()
                cell.infoTextField.tintColor = .clear
            } else {
                cell.infoTextField.placeholder = "입력하세요"
            }
            
            return cell
        }
    }
}


// MARK:- UICollectionViewDelegateFlowLayout

extension ProfileWritingVC: UICollectionViewDelegateFlowLayout {
    // Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == profileCV {
            //profileCVCell
            return CGSize(width: 70, height: 70)
        }
        else {
            //basicInfoCVCell
            return CGSize(width: (self.basicInfoCV.frame.width - 13)/2, height: 50)
            
        }
    }
    
    //위아래 라인 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == profileCV {
            //profileCVCell
            return 0
        } else {
            //basicInfoCVCell
            return 12
        }
    }
    
    //옆 라인 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == profileCV {
            //profileCVCell
            return 4
        } else {
            //basicInfoCVCell
            return 13
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if collectionView == profileCV {
            currentIndexPath = indexPath.row
        
            //사진이 있는 경우
            if profileImages[indexPath.row].images != [] {
                previewImageView.contentMode = .scaleAspectFill
                previewImageView.image = profileImages[indexPath.row].images[0]
            }
            //사진이 없는 경우
            else {
                let alert =  UIAlertController(title: "프로필 사진 추가", message: nil, preferredStyle: .actionSheet)
                let library =  UIAlertAction(title: "앨범에서 사진 선택", style: .default) { (action) in self.openPhotoLibrary()
                }
                let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                
                alert.addAction(library)
                alert.addAction(cancel)
                self.parent?.present(alert, animated: true, completion: nil)
            }
            
            if previewImageView.image != nil {
                editBtn.isHidden = false
            } else {
                editBtn.isHidden = true
            }
            
        }
    }
}

// MARK:- UIImagePickerControllerDelegate

extension ProfileWritingVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageSelected = image
            if let indexPath = currentIndexPath {
                if profileImages[indexPath].images == [] {
                    profileImages[indexPath].images.append(imageSelected!)
                } else {
                    profileImages[indexPath].images[0] = imageSelected!
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
        
        previewImageView.contentMode = .scaleAspectFill
        previewImageView.image = imageSelected
        profileCV.reloadData()
        
        self.parent?.dismiss(animated: true, completion: nil)
    }
}
