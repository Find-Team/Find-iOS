//
//  InterviewVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit

class InterviewVC: UIViewController {
    
    enum InterviewCategory {
        case pros, love, taste, life
    }
    var currentCategory: InterviewCategory?
    @IBOutlet weak var interviewCV: UICollectionView!{
        didSet{
            interviewCV.delegate = self
            interviewCV.dataSource = self
            interviewCV.register(InterviewCVCell.nib(), forCellWithReuseIdentifier: InterviewCVCell.idientifier)
            interviewCV.register(InterviewPhotoCVCell.nib(), forCellWithReuseIdentifier: InterviewPhotoCVCell.identifier)
            interviewCV.register(photoPreviewCVCell.nib(), forCellWithReuseIdentifier: photoPreviewCVCell.identifier)
        }
    }
    @IBOutlet var segueIndicatiorView: [UIView]!
    @IBOutlet var segueBtns: [UIButton]!
    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegueStyle()
        whatSelected(seg: .pros, idx: 0)
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
    @IBAction func swipeAction(_ sender: Any) {
        if swipeRecognizer.direction == .left{
            print("left")
            switch currentCategory {
            case .pros:
                return
            case .love:
                whatSelected(seg: .pros, idx: 0)
            case .taste:
                whatSelected(seg: .love, idx: 1)
            case .life:
                whatSelected(seg: .taste, idx: 2)
            default:
                return
            }
        }
        if swipeRecognizer.direction == .right{
            print("right")
            switch currentCategory {
            case .pros:
                whatSelected(seg: .love, idx: 1)
            case .love:
                whatSelected(seg: .taste, idx: 2)
            case .taste:
                whatSelected(seg: .life, idx: 3)
            case .life:
                return
            default:
                return
            }
        }
    }
}

extension InterviewVC {
    
    //MARK: - Styles
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
    
    // 어떤 세그가 선택되었는지
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
            interviewCV.reloadSections(IndexSet(0...0))
        }
    }
    
    // 화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension InterviewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            switch currentCategory {
            case .pros,.taste:
                return 4
            case .love,.life:
                return 5
            case .none:
                return 0
            }
        } else {
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterviewCVCell.idientifier, for: indexPath) as? InterviewCVCell else { return UICollectionViewCell() }
            
            /// 선택 카테고리에 따른 질문
            var currIndexPath: Int = 0
            
            switch currentCategory {
            case .pros:
                currIndexPath = indexPath.row
                cell.curCategory = "pros"
                cell.questionNumLabel.text = "Q.\(indexPath.row+1)"
                cell.questionTitleLabel.text = interviewQuestions[currIndexPath].question
                cell.answerTextField.text = interviewQuestions[currIndexPath].answer
            case .love:
                currIndexPath = indexPath.row+4
                cell.curCategory = "love"
                cell.questionNumLabel.text = "Q.\(indexPath.row+1)"
                cell.questionTitleLabel.text = interviewQuestions[currIndexPath].question
                cell.answerTextField.text = interviewQuestions[currIndexPath].answer
            case .taste:
                currIndexPath = indexPath.row+9
                cell.curCategory = "taste"
                cell.questionNumLabel.text = "Q.\(indexPath.row+1)"
                cell.questionTitleLabel.text = interviewQuestions[currIndexPath].question
                cell.answerTextField.text = interviewQuestions[currIndexPath].answer
            case .life:
                currIndexPath = indexPath.row+13
                cell.curCategory = "life"
                cell.questionNumLabel.text = "Q.\(indexPath.row+1)"
                cell.questionTitleLabel.text = interviewQuestions[currIndexPath].question
                cell.answerTextField.text = interviewQuestions[currIndexPath].answer
            case .none:
                0
            }
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterviewPhotoCVCell.identifier, for: indexPath) as? InterviewPhotoCVCell else { return UICollectionViewCell() }
            
            return cell
        } else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoPreviewCVCell.identifier, for: indexPath) as? photoPreviewCVCell else { return UICollectionViewCell() }

            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width-32, height: 100)
        } else if indexPath.section == 1 {
            return CGSize(width: collectionView.frame.width-32, height: 70)
        } else if indexPath.section == 2 {
            return CGSize(width: collectionView.frame.width-32, height: collectionView.frame.width-32 )
        }
         
        return CGSize(width: 0, height: 0)
    }
    
    //MARK: - Cell간의 상하간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 16
        }else {
            return 0
        }
    }
    
    //MARK: - 마진
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if section == 0 || section == 1{
            return UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        } else if section == 2 {
            return UIEdgeInsets(top: 24, left: 0, bottom: 36, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
