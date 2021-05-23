//
//  MatchingFooter.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/21.
//

import UIKit

enum WhereShowMore {
    case feelings, dibs1, dibs2
}
class MatchingFooter: UITableViewHeaderFooterView {
    static let identifier = "MatchingFooter"
    var whereSM: WhereShowMore? // 더보기 버튼 총 3개
    var isTapped = false
    
    @IBOutlet weak var showMoreBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MatchingFooter", bundle: nil)
        
    }
    
    @IBAction func showMoreTapped(_ sender: Any) {
        switch whereSM {
        case .feelings:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "whereShowMore"), object: connectedDatas)
        case .dibs1:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "whereShowMore"), object: receivedDibs)
        case .dibs2:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "whereShowMore"), object: sendedDibs)
        default:
            return
        }
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
