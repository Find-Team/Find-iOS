//
//  FoundView.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/21.
//

import UIKit

class FoundView: UIView {
    
    @IBOutlet weak var foundProfileCardCV: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nib = UINib(nibName: "FoundView", bundle: Bundle.main)
        
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return}
        
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        
        foundProfileCardCV.dataSource = self
        foundProfileCardCV.delegate = self
        foundProfileCardCV.register(UINib(nibName: "FoundProfileCardCVCell", bundle: .main), forCellWithReuseIdentifier: "FoundProfileCardCVCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoundProfileCardCVCell", for: indexPath) as? FoundProfileCardCVCell else { return UICollectionViewCell() }
        print("파운드뷰뷰",cell.checkLike)
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
