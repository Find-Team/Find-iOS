//
//  InterviewVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit
import Photos

enum InterviewCategory {
    case pros, love, taste, life
}

class InterviewVC: UIViewController {
    var currentCategory: InterviewCategory?
    var beforeInterviewData = interviewQuestions // 저장 전 인터뷰 답변 데이터
    var beforeInterviewImgs = interviewImgs // 저장 전 이미지 데이터
    var receivedInt : Int? // 선택된 이미지의 인덱스 값 - preview View에서 사용하기 위함
    
    @IBOutlet weak var interviewCV: UICollectionView!{
        didSet{
            interviewCV.delegate = self
            interviewCV.dataSource = self
        }
    }
    @IBOutlet var segueIndicatiorView: [UIView]!
    @IBOutlet var segueBtns: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setSegueStyle()
        keyboardTouchDown()
        whatSelected(seg: .pros, idx: 0)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        // viewDidLoad()시 내용과 viewWillDisappear() 내용이 다르면 저장 Alert Show 같으면 그냥 pop
        receivedInt = nil
        let alert =  UIAlertController(title: "저장하시겠습니까?", message: nil, preferredStyle: .alert)
        let yes = UIAlertAction(title: "예", style: .default) { [self] (action) in
            self.navigationController?.popViewController(animated: true)
        }
        let no = UIAlertAction(title: "아니오", style: .cancel) { [self] (action) in
            interviewQuestions = beforeInterviewData
            interviewImgs = beforeInterviewImgs
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(no)
        alert.addAction(yes)
        
        if interviewQuestions != beforeInterviewData || interviewImgs != beforeInterviewImgs {
            present(alert, animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // 저장되었습니다 토스트
    @IBAction func saveBtnTapped(_ sender: Any) {
        print("뭐야1")
        self.showToastPurple(message: "저장되었습니다.") { [self] in
            print("뭐야2")
            beforeInterviewData = interviewQuestions
            beforeInterviewImgs = interviewImgs
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func prosBtnTapped(_ sender: Any) {
        whatSelected(seg: .pros, idx: 0)
    }
    @IBAction func loveBtnTapped(_ sender: Any) {
        whatSelected(seg: .love, idx: 1)
    }
    @IBAction func tasteBtnTapped(_ sender: Any) {
        whatSelected(seg: .taste, idx: 2)
    }
    @IBAction func lifeBtnTapped(_ sender: Any) {
        whatSelected(seg: .life, idx: 3)
    }
    
    // 페이징 관련 index 정의 함수
    private var indexOfCellBeforeDragging = 0
    
    // 오른쪽으로 넘길 때
    private func indexOfMajorCell() -> Int {
        let itemWidth = interviewCV.frame.size.width
        let proportionalOffset = (interviewCV.contentOffset.x / itemWidth)+0.3
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(4, index))
        return safeIndex
    }
    
    // 왼쪽으로 넘길 때
    private func indexOfBeforCell() -> Int {
        let itemWidth = interviewCV.frame.size.width
        let proportionalOffset = (interviewCV.contentOffset.x / itemWidth)
        let back_index = Int(floor(proportionalOffset))
        let safeIndex = max(0, min(4, back_index))
        return safeIndex
    }
}


extension InterviewVC {
    // MARK: - Segue Styles
    func setSegueStyle() {
        segueBtns[0].setTitle("장점", for: .normal)
        segueBtns[0].setTitleColor(.subGray2, for: .normal)
        
        segueBtns[1].setTitle("연애", for: .normal)
        segueBtns[1].setTitleColor(.subGray2, for: .normal)
        
        segueBtns[2].setTitle("호불호", for: .normal)
        segueBtns[2].setTitleColor(.subGray2, for: .normal)
        
        segueBtns[3].setTitle("라이프", for: .normal)
        segueBtns[3].setTitleColor(.subGray2, for: .normal)
    }
    
    // MARK: - Remind Selected Segue
    func whatSelected(seg: InterviewCategory, idx: Int){
        if currentCategory != seg {
            currentCategory = seg
            for i in 0..<4{
                if i == idx{
                    segueIndicatiorView[i].backgroundColor = .find_Purple
                    segueBtns[i].setTitleColor(.find_Purple, for: .normal)
                }else{
                    segueIndicatiorView[i].backgroundColor = .subGray1
                    segueBtns[i].setTitleColor(.subGray2, for: .normal)
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeSegue"),object: currentCategory)
        }
    }
    
    // 화면 터치시 키보드 내리기
    func keyboardTouchDown() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        interviewCV.addGestureRecognizer(singleTapGestureRecognizer)
    }
    @objc func tapAction(sender: UITapGestureRecognizer) {
        _ = self.view.endEditing(true)
    }
}

//MARK: - Protocols
extension InterviewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterviewCVCell.identifier , for: indexPath) as? InterviewCVCell else { return UICollectionViewCell() }
        cell.currentCategory = currentCategory
        cell.receivedInt = receivedInt
        return cell
    }
    
    // Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // 왼쪽 or 오른쪽으로 스와이프 하면
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        
        switch currentIndex {
        case 0:
            whatSelected(seg: .pros, idx: 0)
        case 1:
            whatSelected(seg: .love, idx: 1)
        case 2:
            whatSelected(seg: .taste, idx: 2)
        case 3:
            whatSelected(seg: .life, idx: 3)
        default:
            break
        }
    }
}

// MARK: - collectionView Horizontal Scrolling Magnetic Effect 적용
extension InterviewVC: UIScrollViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        if velocity.x > 0 {
            let indexOfMajorCell = self.indexOfMajorCell()
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            interviewCV.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            switch indexOfMajorCell {
            case 0:
                whatSelected(seg: .pros, idx: 0)
            case 1:
                whatSelected(seg: .love, idx: 1)
            case 2:
                whatSelected(seg: .taste, idx: 2)
            case 3:
                whatSelected(seg: .life, idx: 3)
            default:
                return
            }
        }else{
            let indexOfBeforeCell = self.indexOfBeforCell()
            let indexPath = IndexPath(row: indexOfBeforeCell, section: 0)
            interviewCV.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            switch indexOfBeforeCell {
            case 0:
                whatSelected(seg: .pros, idx: 0)
            case 1:
                whatSelected(seg: .love, idx: 1)
            case 2:
                whatSelected(seg: .taste, idx: 2)
            case 3:
                whatSelected(seg: .life, idx: 3)
            default:
                return
            }
        }
    }
}
