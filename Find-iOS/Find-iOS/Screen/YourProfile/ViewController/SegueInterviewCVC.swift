//
//  SegueInterviewCVC.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/19.
//

import UIKit

class SegueInterviewCVC: UICollectionViewCell {
    static let identifier = "SegueInterviewCVC"
    
    var currentCategory = ProfileCategory.pros
    
    var prosList: [InterviewQAData] = []
    var loveList: [InterviewQAData] = []
    var tasteList: [InterviewQAData] = []
    var lifeList: [InterviewQAData] = []
    
    var prosImgList: [UIImage] = []
    var loveImgList: [UIImage] = []
    var tasteImgList: [UIImage] = []
    var lifeImgList: [UIImage] = []
    
    @IBOutlet weak var interviewContentsTableView: UITableView!
    override func awakeFromNib() {
        setProsList()
        setLoveList()
        setTasteList()
        setLifeList()
        
        interviewContentsTableView.dataSource = self
        interviewContentsTableView.delegate = self
        interviewContentsTableView.separatorStyle = .none
    }
    func setProsList() {
        prosList.append(contentsOf: [
            InterviewQAData(index: 1, question: "성격 & 매력포인트", answer: "언제나 긍정, 귀염귀염"),
            InterviewQAData(index: 2, question: "외모특징 & 자신있는 부분", answer: "눗웃음, 볼살, 보조개"),
            InterviewQAData(index: 3, question: "잘하는 것 & 특기", answer: "자전거, 볼링"),
            InterviewQAData(index: 4, question: "가지고 있는것 & 자랑거리", answer: "눗웃음")
        ])
        
        
    }
    
    func setLoveList() {
        loveList.append(contentsOf: [
            InterviewQAData(index: 1, question: "좋아하는 이성스타일", answer: "상냥한 사람, 공감러"),
            InterviewQAData(index: 2, question: "싫어하는 이성스타일", answer: "거짓말 쟁이,이기적"),
            InterviewQAData(index: 3, question: "좋아하는 데이트", answer: "영화보기, 손잡고 걷기"),
            InterviewQAData(index: 4, question: "나만의 애정표현법", answer: "계속 옆에 있어주기"),
            InterviewQAData(index: 5, question: "이성에게 설레는 포인트", answer: "토끼 같이 처다볼때")
        ])
    }
    
    func setTasteList() {
        tasteList.append(contentsOf: [
            InterviewQAData(index: 1, question: "좋아하는 것", answer: "운동, 맛집탐방"),
            InterviewQAData(index: 2, question: "싫어하는 것", answer: "투덜이, 강요"),
            InterviewQAData(index: 3, question: "좋아하는 음식", answer: "삼겹살, 파스타, 디저트"),
            InterviewQAData(index: 4, question: "원하는 것", answer: "세계평화와 마음의 안식")
        ])
    }
    
    func setLifeList() {
        lifeList.append(contentsOf: [
            InterviewQAData(index: 1, question: "활동/선호지역", answer: "홍대, 연남"),
            InterviewQAData(index: 2, question: "휴일을 보내는 방법", answer: "걸어다니기, 딸기뷔페가기"),
            InterviewQAData(index: 3, question: "스트레스 해소방법", answer: "무념무상"),
            InterviewQAData(index: 4, question: "좌우명이나 생활신조", answer: "지금 이순간에 행복하자"),
            InterviewQAData(index: 5, question: "행복을 느끼는 때 ", answer: "이불속에서 귤까먹기, 주말 늦잠")
        ])
    }
}

extension SegueInterviewCVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            switch currentCategory {
            case .pros:
                return prosList.count
            case .love:
                return loveList.count
            case .taste:
                return tasteList.count
            case .life:
                return lifeList.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let imgCell = tableView.dequeueReusableCell(withIdentifier: InterviewImgTVC.identifier, for: indexPath) as? InterviewImgTVC else { return UITableViewCell() }
            return imgCell
        }

        else {
            guard let answerCell = tableView.dequeueReusableCell(withIdentifier: InterviewAnswerTVC.identifier, for: indexPath) as? InterviewAnswerTVC else { return UITableViewCell() }
            switch currentCategory {
            case .pros:
                answerCell.setInterviewData(index: prosList[indexPath.row].index,
                                            question: prosList[indexPath.row].question,
                                            answer: prosList[indexPath.row].answer)
                return answerCell
            case .love:
                answerCell.setInterviewData(index: loveList[indexPath.row].index,
                                            question: loveList[indexPath.row].question,
                                            answer: loveList[indexPath.row].answer)
                return answerCell
            case .taste:
                answerCell.setInterviewData(index: tasteList[indexPath.row].index,
                                            question: tasteList[indexPath.row].question,
                                            answer: tasteList[indexPath.row].answer)
                return answerCell
            case .life:
                answerCell.setInterviewData(index: lifeList[indexPath.row].index,
                                            question: lifeList[indexPath.row].question,
                                            answer: lifeList[indexPath.row].answer)
                print(lifeList[indexPath.row])
                return answerCell
            }
        }
        
        return UITableViewCell()
    }
}

extension SegueInterviewCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        }
        return 120
    }
}
