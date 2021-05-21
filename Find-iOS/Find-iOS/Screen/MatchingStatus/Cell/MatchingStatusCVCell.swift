//
//  MatchingStatusCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

// MARK: - 매칭 현황 탭 Horizontal 컬렉션 뷰
class MatchingStatusCVCell: UICollectionViewCell {
    static let identifier = "MatchingStatusCVCell"
    
    var curCategory: MatchingCategory?
    
    @IBOutlet weak var innerTV: UITableView! {
        didSet {
            innerTV.delegate = self
            innerTV.dataSource = self
            innerTV.backgroundColor = .subGray6
            innerTV.register(ConnectedTVCell.nib(), forCellReuseIdentifier: ConnectedTVCell.identifier)
            innerTV.register(FeelingTVCell.nib(), forCellReuseIdentifier: FeelingTVCell.identifier)
            innerTV.register(DibsTVCell.nib(), forCellReuseIdentifier: DibsTVCell.identifier)
            innerTV.register(MatchingHeader.nib(), forHeaderFooterViewReuseIdentifier: "MatchingHeader")
            innerTV.register(MatchingFooter.nib(), forHeaderFooterViewReuseIdentifier: "MatchingFooter")
            innerTV.separatorStyle = .none
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setNoti()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MatchingStatusCVCell", bundle: nil)
    }
    
    func setNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeMatchingSegue), name: NSNotification.Name(rawValue:"changeMatchingSegue"), object: nil)
    }
    
    // MatchingStatusVC에서 세그 변경 감지
    @objc func changeMatchingSegue(notification: NSNotification) {
        let changeData = notification.object as? MatchingCategory
        curCategory = changeData
        print(curCategory)
        innerTV.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        innerTV.reloadData()
        
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
            if (section == 0) {
                return 3
            } else if (section == 1) || (section == 2) {
                return 1
            }
        case .dibs:
            if (section == 0) {
                return 5
            } else if (section == 1) {
                return 4
            }
        default:
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch curCategory {
        case .feelings:
            if (section == 0) {
                guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MatchingHeader") as? MatchingHeader else { return UIView() }
                header.headerLabel.text = "연결된 상대"
                return header
            } else {
                return nil
            }
        case .dibs:
            if (section == 0) {
                guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MatchingHeader") as? MatchingHeader else { return UIView() }
                header.headerLabel.text = "나를 찜한 사람"
                return header
            } else if (section == 1) {
                guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MatchingHeader") as? MatchingHeader else { return UIView() }
                header.headerLabel.text = "내가 찜한 사람"
                return header
            } else {
                return nil
            }
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch curCategory {
        case .feelings:
            if (section == 0 ) {
                return 43
            } else {
                return 0
            }
        case .dibs:
            return 43
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch curCategory {
        case .feelings:
            if (section == 0) {
                guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MatchingFooter") as? MatchingFooter else { return UIView() }
                return footer
            } else {
                return nil
            }
        case .dibs:
            guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MatchingFooter") as? MatchingFooter else { return UIView() }
            return footer
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch curCategory {
        case .feelings:
            if (section == 0) {
                return 60
            } else {
                return 0
            }
        case .dibs:
            return 53
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch curCategory {
        case .feelings:
            if (indexPath.section == 0) {
                guard let cntdCell = tableView.dequeueReusableCell(withIdentifier: "ConnectedTVCell", for: indexPath) as? ConnectedTVCell else { return UITableViewCell() }
                cntdCell.selectionStyle = .none
                return cntdCell
            } else {
                guard let feelCell = tableView.dequeueReusableCell(withIdentifier: "FeelingTVCell", for: indexPath) as? FeelingTVCell else { return UITableViewCell() }
                feelCell.selectionStyle = .none
                return feelCell
            }
        case .dibs:
            guard let dibsCell = tableView.dequeueReusableCell(withIdentifier: "DibsTVCell", for: indexPath) as? DibsTVCell else { return UITableViewCell() }
            dibsCell.selectionStyle = .none
            return dibsCell
        default:
            UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch curCategory {
        case .feelings:
            if (indexPath.section == 0) {
                return 144
            } else if (indexPath.section == 1) || (indexPath.section == 2) {
                return 333
            }
        case .dibs:
            return 116
        default:
            return 0
        }
        return 0
    }
}
