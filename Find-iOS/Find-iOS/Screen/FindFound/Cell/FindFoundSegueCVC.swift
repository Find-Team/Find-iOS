//
//  FindFoundSegueCVC.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/21.
//

import UIKit

class FindFoundSegueCVC: UICollectionViewCell {
    static let identifier = "FindFoundSegueCVC"
    
    var currentCategory = FindFoundCategory.find
    
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myFindView: UIView!
    @IBOutlet weak var myFoundView: UIView!
    
}
