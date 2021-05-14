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
    var currentCategory: InterviewCategory = .pros
    @IBOutlet weak var interviewTV: UITableView!{
        didSet{
            interviewTV.delegate = self
            interviewTV.dataSource = self
        }
    }
    @IBOutlet var segueIndicatiorView: [UIView]!
    @IBOutlet weak var prosBtn: UIButton!
    @IBOutlet weak var loveBtn: UIButton!
    @IBOutlet weak var tasteBtn: UIButton!
    @IBOutlet weak var lifeBtn: UIButton!
    
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
}

extension InterviewVC {
    
    //MARK: - Styles
    func setSegueStyle() {
        prosBtn.setTitle("장점", for: .normal)
        prosBtn.setTitleColor(.subGray2, for: .normal)
        
        loveBtn.setTitle("연애", for: .normal)
        loveBtn.setTitleColor(.subGray2, for: .normal)
        
        tasteBtn.setTitle("호불호", for: .normal)
        tasteBtn.setTitleColor(.subGray2, for: .normal)
        
        lifeBtn.setTitle("라이프", for: .normal)
        lifeBtn.setTitleColor(.subGray2, for: .normal)
    }
    
    // 어떤 세그가 선택되었는지
    func whatSelected(seg: InterviewCategory, idx: Int){
        currentCategory = seg
        for i in 0..<4{
            if i == idx{
                segueIndicatiorView[i].backgroundColor = .find_Purple
            }else{
                segueIndicatiorView[i].backgroundColor = .subGray1
            }
        }
        interviewTV.reloadSections(IndexSet(0...0), with: .none)
    }
    
    // 화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
    
extension InterviewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentCategory {
        case .pros,.taste:
            return 4
        case .love,.life:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InterviewTVCell") as? InterviewTVCell else { return UITableViewCell() }
        
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
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

//
//extension InterviewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterviewCVCell.identifier, for: indexPath) as? InterviewCVCell else{
//            return UICollectionViewCell()
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = self.view.frame.width
//        let height = self.view.frame.width
//
//        return CGSize(width: width, height: height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
//                            UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
//    }
//
//}
