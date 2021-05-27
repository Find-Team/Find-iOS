//
//  MatchingDibsCVCell.swift
//  Find-iOS
//
//  Created by Wonseok Lee on 2021/05/26.
//

import UIKit

class MatchingDibsCVCell: UICollectionViewCell {
    static let identifier = "MatchingDibsCVCell"
    
    var idxPaths = [IndexPath]()
    var isExpandable = false
    
    @IBOutlet weak var innerTV: UITableView! {
        didSet {
            innerTV.delegate = self
            innerTV.dataSource = self
            innerTV.backgroundColor = .subGray6
            innerTV.register(DibsTVCell.nib(), forCellReuseIdentifier: DibsTVCell.identifier)
            innerTV.register(MatchingHeader.nib(), forHeaderFooterViewReuseIdentifier: "MatchingHeader")
            innerTV.register(MatchingFooter.nib(), forHeaderFooterViewReuseIdentifier: "MatchingFooter")
            innerTV.separatorStyle = .none
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setExpandable()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MatchingDibsCVCell", bundle: nil)
    }
    
    // 더보기 안눌렀을 때에는 보여지는 cell 3개
    func setExpandable() {
        for i in 0...2 {
            connectedDatas[i].isExpanded = true
            receivedDibs[i].isExpanded = true
            sendedDibs[i].isExpanded = true
        }
    }
    
//    // Noti 등록
//    func setNoti() {
//        NotificationCenter.default.addObserver(self, selector: #selector(showMore), name: NSNotification.Name(rawValue:"dibsShowMore"), object: nil)
//    }
//
//    // 더보기
//    @objc func showMore(notification: NSNotification) {
//        guard var whereShowMore = notification.object as? [ExpandableSection] else { return }
//        var indexPaths = [IndexPath]()
//        let section = whereShowMore[0].data.section!
//        var isExpandable = false
//
//        if section == 0 {
//            receivedDibs = doExpand(str: &whereShowMore)
//            if isExpandable { doInsert(section, receivedDibs) } else { doDelete(section, receivedDibs) }
//        } else {
//            sendedDibs = doExpand(str: &whereShowMore)
//            if isExpandable { doInsert(section, sendedDibs) } else { doDelete(section, sendedDibs) }
//        }
//
//        func doExpand(str: inout [ExpandableSection]) -> [ExpandableSection]{
//            // Ready to Expand
//            if str[3].isExpanded ?? false {
//                isExpandable = false
//                for row in 3..<str.count {
//                    let indexPath = IndexPath(row: row, section: section)
//                    indexPaths.append(indexPath)
//                    str[row].isExpanded = false
//                }
//            } else {
//                // Ready to Collapse
//                isExpandable = true
//                for row in 3..<str.count {
//                    let indexPath = IndexPath(row: row, section: section)
//                    indexPaths.append(indexPath)
//                    str[row].isExpanded = true
//                }
//            }
//            return str
//        }
//
//        // Expandable
//        func doInsert(_ sec: Int, _ obj: [ExpandableSection]) {
//            if sec != 1 {
//                innerTV.insertRows(at: indexPaths, with: .fade)
//                innerTV.layoutIfNeeded()
//            } else {
//                innerTV.insertRows(at: indexPaths, with: .fade)
//                innerTV.layoutIfNeeded()
//                innerTV.scrollToRow(at: IndexPath(row: obj.count-1, section: section), at: .top, animated: true)
//            }
//        }
//
//        // Collapsable
//        func doDelete(_ sec: Int, _ obj: [ExpandableSection]) {
//            innerTV.deleteRows(at: indexPaths, with: .fade)
//            innerTV.layoutIfNeeded()
//            innerTV.scrollToRow(at: IndexPath(row: 0, section: section), at: .none, animated: true)
//        }
//    }
}

// MARK: - ShowMore Footer Btn
extension MatchingDibsCVCell: ShowMoreFooter {
    
    // Do it
    func showMoreTapped(iam: WhereShowMore) {
        isExpandable = false
        idxPaths = [IndexPath]()
        switch iam {
        case .dibs1:
            receivedDibs = doExpand(str: receivedDibs, section: 0)
            if isExpandable {
                doInsert(tableView: innerTV, indexPaths: idxPaths, section: 0, str: receivedDibs)
            } else {
                doDelete(tableView: innerTV, indexPaths: idxPaths, section: 0, str: receivedDibs)
            }
        case .dibs2:
            sendedDibs = doExpand(str: sendedDibs, section: 1)
            if isExpandable {
                doInsert(tableView: innerTV, indexPaths: idxPaths, section: 1, str: sendedDibs)
            } else {
                doDelete(tableView: innerTV, indexPaths: idxPaths, section: 1, str: sendedDibs)
            }
        default:
            return
        }
    }

    // Expand? Collapse?
    func doExpand(str: [ExpandableSection], section: Int) -> [ExpandableSection] {
        // Ready to Expand
        var edit_str = str
        if str[3].isExpanded ?? false {
            isExpandable = false
            for row in 3..<str.count {
                let indexPath = IndexPath(row: row, section: section)
                idxPaths.append(indexPath)
                edit_str[row].isExpanded = false
            }
        } else {
            // Ready to Collapse
            isExpandable = true
            for row in 3..<str.count {
                let indexPath = IndexPath(row: row, section: section)
                idxPaths.append(indexPath)
                edit_str[row].isExpanded = true
            }
        }
        return edit_str
    }
    
    // Expandable
    func doInsert(tableView: UITableView, indexPaths: [IndexPath], section: Int?, str: [ExpandableSection]?) {
        tableView.insertRows(at: indexPaths, with: .fade)
        tableView.layoutIfNeeded()
        if section == 1 {
            innerTV.scrollToRow(at: IndexPath(row: (str?.count ?? 1)-1, section: section ?? 0), at: .top, animated: true)
        }
    }
    
    // Collapsable
    func doDelete(tableView: UITableView, indexPaths: [IndexPath], section: Int?, str: [ExpandableSection]?) {
        tableView.deleteRows(at: indexPaths, with: .fade)
        tableView.layoutIfNeeded()
        tableView.scrollToRow(at: IndexPath(row: (str?.filter{$0.isExpanded ?? false}.count ?? 1)-1, section: section ?? 0), at: .bottom, animated: true)
    }
}


// MARK: - Protocols
extension MatchingDibsCVCell: UITableViewDelegate, UITableViewDataSource {
    // 섹션 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 섹션 별 셀 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 데이터가 0개일 때 분기처리 필요
        if (section == 0) {
            return receivedDibs.filter{$0.isExpanded ?? false}.count
        } else if (section == 1) {
            return sendedDibs.filter{$0.isExpanded ?? false}.count
        }
        return 0
    }
    
    // 섹션 별 셀 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 데이터가 0개일 때 분기처리 필요
        guard let dibsCell = tableView.dequeueReusableCell(withIdentifier: "DibsTVCell", for: indexPath) as? DibsTVCell else { return UITableViewCell() }
        dibsCell.selectionStyle = .none
        if (indexPath.section == 0) {
            dibsCell.setCell(dibsDatas: receivedDibs[indexPath.row])
        } else if (indexPath.section == 1) {
            dibsCell.setCell(dibsDatas: sendedDibs[indexPath.row])
        }
        return dibsCell
    }
    
    // 섹션 별 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    // Header 뷰 지정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    }
    
    // Header 높이 지정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) || (section == 1) {
            return 43
        } else {
            return 0
        }
    }
    
    // Footer 뷰 지정
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MatchingFooter") as? MatchingFooter else { return UIView() }
        if (section == 0) {
            footer.whereSM = .dibs1
        } else {
            footer.whereSM = .dibs2
        }
        footer.delegate = self
        return footer
    }
    
    // Footer 높이 지정
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 0) || (section==1) {
            return 53
        } else {
            return 0
        }
    }
}
