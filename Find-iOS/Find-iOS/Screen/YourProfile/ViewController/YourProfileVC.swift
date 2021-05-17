//
//  YourProfileVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit

class YourProfileVC: UIViewController {

    @IBOutlet weak var fulllScrollView: UIScrollView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var starBtn: UIButton!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var criteriaView: UIView!
    @IBOutlet weak var criteriaLabel: UILabel!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var introductionView: UIView!
    @IBOutlet weak var introductionContentView: UIView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var informationLabel1: UILabel!
    @IBOutlet weak var informationLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    
    func setView() {
        introductionContentView.makeRounded(cornerRadius: 10)
    }

    func showToast(message : String, font: UIFont = UIFont.spoqaRegular(size: 14)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 145, height: 35))
        toastLabel.backgroundColor = UIColor.find_DarkPurple.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: { toastLabel.alpha = 0.0 }, completion: {(isCompleted) in toastLabel.removeFromSuperview() }) }

    @IBAction func starBtnClicked(_ sender: Any) {
        showToast(message: "상대를 찜했습니다")
    }
    
}
