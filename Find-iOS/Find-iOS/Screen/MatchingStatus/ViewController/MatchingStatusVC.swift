//
//  MatchingStatusVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

enum MatchingCategory {
    case feelings, dibs
}

class MatchingStatusVC: UIViewController {
    var curCategory: MatchingCategory?
    
    @IBOutlet var segIndicators: [UIView]!
    @IBOutlet var segueBtns: [UIButton]!
    @IBOutlet weak var matchingCV: UICollectionView! {
        didSet {
            matchingCV.delegate = self
            matchingCV.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegueStyle()
        whatSelected(seg: .feelings, idx: 0)
        // Do any additional setup after loading the view.
    }

    @IBAction func feelingsTapped(_ sender: Any) {
        whatSelected(seg: .feelings, idx: 0)
    }
    
    @IBAction func dibsTapped(_ sender: Any) {
        whatSelected(seg: .dibs, idx: 1)
    }
    
    // 페이징 관련 index 정의 함수
    private var indexOfCellBeforeDragging = 0
    
    // 오른쪽으로 넘길 때
    private func indexOfMajorCell() -> Int {
        let itemWidth = matchingCV.frame.size.width
        let proportionalOffset = (matchingCV.contentOffset.x / itemWidth)+0.3
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(4, index))
        return safeIndex
    }
    
    // 왼쪽으로 넘길 때
    private func indexOfBeforCell() -> Int {
        let itemWidth = matchingCV.frame.size.width
        let proportionalOffset = (matchingCV.contentOffset.x / itemWidth)
        let back_index = Int(floor(proportionalOffset))
        let safeIndex = max(0, min(4, back_index))
        return safeIndex
    }
}

extension MatchingStatusVC {
    // MARK: - Segue Styles
    func setSegueStyle() {
        segueBtns[0].setTitle("호감", for: .normal)
        segueBtns[0].setTitleColor(.subGray2, for: .normal)
        
        segueBtns[1].setTitle("찜", for: .normal)
        segueBtns[1].setTitleColor(.subGray2, for: .normal)
    }
    
    // MARK: - Remind Me Selected Segue
    func whatSelected(seg: MatchingCategory, idx: Int){
        if curCategory != seg {
            curCategory = seg
            for i in 0..<2{
                if i == idx{
                    segIndicators[i].backgroundColor = .find_Purple
                    segueBtns[i].setTitleColor(.find_Purple, for: .normal)
                }else{
                    segIndicators[i].backgroundColor = .subGray1
                    segueBtns[i].setTitleColor(.subGray2, for: .normal)
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeMatchingSegue"),object: curCategory)
        }
    }
}

extension MatchingStatusVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchingStatusCVCell.identifier, for: indexPath) as? MatchingStatusCVCell else { return UICollectionViewCell() }
        cell.curCategory = curCategory
        return cell
    }
    
    // Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
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
                whatSelected(seg: .feelings, idx: 0)
            case 1:
                whatSelected(seg: .dibs, idx: 1)
            default:
                return
            }
        }else{
            let indexOfBeforeCell = self.indexOfBeforCell()
            let indexPath = IndexPath(row: indexOfBeforeCell, section: 0)
            matchingCV.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            switch indexOfBeforeCell {
            case 0:
                whatSelected(seg: .feelings, idx: 0)
            case 1:
                whatSelected(seg: .dibs, idx: 1)
            default:
                return
            }
        }
    }
}
