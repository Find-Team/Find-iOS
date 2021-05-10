//
//  MyProfileVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit

class MyProfileVC: UIViewController {
    
    @IBOutlet weak var imageBackView: UIView!
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var preferBtn: UIButton!
    @IBOutlet weak var wholeBackView: UIView!
    @IBOutlet weak var myProfileCV: UICollectionView!{
        didSet{
            myProfileCV.delegate = self
            myProfileCV.dataSource = self
            myProfileCV.register(MyProfileCVCell.nib(), forCellWithReuseIdentifier: MyProfileCVCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    func setLayout(){
        imageBackView.makeRounded(cornerRadius: imageBackView.frame.height/2)
        previewBtn.makeRounded(cornerRadius: previewBtn.frame.height/2)
        preferBtn.makeRounded(cornerRadius: preferBtn.frame.height/2)
    }
}


extension MyProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyProfileCVCell.identifier, for: indexPath) as? MyProfileCVCell else{  return UICollectionViewCell() }
        
        if indexPath.row == 0{
            cell.setCell(imageName: "ic1", title: "프로필수정", percentage: "15%", shadowColor: .profileBlur)
        }else if indexPath.row == 1{
            cell.setCell(imageName: "ic2", title: "인터뷰하기", percentage: "0%", shadowColor: .interviewBlur)
        }else if indexPath.row == 2{
            cell.setCell(imageName: "ic3", title: "매너점수", percentage: "3.5점/5점", shadowColor: .mannerBlur)
        }else if indexPath.row == 3{
            cell.setCell(imageName: "ic4", title: "연결된 상대", percentage: "42명", shadowColor: .connectedBlur)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
    }
}
