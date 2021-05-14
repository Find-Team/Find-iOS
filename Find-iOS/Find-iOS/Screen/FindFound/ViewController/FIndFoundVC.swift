//
//  FIndFoundVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit

class FIndFoundVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var segmentView: CustomSegmentedControl! {
        didSet{
            segmentView.setButtonTitles(buttonTitles: ["Find","Found"])
            segmentView.selectorViewColor = .find_DarkPurple
            segmentView.selectorTextColor = .find_DarkPurple
        }
    }
    @IBOutlet weak var externalSV: UIScrollView!
    @IBOutlet weak var findSV: UIScrollView!
    @IBOutlet weak var foundSV: UIScrollView!
    
    var changingIndex = false
    let screenWidth = UIScreen.main.bounds.size.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50), buttonTitle: ["Find","Found"])
        codeSegmented.backgroundColor = .clear
        view.addSubview(codeSegmented)
        // Do any additional setup after loading the view.
    }
    
    func setDelegates() {
        externalSV.delegate = self
        findSV.delegate = self
        foundSV.delegate = self
        segmentView.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FIndFoundVC: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        changingIndex = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == externalSV {
            if !changingIndex {
                segmentView.setIndex(index: Int(round(externalSV.contentOffset.x / externalSV.frame.size.width)))
            }
            
            if scrollView.contentOffset.x < 0 {
                // contentOffset.x 값을 왼쪽 최소값인 0으로 설정
                scrollView.contentOffset.x = 0
            }
            // 스크롤 영역보다 오른쪽으로 (375초과값으로) 스크롤 될 때
            else if scrollView.contentOffset.x > screenWidth {
                // contentOffset.x 값을 오른쪽 최대값인 375로 설정
                scrollView.contentOffset.x = screenWidth
            }
        }
    }
}

extension FIndFoundVC: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        changingIndex = true
        let x = segmentView.selectedIndex * Int(externalSV.frame.width)
        externalSV.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
        print(externalSV.contentInset.left)
    }
}
