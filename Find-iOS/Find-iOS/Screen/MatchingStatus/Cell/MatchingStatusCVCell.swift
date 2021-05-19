//
//  MatchingStatusCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

class MatchingStatusCVCell: UICollectionViewCell {
    static let identifier = "MatchingStatusCVCell"
    
    var curCategory: MatchingCategory?
    
    @IBOutlet weak var innerTV: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MatchingStatusCVCell", bundle: nil)
    }
}

extension MatchingStatusCVCell: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch curCategory {
        case .feelings:
            return 3
        case .dibs:
            return 2
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch curCategory {
        case .feelings:
            if section == 0 {
                return 3
            } else if section == 1 {
                return 5
            } else if section == 2 {
                return 5
            }
        case .dibs:
            if section == 0 {
                return 5
            } else if section == 1 {
                return 4
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
