//
//  ProfileWritingVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit

class ProfileWritingVC: UIViewController {
    static let identifier = "ProfileWritingVC"
    // MARK:- Variable Part
    
    var numberOfCell: Int = 3
    
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var profileWriting: UILabel!
    @IBOutlet var completeBtn: UIButton!
    
    @IBOutlet var profilePicture: UILabel!
    @IBOutlet var pictureExplain: UILabel!
    @IBOutlet var pictureGuideBtn: UIButton!
    
    @IBOutlet var profileCollectionView: UICollectionView!
    @IBOutlet var imagePreview: UIImageView!
    
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
    
    @IBOutlet var jobBox: UIView!
    @IBOutlet var job: UILabel!
    @IBOutlet var jobTextField: UITextField!
    
    @IBOutlet var companyBox: UIView!
    @IBOutlet var company: UILabel!
    @IBOutlet var companyTextField: UITextField!
    
    @IBOutlet var educationBox: UIView!
    @IBOutlet var education: UILabel!
    @IBOutlet var educationTextField: UITextField!
    
    @IBOutlet var mbtiBox: UIView!
    @IBOutlet var mbti: UILabel!
    @IBOutlet var mbtiTextField: UITextField!
    
    @IBOutlet var heightBox: UIView!
    @IBOutlet var height: UILabel!
    @IBOutlet var heightTextField: UITextField!
    
    @IBOutlet var bodyShapeBox: UIView!
    @IBOutlet var bodyShape: UILabel!
    @IBOutlet var bodyShapeTextField: UITextField!
    
    @IBOutlet var smokingBox: UIView!
    @IBOutlet var smoking: UILabel!
    @IBOutlet var smokingTextField: UITextField!
    
    @IBOutlet var religionBox: UIView!
    @IBOutlet var religion: UILabel!
    @IBOutlet var religionTextField: UITextField!
    
    @IBOutlet var marriageBox: UIView!
    @IBOutlet var marriage: UILabel!
    @IBOutlet var marriageTextField: UITextField!
    
    @IBOutlet var drinkingBox: UIView!
    @IBOutlet var drinking: UILabel!
    @IBOutlet var drinkingTextField: UITextField!
    
    
    // MARK:- IBAction
    
    @IBAction func goToIntroduction(_ sender: Any) {
        //Introduction 로 이동
        guard let IntroductionVC = self.storyboard?.instantiateViewController(identifier: "IntroductionVC") as? IntroductionVC else {
            return
        }
        IntroductionVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(IntroductionVC, animated: true)
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        setHeader()
        setView()
        setAccountInfo()
        setBasicInfo()
        
        self.profileCollectionView.delegate = self
        self.profileCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
        profileCollectionView.register(nibName, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        
    }
    
}

extension ProfileWritingVC {
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
        
        setBoxRadius(box: jobBox)
        job.text = "직업"
        setTitleFont(title: job)
        
        setBoxRadius(box: companyBox)
        company.text = "회사"
        setTitleFont(title: company)
        
        setBoxRadius(box: educationBox)
        education.text = "학력"
        setTitleFont(title: education)
        
        setBoxRadius(box: mbtiBox)
        mbti.text = "MBTI"
        setTitleFont(title: mbti)
        
        setBoxRadius(box: heightBox)
        height.text = "키"
        setTitleFont(title: height)
        
        setBoxRadius(box: bodyShapeBox)
        bodyShape.text = "체형"
        setTitleFont(title: bodyShape)
        
        setBoxRadius(box: smokingBox)
        smoking.text = "흡연여부"
        setTitleFont(title: smoking)
        
        setBoxRadius(box: religionBox)
        religion.text = "종교"
        setTitleFont(title: religion)
        
        setBoxRadius(box: marriageBox)
        marriage.text = "결혼여부"
        setTitleFont(title: marriage)
        
        setBoxRadius(box: drinkingBox)
        drinking.text = "주량"
        setTitleFont(title: drinking)
    }
    
    
    
    
    
    
}

extension ProfileWritingVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        
        return cell
    }
    
    //동적으로 셀의 갯수를 늘림. (언제? didSelectItem)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        numberOfCell += 1
        collectionView.reloadData()
    }
    
    
}


extension ProfileWritingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func
    collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0) }
    }
