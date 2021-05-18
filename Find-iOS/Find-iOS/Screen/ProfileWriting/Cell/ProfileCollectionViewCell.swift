//
//  ProfileCollectionViewCell.swift
//  Find-iOS
//
//  Created by Seri Park on 2021/05/12.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"
    
    @IBOutlet var addPhotoBtns: [UIButton]!
    @IBOutlet var interviewImages: [UIImageView]?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBtnStyle()
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
        
    }
    
    func setBtnStyle(){
        for i in 0...2{
            addPhotoBtns[i].makeRounded(cornerRadius: 10)
            addPhotoBtns[i].backgroundColor = UIColor.find_LightPurple
            addPhotoBtns[i].layer.borderWidth = 1
            addPhotoBtns[i].layer.borderColor = UIColor.find_Purple.cgColor
            interviewImages?[i].makeRounded(cornerRadius: 9)
        }
    }
    
    @IBAction func firstBtnTapped(_ sender: Any) {
        if interviewImages?[0].image == nil {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showPhotoSheet"),object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "previewImageNoti"),object: 0)
        }
    }

    @IBAction func secBtnTapped(_ sender: Any) {
        if interviewImages?[1].image == nil{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showPhotoSheet"),object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "previewImageNoti"),object: 1)
        }
    }

    @IBAction func thirdBtnTapped(_ sender: Any) {
        if interviewImages?[2].image == nil{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showPhotoSheet"),object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "previewImageNoti"),object: 2)
        }
    }
}






