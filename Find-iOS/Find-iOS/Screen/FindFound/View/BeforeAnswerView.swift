//
//  BeforeAnswerView.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/29.
//

import UIKit

class BeforeAnswerView: UIView {
    
    @IBOutlet weak var valueSelectBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nib = UINib(nibName: "BeforeAnswerView", bundle: Bundle.main)
        
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return}
        
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        
        valueSelectBtn.makeRounded(cornerRadius: 20)
        
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
    @IBAction func valueSelectBtnClilcked(_ sender: Any) {
        let parentViewController: UIViewController = self.parentViewController!
  
        let storyBoard = UIStoryboard(name: "ValueList", bundle: nil)

        guard let dvc = storyBoard.instantiateViewController(identifier: "ValueListVC") as? ValueListVC else { return }

        dvc.modalPresentationStyle = .fullScreen
        dvc.tabBarController?.tabBar.isHidden = true
        parentViewController.navigationController?.pushViewController(dvc, animated: false)
    }
}
