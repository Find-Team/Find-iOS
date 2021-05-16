//
//  InterviewData.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/13.
//

import Foundation

struct InterviewData: Equatable {
    let id : Int
    let question : String
    var isEdit : Bool = false // 답변이 작성 되었는지
    var answer: String? // 질문에 대한 답변
    
    static func == (lhs: InterviewData, rhs: InterviewData) -> Bool {
        return (lhs.isEdit == rhs.isEdit) && (lhs.answer == rhs.answer)
    }
}

// MARK: - 인터뷰 질문 목록
var interviewQuestions: [InterviewData] = [
    InterviewData(id: 1, question: "성격 & 매력포인트", isEdit: false, answer: nil),
    InterviewData(id: 2, question: "외모특징 & 자신있는 부분", isEdit: false, answer: nil),
    InterviewData(id: 3, question: "잘하는 것 & 특기", isEdit: false, answer: nil),
    InterviewData(id: 4, question: "가지고 있는 것 & 자랑거리", isEdit: false, answer: nil),
    
    InterviewData(id: 5, question: "좋아하는 이성 스타일", isEdit: false, answer: nil),
    InterviewData(id: 6, question: "싫어하는 이성 스타일", isEdit: false, answer: nil),
    InterviewData(id: 7, question: "좋아하는 데이트", isEdit: false, answer: nil),
    InterviewData(id: 8, question: "나만의 애정 표현법", isEdit: false, answer: nil),
    InterviewData(id: 9, question: "이성에게 설레는 포인트", isEdit: false, answer: nil),
    
    InterviewData(id: 10, question: "좋아하는 것", isEdit: false, answer: nil),
    InterviewData(id: 11, question: "싫어하는 것", isEdit: false, answer: nil),
    InterviewData(id: 12, question: "좋아하는 음식", isEdit: false, answer: nil),
    InterviewData(id: 13, question: "원하는 것", isEdit: false, answer: nil),
    
    InterviewData(id: 14, question: "활동/선호지역", isEdit: false, answer: nil),
    InterviewData(id: 15, question: "휴일을 보내는 방법", isEdit: false, answer: nil),
    InterviewData(id: 16, question: "스트레스 해소방법", isEdit: false, answer: nil),
    InterviewData(id: 17, question: "좌우명이나 생활신조", isEdit: false, answer: nil),
    InterviewData(id: 18, question: "행복을 느끼는 때", isEdit: false, answer: nil),
]
