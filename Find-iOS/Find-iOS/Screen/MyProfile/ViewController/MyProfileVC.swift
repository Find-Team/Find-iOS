//
//  MyProfileVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit

class MyProfileVC: UIViewController {
    
    @IBOutlet weak var imageBackView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var preferBtn: UIButton!
    @IBOutlet weak var wholeBackView: UIView!
    @IBOutlet weak var editProfileView: UIView!
    @IBOutlet weak var interviewView: UIView!
    @IBOutlet weak var connectedView: UIView!
    @IBOutlet weak var mannerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    func setLayout(){
        imageBackView.makeRounded(cornerRadius: imageBackView.frame.height/2)
        profileImageView.makeRounded(cornerRadius: profileImageView.frame.height/2)
        previewBtn.makeRounded(cornerRadius: previewBtn.frame.height/2)
        preferBtn.makeRounded(cornerRadius: preferBtn.frame.height/2)
        
        // 버튼 4개
        editProfileView.backgroundColor = .white
        editProfileView.makeRounded(cornerRadius: editProfileView.frame.height/2)
        editProfileView.dropShadow(color: .profileBlur, offSet: CGSize(width: 0, height: 4), opacity: 1, radius: 30)
        interviewView.backgroundColor = .white
        interviewView.makeRounded(cornerRadius: interviewView.frame.height/2)
        interviewView.dropShadow(color: .interviewBlur, offSet: CGSize(width: 0, height: 4), opacity: 1, radius: 30)
        connectedView.backgroundColor = .white
        connectedView.makeRounded(cornerRadius: connectedView.frame.height/2)
        connectedView.dropShadow(color: .connectedBlur, offSet: CGSize(width: 0, height: 4), opacity: 1, radius: 30)
        mannerView.backgroundColor = .white
        mannerView.makeRounded(cornerRadius: mannerView.frame.height/2)
        mannerView.dropShadow(color: .mannerBlur, offSet: CGSize(width: 0, height: 4), opacity: 1, radius: 30)
    }
    
    
}
