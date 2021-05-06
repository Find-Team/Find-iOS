//
//  ValueTestVC.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/07.
//

import UIKit

class ValueTestVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet var viewTitleLabel: UILabel!
    @IBOutlet var backBtn: UIButton!
    
    @IBOutlet var segueIndicator: [UIView]!
    @IBOutlet var segueRelationshipLabel: UILabel!
    @IBOutlet var segueFamilyLabel: UILabel!
    @IBOutlet var segueCareerLabel: UILabel!
    
    @IBOutlet var questionView: UIView!
    
    
    //MARK: - Lifecylcle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARL: - IBActions
}


extension ValueTestVC {
    
    //MARK: - Style
    
    func setQuestionView() {
        questionView.makeRounded(cornerRadius: 10)
//        questionView.backgroundColor =
    }
    
    
    //MARK: - Functions
    
    func RelationshipSelected() {
        segueIndicator[0].backgroundColor = .purple
        segueIndicator[1].backgroundColor = .gray
        segueIndicator[2].backgroundColor = .gray
        
    }
    
    func FamilySelected() {
        segueIndicator[0].backgroundColor = .gray
        segueIndicator[1].backgroundColor = .purple
        segueIndicator[2].backgroundColor = .gray
    }
    
    func CareerSelected() {
        segueIndicator[0].backgroundColor = .gray
        segueIndicator[1].backgroundColor = .gray
        segueIndicator[2].backgroundColor = .purple
    }
    
    
}
