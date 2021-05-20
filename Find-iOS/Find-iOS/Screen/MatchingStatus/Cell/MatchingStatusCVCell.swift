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
    //    var datasource: UITableViewDiffableDataSource<Section, Item>!
    
    @IBOutlet weak var innerTV: UITableView! {
        didSet {
            innerTV.delegate = self
            innerTV.dataSource = self
            innerTV.backgroundColor = .subGray6
            innerTV.register(ConnectedTVCell.nib(), forCellReuseIdentifier: ConnectedTVCell.identifier)
            innerTV.register(FeelingTVCell.nib(), forCellReuseIdentifier: FeelingTVCell.identifier)
            innerTV.register(DibsTVCell.nib(), forCellReuseIdentifier: DibsTVCell.identifier)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch curCategory {
        case .feelings:
            if (section == 0) {
                let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 59))
                
                let label = UILabel()
                label.frame = CGRect.init(x: 16, y: 20, width: tableView.frame.width, height: headerView.frame.height-10)
                label.text = "연결된 상대"
                label.font = .spoqaLight(size: 18)
                label.textColor = .subGray5
                headerView.backgroundColor = .subGray6
                headerView.addSubview(label)
                
                return headerView
            }
        case .dibs:
            if (section == 0) {
                let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 59))
                
                let label = UILabel()
                label.frame = CGRect.init(x: 16, y: 20, width: headerView.frame.width-10, height: headerView.frame.height-10)
                label.text = "연결된 사람"
                label.font = .spoqaLight(size: 18)
                label.textColor = .subGray5
                headerView.addSubview(label)
                
                return headerView
            } else if (section == 1) {
                let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 59))
                
                let label = UILabel()
                label.frame = CGRect.init(x: 16, y: 20, width: headerView.frame.width-10, height: headerView.frame.height-10)
                label.text = "연결된 사람"
                label.font = .spoqaLight(size: 18)
                label.textColor = .subGray5
                headerView.addSubview(label)
                
                return headerView
            }
        default:
            return nil
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if curCategory == .feelings {
            if (section == 0) {
                let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
                let showMoreBtn = UIButton()
                showMoreBtn.frame = CGRect.init(x: 16, y: 20, width: tableView.frame.width, height: 60)
                showMoreBtn.titleLabel?.text = "더보기"
                showMoreBtn.titleLabel?.font = .spoqaRegular(size: 14)
                showMoreBtn.titleLabel?.textColor = .subGray1
                footerView.backgroundColor = .subGray6
                footerView.addSubview(showMoreBtn)
                
                return footerView
            }
        }
        return nil
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch curCategory {
        case .feelings:
            if (indexPath.section == 0) {
                guard let cntdCell = tableView.dequeueReusableCell(withIdentifier: "ConnectedTVCell", for: indexPath) as? ConnectedTVCell else { return UITableViewCell() }
                return cntdCell
            } else {
                guard let feelCell = tableView.dequeueReusableCell(withIdentifier: "FeelingTVCell", for: indexPath) as? FeelingTVCell else { return UITableViewCell() }
                return feelCell
            }
        case .dibs:
            guard let dibsCell = tableView.dequeueReusableCell(withIdentifier: "DibsTVCell", for: indexPath) as? DibsTVCell else { return UITableViewCell() }
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
                return 128
            } else if (indexPath.section == 1) || (indexPath.section == 2) {
                return 333
            }
        case .dibs:
            return 100
        default:
            return 0
        }
        return 0
    }
}
