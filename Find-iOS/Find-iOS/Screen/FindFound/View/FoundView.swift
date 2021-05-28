//
//  FoundView.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/21.
//

import UIKit

class FoundView: UIView {
    
    var profileCardList: [FoundProfileCardData] = []
    
    @IBOutlet weak var foundProfileCardCV: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nib = UINib(nibName: "FoundView", bundle: Bundle.main)
        
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return}
        
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        
        setProfileCardList()
        
        foundProfileCardCV.dataSource = self
        foundProfileCardCV.delegate = self
        foundProfileCardCV.register(UINib(nibName: "FoundProfileCardCVCell", bundle: .main), forCellWithReuseIdentifier: "FoundProfileCardCVCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    
    func setProfileCardList() {
        profileCardList.append(contentsOf: [
            FoundProfileCardData(mainImg: UIImage(named: "더미2")!, name: "말랑말랑카우", information: "31살|회사원|외국계회사|서울 송파구", introduction: "현재 외국계 회사를 다니고 있고 재테크과 부업에 관심이"),
            FoundProfileCardData(mainImg: UIImage(named: "더미8")!, name: "체루당", information: "29살|사업가|앱서비스|서울 관악구", introduction: "일을 일찍 시작해서 벌써 육년차 사업가이네요"),
            FoundProfileCardData(mainImg: UIImage(named: "더미4")!, name: "썬킴", information: "33살|프리랜서|기타|서울 중구", introduction: "지금은 대학원에서 박사과정을 하고 있고 취업준비를 조금씩 하면서 프리랜서 일을 하고 있어요"),
            FoundProfileCardData(mainImg: UIImage(named: "더미5")!, name: "쿄호젤리", information: "28살|전문직|금융업계|경기 판교", introduction: "경제 전공이고 몇 년 뒤 개업을 위해 일과 공부를 병행하며 준비중입니다."),
            FoundProfileCardData(mainImg: UIImage(named: "더미6")!, name: "무야야호", information: "33살|회사원|IT회사|서울 광진구", introduction: "현재 일을 쉬면서 이직을 준비중입니다. 방송쪽에 관심이 많기도 했고 개발자로")
        ])
    }
    
    // rootViewController
    func getCurrentViewController() -> UIViewController? {
       if let rootController = UIApplication.shared.keyWindow?.rootViewController {
           var currentController: UIViewController! = rootController
           while( currentController.presentedViewController != nil ) {
               currentController = currentController.presentedViewController
           }
           return currentController
       }
       return nil
   }
    
    // parentViewController
    func getSuperViewController() -> UIViewController? {
        var viewController: UIViewController? = self.parentViewController
        return viewController
    }

}

extension FoundView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileCardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoundProfileCardCVCell", for: indexPath) as? FoundProfileCardCVCell else { return UICollectionViewCell() }
        cell.setProfileCardData(profileImg: profileCardList[indexPath.row].mainImg, name: profileCardList[indexPath.row].name, info: profileCardList[indexPath.row].information, intro: profileCardList[indexPath.row].introduction)
        cell.makeStarBtn()
        return cell
    }
}

extension FoundView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width-30
        return CGSize(width: width, height: width*438/345)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let storyBoard = UIStoryboard(name: "YourProfile", bundle: nil)
        let dvc = storyBoard.instantiateViewController(identifier: "YourProfileVC")
        let currentController = self.getSuperViewController()
        currentController?.navigationController?.pushViewController(dvc, animated: true)
    }
}
