//
//  FoundVC.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/13.
//

import UIKit

class FoundVC: UIViewController {

    @IBOutlet weak var foundProfileCardCV: UICollectionView!
    
    private var profileList : [ProfileCardDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfileList()
        foundProfileCardCV.delegate = self
        foundProfileCardCV.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func setProfileList() {
        profileList.append(contentsOf: [
            ProfileCardDataModel(img: "https://i1.sndcdn.com/avatars-ClU5DJwEgXBRj1MR-Kplo0g-t240x240.jpg", name: "김석진", information: "킹갓제너럴핸썸가이", introduction: "쩔었다"),
            ProfileCardDataModel(img: "https://i.ytimg.com/vi/ZbfBEAJpin8/maxresdefault.jpg", name: "이진기", information: "두부온리다는온뉴", introduction: "사랑했다.."),
            ProfileCardDataModel(img: "https://t1.daumcdn.net/liveboard/subusunews/6c8d4b163e314b928b9058aebdef5ddf.png", name: "손셔누", information: "몬엑엘리게이터", introduction: "호락호락하지않은바보")
        ])
    }

}

extension FoundVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let profileCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: FoundProfileCardCVC.identifier, for: indexPath) as? FoundProfileCardCVC else {return UICollectionViewCell()}
        // set Data 함수 추후에 추가
        profileCardCell.setCellView()
        profileCardCell.setProfileCardData(
            img: profileList[indexPath.row].img,
            name: profileList[indexPath.row].name,
            information: profileList[indexPath.row].information,
            introduction: profileList[indexPath.row].introduction)
        return profileCardCell
    }
}

extension FoundVC: UICollectionViewDelegate {
    
}

extension FoundVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width-30
        return CGSize(width: width, height: width*300/345)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
