//
//  MatchingStatusVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

class MatchingStatusVC: UIViewController {
    var matchingData: GetMyMatchingData?
    
    @IBOutlet weak var segueStackView: UIStackView!
    @IBOutlet var segIndicators: [UIView]!
    @IBOutlet var segueBtns: [UIButton]!
    @IBOutlet weak var matchingCV: UICollectionView! {
        didSet {
            matchingCV.delegate = self
            matchingCV.dataSource = self
            matchingCV.backgroundColor = .subGray6
            matchingCV.register(MatchingDibsCVCell.nib(), forCellWithReuseIdentifier: MatchingDibsCVCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyMatchingData()
        setSegueStyle()
        setNoti()
        whatSelected(idx: 0)
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func feelingsTapped(_ sender: Any) {
        whatSelected(idx: 0)
    }
    
    @IBAction func dibsTapped(_ sender: Any) {
        whatSelected(idx: 1)
    }
    
    // 페이징 관련 index 정의 함수
    private var indexOfCellBeforeDragging = 0
    
    // 오른쪽으로 넘길 때
    private func indexOfMajorCell() -> Int {
        let itemWidth = matchingCV.frame.size.width
        let proportionalOffset = (matchingCV.contentOffset.x / itemWidth)+0.3
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(2, index))
        return safeIndex
    }
    
    // 왼쪽으로 넘길 때
    private func indexOfBeforCell() -> Int {
        let itemWidth = matchingCV.frame.size.width
        let proportionalOffset = (matchingCV.contentOffset.x / itemWidth)
        let back_index = Int(floor(proportionalOffset))
        let safeIndex = max(0, min(2, back_index))
        return safeIndex
    }
}

extension MatchingStatusVC {
    
    // MARK: - Get My Matching Data(API)
    @objc func getMyMatchingData() {
        APIService.shared.getMyMatching(1) { [self] result in
            switch result {
            case .success(let data):
                self.matchingData = data
                matchingCV.reloadSections(IndexSet(integer: 0))
                print("데이터 받아왔습니다.")
            case .failure(let error):
                print("데이터 못받아왔습니다.")
                print(error)
            }
        }
    }
    // MARK: - Segue Styles
    func setSegueStyle() {
        segueBtns[0].setTitle("호감", for: .normal)
        segueBtns[0].setTitleColor(.subGray2, for: .normal)
        
        segueBtns[1].setTitle("찜", for: .normal)
        segueBtns[1].setTitleColor(.subGray2, for: .normal)
    }
    
    func setNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(getMyMatchingData), name: NSNotification.Name("updateMatchingData"), object: nil)
    }
    
    // MARK: - Remind Selected Segue
    func whatSelected(idx: Int){
        for i in 0..<2{
            if i == idx{
                segIndicators[i].backgroundColor = .find_Purple
                segueBtns[i].setTitleColor(.find_Purple, for: .normal)
            }else{
                segIndicators[i].backgroundColor = .subGray1
                segueBtns[i].setTitleColor(.subGray2, for: .normal)
            }
        }
        matchingCV.selectItem(at: IndexPath(item: idx, section: 0), animated: true, scrollPosition: .left)
    }
}

extension MatchingStatusVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchingStatusCVCell.identifier, for: indexPath) as? MatchingStatusCVCell else { return UICollectionViewCell() }
            cell.connectedData = matchingData?.connected
            cell.receivedData = matchingData?.receivedFeeling
            cell.sendData = matchingData?.sendFeeling
            cell.setExpandable()
            return cell
        } else if indexPath.row == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchingDibsCVCell.identifier, for: indexPath) as? MatchingDibsCVCell else { return UICollectionViewCell() }
            cell.receivedDibs = matchingData?.receivedDibs
            cell.sendDibs = matchingData?.sendDibs
            cell.setExpandable()
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - collectionView Horizontal Scrolling Magnetic Effect 적용
extension MatchingStatusVC: UIScrollViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        if velocity.x > 0 {
            let indexOfMajorCell = self.indexOfMajorCell()
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            matchingCV.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            switch indexOfMajorCell {
            case 0:
                whatSelected(idx: 0)
            case 1:
                whatSelected(idx: 1)
            default:
                return
            }
        }else{
            let indexOfBeforeCell = self.indexOfBeforCell()
            let indexPath = IndexPath(row: indexOfBeforeCell, section: 0)
            matchingCV.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            switch indexOfBeforeCell {
            case 0:
                whatSelected(idx: 0)
            case 1:
                whatSelected(idx: 1)
            default:
                return
            }
        }
    }
}
