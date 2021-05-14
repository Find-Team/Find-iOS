//
//  YourProfileVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit

class YourProfileVC: UIViewController {

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
