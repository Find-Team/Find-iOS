//
//  ProfileWritingVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit

class ProfileWritingVC: UIViewController {
    
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
        setView()

    }
    

}

extension ProfileWritingVC {
    
    func setView() {
        profileWriting.text = "프로필 작성"
        
        
    }
    
    
    
    
    
    
    
    
    
}
