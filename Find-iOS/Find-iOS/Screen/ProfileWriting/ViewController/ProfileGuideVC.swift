//
//  ProfileGuideVC.swift
//  Find-iOS
//
//  Created by Seri Park on 2021/05/29.
//

import UIKit

class ProfileGuideVC: UIViewController {
    
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var profileGuide: UILabel!
    @IBOutlet var recommendImg: UILabel!
    
    @IBOutlet var hashtagView1: UIView!
    @IBOutlet var hashtagLabel1: UILabel!
    
    @IBOutlet var hashtagView2: UIView!
    @IBOutlet var hashtagLabel2: UILabel!
    
    @IBOutlet var hashtagView3: UIView!
    @IBOutlet var hashtagLabel3: UILabel!
    
    @IBOutlet var infoView1: UIView!
    @IBOutlet var infoLabel1: UILabel!
    
    @IBOutlet var notRecommendImg: UILabel!
    
    @IBOutlet var hashtagView4: UIView!
    @IBOutlet var hashtagLabel4: UILabel!
    
    @IBOutlet var hashtagView5: UIView!
    @IBOutlet var hashtagLabel5: UILabel!
    
    @IBOutlet var infoView2: UIView!
    @IBOutlet var infoLabel2: UILabel!
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        //이전 화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
}

extension ProfileGuideVC {
    func setStyle() {
        profileGuide.text = "프로필가이드"
        profileGuide.font = UIFont.spoqaMedium(size: 18)
        profileGuide.textColor = UIColor.subGray3
        profileGuide.letterSpacing = -0.54
        
        recommendImg.text = "추천하는 사진"
        recommendImg.font = UIFont.spoqaLight(size: 22)
        recommendImg.textColor = UIColor.subGray3
        recommendImg.letterSpacing = -1.1
        
        notRecommendImg.text = "추천하지 않는 사진"
        notRecommendImg.font = UIFont.spoqaLight(size: 22)
        notRecommendImg.textColor = UIColor.subGray3
        notRecommendImg.letterSpacing = -1.1
        
        func hashtagViewStyle(view: UIView, title: UILabel) {
            view.clipsToBounds = true
            view.layer.cornerRadius = 15
            view.backgroundColor = .white
            view.setBorder(borderColor: .find_Purple, borderWidth: 1)
            title.font = UIFont.spoqaRegular(size: 14)
            title.textColor = .find_Purple
            title.letterSpacing = -0.7
        }
        
        hashtagViewStyle(view: hashtagView1, title: hashtagLabel1)
        hashtagLabel1.text = "# 이목구비가 선명하게 나온 사진"
        
        hashtagViewStyle(view: hashtagView2, title: hashtagLabel2)
        hashtagLabel2.text = "# 분위기 있는 바스트 샷"
        
        hashtagViewStyle(view: hashtagView3, title: hashtagLabel3)
        hashtagLabel3.text = "# 자연스러운 활동 사진"
        
        hashtagViewStyle(view: hashtagView4, title: hashtagLabel4)
        hashtagLabel4.text = "# 좋지 않은 화질"
        
        hashtagViewStyle(view: hashtagView5, title: hashtagLabel5)
        hashtagLabel5.text = "# 과도한 필터나 스티커"
        
        func purpleViewStyle(view: UIView, title: UILabel) {
            view.clipsToBounds = true
            view.layer.cornerRadius = 10
            view.backgroundColor = .find_LightPurple
            title.font = UIFont.spoqaLight(size: 14)
            title.letterSpacing = -0.7
            title.textColor = .subGray3
            title.lineSpacing(lineSpacing: 2.2)
            title.textAlignment = .center
        }
        
        purpleViewStyle(view: infoView1, title: infoLabel1)
        infoLabel1.text = "패션 센스가 돋보이는 사진,\n관심사 또는 취미에 열중하는 사진 등\n분위기를 보여줄 수 있는 사진이 매칭률을 높여줍니다.\n좋은 화질은 상대를 위한 기본!"
        
        
        purpleViewStyle(view: infoView2, title: infoLabel2)
        infoLabel2.text = "과한 필터나 스티커를 사용한 사진,\n화질이 좋지 않는 사진은 매칭률을 떨어뜨려요!"
    }
    
    
    
    
}
