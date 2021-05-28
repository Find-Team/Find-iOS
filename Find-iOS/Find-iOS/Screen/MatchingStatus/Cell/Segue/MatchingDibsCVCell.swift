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
    var receivedDibs, sendDibs: [Connected]?
    var receivedDataExp: [ExpandableSection] = []
    var sendDataExp: [ExpandableSection] = []
    
    @IBOutlet weak var innerTV: UITableView! {
        didSet {
            innerTV.delegate = self
            innerTV.dataSource = self
            innerTV.backgroundColor = .subGray6
            innerTV.register(DibsTVCell.nib(), forCellReuseIdentifier: DibsTVCell.identifier)
            innerTV.register(MatchingHeader.nib(), forHeaderFooterViewReuseIdentifier: "MatchingHeader")
            innerTV.register(MatchingFooter.nib(), forHeaderFooterViewReuseIdentifier: "MatchingFooter")
            innerTV.register(noDataTVCell.nib(), forCellReuseIdentifier: noDataTVCell.identifier)
            innerTV.separatorStyle = .none
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setNoti()
        // Initialization code
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MatchingDibsCVCell", bundle: nil)
    }
}

extension MatchingDibsCVCell {
    
    // 더보기 안눌렀을 때에는 보여지는 cell 최대 3개
    func setExpandable() {
        if let rcvData = receivedDibs {
            for i in 0..<rcvData.count {
                receivedDataExp.append(ExpandableSection(isExpanded: false, data: rcvData[i]))
            }
            for i in 0..<(rcvData.count % 4) {
                receivedDataExp[i].isExpanded = true
            }
        }
        if let sdData = sendDibs {
            for i in 0..<sdData.count {
                sendDataExp.append(ExpandableSection(isExpanded: false, data: sdData[i]))
            }
            for i in 0..<(sdData.count % 4) {
                sendDataExp[i].isExpanded = true
            }
        }
    }
    
    func setNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(changingData), name: NSNotification.Name("needToReloadDibs"), object: nil)
    }
    
    // 연결되면 연결된 상대로 올라가야함. 데이터 업데이트
    @objc func changingData(noti: Notification) {
        if let sec = noti.object as? [Int] {
            NotificationCenter.default.post(name: NSNotification.Name("updateMatchingData"), object: nil) // MatchingStatusVC에 존재
            innerTV.reloadSections(IndexSet(sec[0]...sec[1]), with: .fade)
        }
    }
}

// MARK: - ShowMore Footer Btn
extension MatchingDibsCVCell: ShowMoreFooter {
    
    // Do it
    func showMoreTapped(iam: WhereShowMore) {
        isExpandable = false
        idxPaths = [IndexPath]()
        switch iam {
        case .dibs1:
            if receivedDataExp.count > 3 {
                receivedDataExp = doExpand(str: receivedDataExp, section: 0)
                if isExpandable {
                    doInsert(tableView: innerTV, indexPaths: idxPaths, section: 0, str: receivedDataExp)
                } else {
                    doDelete(tableView: innerTV, indexPaths: idxPaths, section: 0, str: receivedDataExp)
                }
            }
        case .dibs2:
            if sendDataExp.count > 3 {
                sendDataExp = doExpand(str: sendDataExp, section: 1)
                if isExpandable {
                    doInsert(tableView: innerTV, indexPaths: idxPaths, section: 1, str: sendDataExp)
                } else {
                    doDelete(tableView: innerTV, indexPaths: idxPaths, section: 1, str: sendDataExp)
                }
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
            if !receivedDataExp.isEmpty {
                return receivedDataExp.filter{$0.isExpanded ?? false}.count
            }
        } else if (section == 1) {
            if !sendDataExp.isEmpty {
                return sendDataExp.filter{$0.isExpanded ?? false}.count
            }
        }
        return 1
    }
    
    // 섹션 별 셀 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 데이터가 0개일 때 분기처리 필요
        if (indexPath.section == 0) {
            if !receivedDataExp.isEmpty {
                guard let dibsCell = tableView.dequeueReusableCell(withIdentifier: "DibsTVCell", for: indexPath) as? DibsTVCell else { return UITableViewCell() }
                dibsCell.setCell(dibsDatas: receivedDataExp[indexPath.row])
                dibsCell.dibsCategory = .whoLikeMe
                dibsCell.selectionStyle = .none
                return dibsCell
            } else {
                // 데이터가 0개일 때 분기처리
                guard let noDataCell = tableView.dequeueReusableCell(withIdentifier: "noDataTVCell", for: indexPath) as? noDataTVCell else { return UITableViewCell() }
                noDataCell.descriptLabel.text = "나를 찜한 사람이 없어요!"
                noDataCell.selectionStyle = .none
                return noDataCell
            }
        } else if (indexPath.section == 1) {
            if !sendDataExp.isEmpty {
                guard let dibsCell = tableView.dequeueReusableCell(withIdentifier: "DibsTVCell", for: indexPath) as? DibsTVCell else { return UITableViewCell() }
                dibsCell.setCell(dibsDatas: sendDataExp[indexPath.row])
                dibsCell.dibsCategory = .whoILike
                dibsCell.selectionStyle = .none
                return dibsCell
            } else {
                // 데이터가 0개일 때 분기처리
                guard let noDataCell = tableView.dequeueReusableCell(withIdentifier: "noDataTVCell", for: indexPath) as? noDataTVCell else { return UITableViewCell() }
                noDataCell.descriptLabel.text = "내가 찜한 사람이 없어요!"
                noDataCell.selectionStyle = .none
                return noDataCell
            }
        }
        return UITableViewCell()
    }
    
    // 섹션 별 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            if !receivedDataExp.isEmpty {
                return 116
            }
        } else {
            if !sendDataExp.isEmpty {
                return 116
            }
        }
        return (tableView.frame.height - 86) / 3
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
        // 데이터가 4개 이상 있어야 더보기 footer 생성
        if (section == 0) {
            if receivedDataExp.count > 3 {
                footer.whereSM = .dibs1
            } else {
                return nil
            }
        } else {
            if sendDataExp.count > 3 {
                footer.whereSM = .dibs2
            } else {
                return nil
            }
        }
        footer.delegate = self
        return footer
    }
    
    // Footer 높이 지정
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // 데이터가 4개 이상 있어야 더보기 footer 생성
        if (section == 0) {
            if receivedDataExp.count > 3 {
                return 53
            }
        } else if (section == 1) {
            if sendDataExp.count > 3 {
                return 53
            }
        }
        return 0
    }
}
