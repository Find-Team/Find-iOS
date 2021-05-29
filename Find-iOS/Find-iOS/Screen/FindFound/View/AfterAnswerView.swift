//
//  AfterAnswerView.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/30.
//

import UIKit

class AfterAnswerView: UIView {

    @IBOutlet weak var firstValueView: UIView!
    @IBOutlet weak var SecondValueView: UIView!
    @IBOutlet weak var thirdValueView: UIView!
    @IBOutlet weak var fourthValueView: UIView!
    @IBOutlet weak var fifthValueView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nib = UINib(nibName: "AfterAnswerView", bundle: Bundle.main)
        
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return}
        
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        
        firstValueView.makeRounded(cornerRadius: 15)
        SecondValueView.makeRounded(cornerRadius: 15)
        thirdValueView.makeRounded(cornerRadius: 15)
        fourthValueView.makeRounded(cornerRadius: 15)
        fifthValueView.makeRounded(cornerRadius: 15)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func editBtnClicked(_ sender: Any) {
        let parentViewController: UIViewController = self.parentViewController!
  
        let storyBoard = UIStoryboard(name: "ValueList", bundle: nil)

        guard let dvc = storyBoard.instantiateViewController(identifier: "ValueListVC") as? ValueListVC else { return }

        dvc.modalPresentationStyle = .fullScreen
        dvc.tabBarController?.tabBar.isHidden = true
        parentViewController.navigationController?.pushViewController(dvc, animated: false)
    }
}
