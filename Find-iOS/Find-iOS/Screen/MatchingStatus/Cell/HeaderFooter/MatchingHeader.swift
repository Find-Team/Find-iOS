//
//  MatchingHeader.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/21.
//

import UIKit

class MatchingHeader: UITableViewHeaderFooterView {
    static let identifier = "MatchingHeader"
    
    @IBOutlet weak var headerLabel: UILabel!
    
    // Interface Builder에서 객체가 init(coder:)로 초기화(인스턴스화)된 후 호출
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")
        setStyle()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MatchingHeader", bundle: nil)
    }
    
    private func setStyle() {
        let view: UIView = {
            let v = UIView(frame: .zero)
            v.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
            return v
        }()
        self.backgroundView = view
        headerLabel.textColor = .subGray5
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}
