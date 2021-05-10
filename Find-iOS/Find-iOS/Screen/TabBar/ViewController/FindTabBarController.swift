//
//  FindTabBarController.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit

class FindTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - 탭바 만드는 함수
    func setTabBar() {
        
        self.tabBar.tintColor = UIColor.black
        self.tabBar.frame.size.height = 49
        
        
        // 마이페이지탭
        let MyPage = UIStoryboard.init(name: "MyProfile", bundle: nil)
        guard let firstTab = MyPage.instantiateViewController(identifier: "MyProfileVC")
                as? MyProfileVC  else {
            return
        }
        firstTab.tabBarItem.image = UIImage(named: "ic1Tab")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        firstTab.tabBarItem.selectedImage = UIImage(named: "icTab1Selected")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        
        
        // 상대찾기 탭
        let ShowMore = UIStoryboard.init(name: "FindFound", bundle: nil)
        guard let secondTab = ShowMore.instantiateViewController(identifier: "FindFound")
                as? FIndFoundVC  else {
            return
        }
        secondTab.tabBarItem.image = UIImage(named: "ic2Tab")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        secondTab.tabBarItem.selectedImage = UIImage(named: "icTab2Selected")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        
        
        let tabs =  [firstTab, secondTab]
        
        tabBar.layer.shadowOpacity = 0
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.barTintColor = .white
        self.setViewControllers(tabs, animated: false)
    }
}
