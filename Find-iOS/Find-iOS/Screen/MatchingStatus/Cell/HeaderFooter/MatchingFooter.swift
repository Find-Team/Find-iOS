//
//  MatchingFooter.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/21.
//

import UIKit

// 어느 섹션의 푸터가 눌렸는지
enum WhereShowMore {
    case feelings, dibs1, dibs2, none
}

protocol ShowMoreFooter {
    /*
        필수 정의 변수
        var idxPaths = [IndexPath]() => 어떤 값들을 추가/삭제하여 셀을 확장/축소 할건지
        var isExpandable = false => 섹션이 확장 될 차례인지 축소 될 차례인지?
     */
    func showMoreTapped(iam: WhereShowMore)
    func doExpand(str: [ExpandableSection], section: Int) -> [ExpandableSection]
    func doInsert(tableView: UITableView, indexPaths: [IndexPath], section: Int?, str: [ExpandableSection]?)
    func doDelete(tableView: UITableView, indexPaths: [IndexPath], section: Int?, str: [ExpandableSection]?)
}

class MatchingFooter: UITableViewHeaderFooterView {
    static let identifier = "MatchingFooter"
    var whereSM: WhereShowMore? // 더보기 버튼 총 3개
    var delegate: ShowMoreFooter?
    
    @IBOutlet weak var showMoreBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MatchingFooter", bundle: nil)
    }
    
    @IBAction func showMoreTapped(_ sender: Any) {
        delegate?.showMoreTapped(iam: whereSM ?? .none)
    }
    private func setStyle() {
        showMoreBtn.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
    }
}
