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
        setTabBar()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - 탭바 만드는 함수
    func setTabBar() {
        
        self.tabBar.tintColor = UIColor.find_DarkPurple
        self.tabBar.frame.size.height = 49
        
        
        // 마이페이지탭
        let MyPage = UIStoryboard.init(name: "MyProfile", bundle: nil)
        guard let firstTab = MyPage.instantiateViewController(identifier: "MyProfileNC") as? MyProfileNC  else { return }
        firstTab.tabBarItem.image = UIImage(named: "ic1Tab")
        firstTab.tabBarItem.selectedImage = UIImage(named: "icTab1Selected")
        
        
        // 상대찾기 탭
        let ShowMore = UIStoryboard.init(name: "FindFound", bundle: nil)
        guard let secondTab = ShowMore.instantiateViewController(identifier: "FindFoundNC") as? FindFoundNC  else { return }
        secondTab.tabBarItem.image = UIImage(named: "ic2Tab")
        secondTab.tabBarItem.selectedImage = UIImage(named: "icTab2Selected")
        
        // 매칭 탭
        let Matching = UIStoryboard.init(name: "MatchingStatus", bundle: nil)
        guard let thirdTab = Matching.instantiateViewController(identifier: "MatchingStatusNC") as? MatchingStatusNC  else { return }
        thirdTab.tabBarItem.image = UIImage(named: "ic3Tab")
        thirdTab.tabBarItem.selectedImage = UIImage(named: "icTab3selected")
        
        // 예약하기 탭
        //        let Matching = UIStoryboard.init(name: "", bundle: nil)
        //        guard let firstTab = Matching.instantiateViewController(identifier: "") as? _  else { return }
        //        thirdTab.tabBarItem.image = UIImage(named: "ic1Tab")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        //        thirdTab.tabBarItem.selectedImage = UIImage(named: "icTab1Selected")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        
        let tabs =  [firstTab, secondTab, thirdTab]
        
        tabBar.layer.shadowOpacity = 0
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.barTintColor = .white
        tabBarItem.imageInsets = UIEdgeInsets(top: 13, left: 0, bottom: -13, right: 0)
        self.title = nil;
        self.setViewControllers(tabs, animated: false)
    }
}
