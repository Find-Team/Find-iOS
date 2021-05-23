//
//  MatchingFooter.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/21.
//

import UIKit

class MatchingFooter: UITableViewHeaderFooterView {
    static let identifier = "MatchingFooter"
    
    @IBOutlet weak var showMoreBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MatchingFooter", bundle: nil)
        
    }
    
    @IBAction func showMoreTapped(_ sender: Any) {
        print("tapped")
    }
    private func setStyle() {
        showMoreBtn.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
