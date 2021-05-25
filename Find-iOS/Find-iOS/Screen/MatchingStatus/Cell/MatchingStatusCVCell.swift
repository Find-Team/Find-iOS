//
//  MatchingStatusCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

// MARK: - 받은호감, 보낸호감 셀 분기처리 enum
enum feelingCell {
    case received, send
}

//enum Section {
//    case feelings, dibs
//}
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
        setExpandable()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MatchingStatusCVCell", bundle: nil)
    }
    
    // 더보기 안눌렀을 때에는 보여지는 cell 3개
    func setExpandable() {
        for i in 0...2 {
            connectedDatas[i].isExpanded = true
            receivedDibs[i].isExpanded = true
            sendedDibs[i].isExpanded = true
        }
    }
    
    // Noti 등록
    func setNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeMatchingSegue), name: NSNotification.Name(rawValue:"changeMatchingSegue"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showMore), name: NSNotification.Name(rawValue:"whereShowMore"), object: nil)
    }
    
    // MatchingStatusVC에서 세그 변경 감지
    @objc func changeMatchingSegue(notification: NSNotification) {
        let changeData = notification.object as? MatchingCategory
        curCategory = changeData
        UIView.performWithoutAnimation {
            innerTV.scrollToRow(at: IndexPath(index: 0), at: .top, animated: true)
            innerTV.reloadSections(IndexSet(0...2), with: .automatic)
        }
        // 지금은 테이블 뷰 전체를 reload해주는데 이 테이블 뷰가 메인뷰컨 컬렉션뷰의 셀이라서 탭바 넘길 때 정보가 같이 바뀌어서 부자연스러운거
        // 그래서 메인 뷰컨에 셀이 2개(탭바 갯수)니까 각각 리로드를 해준다면 자연스러워 질 것 같다.
        // 그 방법을 생각해보자
    }
    
    @objc func showMore(notification: NSNotification) {
        guard var whereShowMore = notification.object as? [ExpandableSection] else { return }
        var indexPaths = [IndexPath]()
        let section = whereShowMore[0].data.section!
        var isExpandable = false
        
        switch curCategory {
        case .feelings:
            connectedDatas = doExpand(str: &whereShowMore)
            if isExpandable { doInsert(section, connectedDatas) } else { doDelete(section, connectedDatas) }
        case .dibs:
            if section == 0 {
                receivedDibs = doExpand(str: &whereShowMore)
                if isExpandable { doInsert(section, receivedDibs) } else { doDelete(section, receivedDibs) }
            } else {
                sendedDibs = doExpand(str: &whereShowMore)
                if isExpandable { doInsert(section, sendedDibs) } else { doDelete(section, sendedDibs) }
            }
        default:
            return
        }
        
        func doExpand(str: inout [ExpandableSection]) -> [ExpandableSection]{
            // Ready to Expand
            if str[3].isExpanded ?? false {
                isExpandable = false
                for row in 3..<str.count {
                    let indexPath = IndexPath(row: row, section: section)
                    indexPaths.append(indexPath)
                    str[row].isExpanded = false
                }
            } else {
                // Ready to Collapse
                isExpandable = true
                for row in 3..<str.count {
                    let indexPath = IndexPath(row: row, section: section)
                    indexPaths.append(indexPath)
                    str[row].isExpanded = true
                }
            }
            return str
        }
        
        // Expandable
        func doInsert(_ sec: Int, _ obj: [ExpandableSection]) {
            if sec != 1 {
                innerTV.insertRows(at: indexPaths, with: .fade)
                innerTV.layoutIfNeeded()
            } else {
                innerTV.insertRows(at: indexPaths, with: .fade)
                innerTV.layoutIfNeeded()
                innerTV.scrollToRow(at: IndexPath(row: obj.count-1, section: section), at: .top, animated: true)
            }
        }
        
        // Collapsable
        func doDelete(_ sec: Int, _ obj: [ExpandableSection]) {
            innerTV.deleteRows(at: indexPaths, with: .fade)
            innerTV.layoutIfNeeded()
            innerTV.scrollToRow(at: IndexPath(row: 0, section: section), at: .none, animated: true)
        }
    }
}

// MARK: - Protocols
extension MatchingStatusCVCell: UITableViewDelegate, UITableViewDataSource {
    // 섹션 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // 섹션 별 셀 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch curCategory {
        case .feelings:
            if (section == 0) {
                return connectedDatas.filter{$0.isExpanded ?? false}.count
            } else if (section == 1) || (section == 2) {
                return 1
            }
        case .dibs:
            if (section == 0) {
                return receivedDibs.filter{$0.isExpanded ?? false}.count
            } else if (section == 1) {
                return sendedDibs.filter{$0.isExpanded ?? false}.count
            }
        default:
            return 0
        }
        return 0
    }
    
    // 섹션 별 셀 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch curCategory {
        case .feelings:
            if (indexPath.section == 0) {
                guard let cntdCell = tableView.dequeueReusableCell(withIdentifier: "ConnectedTVCell", for: indexPath) as? ConnectedTVCell else { return UITableViewCell() }
                cntdCell.selectionStyle = .none
                cntdCell.setCell(cntdDatas: connectedDatas[indexPath.row])
                return cntdCell
            } else {
                guard let feelCell = tableView.dequeueReusableCell(withIdentifier: "FeelingTVCell", for: indexPath) as? FeelingTVCell else { return UITableViewCell() }
                feelCell.selectionStyle = .none
                if (indexPath.section == 1) {
                    feelCell.kindOfFeelingLabel.text = "받은호감"
                    feelCell.cellCategory = .received
                } else {
                    feelCell.kindOfFeelingLabel.text = "보낸호감"
                    feelCell.cellCategory = .send
                }
                return feelCell
            }
        case .dibs:
            guard let dibsCell = tableView.dequeueReusableCell(withIdentifier: "DibsTVCell", for: indexPath) as? DibsTVCell else { return UITableViewCell() }
            dibsCell.selectionStyle = .none
            if (indexPath.section == 0) {
                dibsCell.setCell(dibsDatas: receivedDibs[indexPath.row])
            } else if (indexPath.section == 1) {
                dibsCell.setCell(dibsDatas: sendedDibs[indexPath.row])
            }
            return dibsCell
        default:
            return UITableViewCell()
        }
    }
    
    // 섹션 별 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch curCategory {
        case .feelings:
            if (indexPath.section == 0) {
                return 144
            } else if (indexPath.section == 1) || (indexPath.section == 2) {
                return 333
            }
        case .dibs:
            if (indexPath.section == 0) || (indexPath.section == 1) {
                return 116
            }
        default:
            return 0
        }
        return 0
    }
    
    // Header 뷰 지정
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
    
    // Header 높이 지정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch curCategory {
        case .feelings:
            if (section == 0 ) {
                return 43
            } else {
                return 0
            }
        case .dibs:
            if (section == 0) || (section == 1) {
                return 43
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    // Footer 뷰 지정
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch curCategory {
        case .feelings:
            if (section == 0) {
                guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MatchingFooter") as? MatchingFooter else { return UIView() }
                footer.whereSM = .feelings
                return footer
            } else {
                return nil
            }
        case .dibs:
            guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MatchingFooter") as? MatchingFooter else { return UIView() }
            if (section == 0) {
                footer.whereSM = .dibs1
            } else {
                footer.whereSM = .dibs2
            }
            return footer
        default:
            return nil
        }
    }
    
    // Footer 높이 지정
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch curCategory {
        case .feelings:
            if (section == 0) {
                return 60
            } else {
                return 0
            }
        case .dibs:
            if (section == 0) || (section==1) {
                return 53
            } else {
                return 0
            }
        default:
            return 0
        }
    }
}
