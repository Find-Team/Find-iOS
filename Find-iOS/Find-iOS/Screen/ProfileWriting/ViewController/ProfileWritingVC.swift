//
//  ProfileWritingVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit

class ProfileWritingVC: UIViewController {
    static let identifier = "ProfileWritingVC"
    // MARK:- Variable Part
    
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var profileWriting: UILabel!
    @IBOutlet var completeBtn: UIButton!
    
    @IBOutlet var profilePicture: UILabel!
    @IBOutlet var pictureExplain: UILabel!
    @IBOutlet var pictureGuide: UIButton!
    
    
    // MARK:- IBAction

    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
    

}
    
}

extension ProfileWritingVC {
    func setHeader() {
        profileWriting.text = "프로필 작성"
        //profileWriting.font = UIFont.spoqaMedium(size: 18)
        profileWriting.textColor = UIColor.subGray3
    }
}
