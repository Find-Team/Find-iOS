//
//  BeforeTestView.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/14.
//

import UIKit

class BeforeTestView: UIView {
    @IBOutlet weak var testBtn: UIButton! {
        didSet{
            testBtn.backgroundColor = .find_Purple
            testBtn.makeRounded(cornerRadius: 20.0)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nib = UINib(nibName: "BeforeTestView", bundle: Bundle.main)
        
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return}
        
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder: ) has not been implemented")
//    }

}
