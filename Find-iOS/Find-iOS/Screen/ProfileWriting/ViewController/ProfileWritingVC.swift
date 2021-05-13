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
    @IBOutlet var pictureGuide: UIButton!
    
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
    
    @IBOutlet var nickname: UILabel!
    @IBOutlet var nicknameTextField: UITextField!
    
    @IBOutlet var birthday: UILabel!
    @IBOutlet var birthdayTextField: UITextField!
    
    @IBOutlet var gender: UILabel!
    @IBOutlet var genderTextField: UITextField!
    
    @IBOutlet var region: UILabel!
    @IBOutlet var regionTextField: UITextField!
    
    @IBOutlet var basicInfo: UILabel!
    @IBOutlet var basicInfoExplain: UILabel!
    
    @IBOutlet var job: UILabel!
    @IBOutlet var jobTextField: UITextField!
    
    @IBOutlet var company: UILabel!
    @IBOutlet var companyTextField: UITextField!
    
    @IBOutlet var education: UILabel!
    @IBOutlet var educationTextField: UITextField!
    
    @IBOutlet var mbti: UILabel!
    @IBOutlet var mbtiTextField: UITextField!
    
    @IBOutlet var height: UILabel!
    @IBOutlet var heightTextField: UITextField!
    
    @IBOutlet var bodyShape: UILabel!
    @IBOutlet var bodyShapeTextField: UITextField!
    
    @IBOutlet var smoking: UILabel!
    @IBOutlet var smokingTextField: UITextField!
    
    @IBOutlet var religion: UILabel!
    @IBOutlet var religionTextField: UITextField!
    
    @IBOutlet var marriage: UILabel!
    @IBOutlet var marriageTextField: UITextField!
    
    @IBOutlet var drinking: UILabel!
    @IBOutlet var drinkingTextField: UITextField!
    // MARK:- IBAction
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
        setView()
        self.profileCollectionView.delegate = self
        self.profileCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
        profileCollectionView.register(nibName, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        
        nicknameTextField.layer.borderColor = UIColor.subGray6.cgColor
        nicknameTextField.layer.borderWidth = 0.0
        nicknameTextField.backgroundColor = UIColor.subGray6
    }
    
}

extension ProfileWritingVC {
    func setHeader() {
        profileWriting.text = "프로필 작성"
        //profileWriting.font = UIFont.spoqaMedium(size: 18)
        profileWriting.textColor = UIColor.subGray3
    }
    
    func setView() {
        profilePicture.text = "프로필 사진"
        //profilePicture.font = UIFont.spoqaMedium(size: 18)
        profilePicture.textColor = UIColor.subGray3
        
        pictureExplain.text = "프로필 사진은 최소 3장 이상 업로드 해주세요! (최대6장)"
        //pictureExplain.font = UIFont.spoqaMedium(size: 18)
        pictureExplain.textColor = UIColor.find_Purple
        
        identityVerify.text = ""
        
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
