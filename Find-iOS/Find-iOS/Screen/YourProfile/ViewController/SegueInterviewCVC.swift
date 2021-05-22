//
//  SegueInterviewCVC.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/19.
//

import UIKit

class SegueInterviewCVC: UICollectionViewCell {
    static let identifier = "SegueInterviewCVC"
    
    var currentCategory = ProfileCategory.pros
//
    @IBOutlet weak var interviewContentsTableView: UITableView!
    
    override func awakeFromNib() {
        interviewContentsTableView.dataSource = self
        interviewContentsTableView.delegate = self
        interviewContentsTableView.separatorStyle = .none
    }
}

extension SegueInterviewCVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let imgCell = tableView.dequeueReusableCell(withIdentifier: InterviewImgTVC.identifier, for: indexPath) as? InterviewImgTVC else { return UITableViewCell() }
            return imgCell
        }
        guard let answerCell = tableView.dequeueReusableCell(withIdentifier: InterviewAnswerTVC.identifier, for: indexPath) as? InterviewAnswerTVC else { return UITableViewCell() }
        
//        var currentIndexPath: Int = 0
//
//        switch currentCategory {
//        case .pros:
//            currentIndexPath = indexPath.row
//        case .love:
//            currentIndexPath = indexPath.row + 10
//        case .taste:
//            currentIndexPath = indexPath.row + 20
//        case .life:
//            currentIndexPath = indexPath.row + 30
//        }
        
//        answerCell.questionNumberLabel.text = "1"
//        answerCell.questionLabel.text = "매사에 낙천적이에요"
        
        return answerCell
    }
}

extension SegueInterviewCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        }
        return 120
    }
}
