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

    @IBAction func goToValueTest(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "ValueTest", bundle: nil)
        let dvc = storyBoard.instantiateViewController(identifier: "ValueTestVC")
        let currentController = self.getCurrentViewController()
        print(currentController)
//        currentController?.navigationController?.pushViewController(dvc, animated: true)
        dvc.modalPresentationStyle = .fullScreen
        currentController?.present(dvc, animated: true, completion: nil)
        print("하이")
    }

}
