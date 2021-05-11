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
        setGesture()
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
    
    func setGesture(){
        let tapProfileEdit = UITapGestureRecognizer(target: self, action: #selector(self.goProfileEdit(_ :)))
        self.editProfileView.addGestureRecognizer(tapProfileEdit)
        
        let tapInterview = UITapGestureRecognizer(target: self, action: #selector(self.goInterview(_ :)))
        self.interviewView.addGestureRecognizer(tapInterview)
    }
    
    @objc private func goProfileEdit(_ gesture:UIGestureRecognizer)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "YourProfile", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "YourProfileVC") as? InterviewVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func goInterview(_ gesture:UIGestureRecognizer)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Interview", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "InterviewVC") as? InterviewVC {
            self.navigationController?.pushViewController(vc, animated: true)
            print("hi")
        }else{
            print("뷰컨 없음")
        }
    }
    @IBAction func previewProfile(_ sender: Any) {
        print("프로필 미리보기")
    }
    @IBAction func preferDay(_ sender: Any) {
        print("선호 일정")
    }
}
