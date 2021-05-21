//
//  MatchingLottieVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/17.
//

import UIKit
import Lottie

enum MatchingType {
    case similerPerson, oppositePerson
}

class MatchingLottieVC: UIViewController {
    
    var matchingType: MatchingType = .similerPerson

    @IBOutlet var searchingLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var loadingAnimationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayLoadingLottie()
        setLabelStyle()
    }

}

extension MatchingLottieVC {
    /// 로딩 로티 생성
    func displayLoadingLottie() {
        loadingAnimationView.backgroundColor = .clear
        
        loadingAnimationView.animation = Animation.named("10649-gradient-loading")
        loadingAnimationView.contentMode = .scaleAspectFit
        loadingAnimationView.center = self.view.center
        loadingAnimationView.loopMode = .loop
        loadingAnimationView.play()
    }
    
    /// 라벨 스타일 지정
    func setLabelStyle() {
        searchingLabel.text = "검색중..."
        searchingLabel.font = .spoqaMedium(size: 22)
        searchingLabel.textColor = .white
        searchingLabel.letterSpacing = -0.66
        
        descriptionLabel.font = .spoqaRegular(size: 22)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineSpacing(lineSpacing: 5)
        descriptionLabel.textAlignment = .center
        descriptionLabel.letterSpacing = -0.66
        
        
        switch matchingType {
        case .similerPerson: /// 상호유사성 검색 시
            descriptionLabel.text = "당신과 닮은 점이\n많은 사람을\n찾고 있어요...!"
        case .oppositePerson: /// 상호보완성 검사 시
            descriptionLabel.text = "당신과 다르기에\n매력적인 사람을\n찾고 있어요...!"
        }
        
    }
}
