//
//  noDataTVCell.swift
//  Find-iOS
//
//  Created by Wonseok Lee on 2021/05/28.
//

import UIKit

class noDataTVCell: UITableViewCell {
    static let identifier = "noDataTVCell"
    @IBOutlet weak var descriptLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "noDataTVCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
