//
//  Questions.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/07.
//

import Foundation

struct Question {
    let id : Int
    let question : String
    let choice : [QuestionChoice]
    var userChoice : Int = 0
    var isChosen : Bool = false
}

struct QuestionChoice {
    let choiceContent : String
}

var valueQuestions: [Question] = [
    Question(id: 1, question: "연인관계를 주변에 알리는 것에 대해\n어떻게 생각하세요?", choice: [QuestionChoice(choiceContent: "관계가 깊어지기 전까지는 금물"), QuestionChoice(choiceContent: "가까운 사람에게만"), QuestionChoice(choiceContent: "당당하게 행동")], userChoice: 2),
    Question(id: 2, question: "연인과의 사생활 공유", choice: [QuestionChoice(choiceContent: "모든걸 공유"), QuestionChoice(choiceContent: "합의한 부분들에 대해서만 공유"), QuestionChoice(choiceContent: "사생활이나 비밀을 지켜주기")]),
    Question(id: 3, question: "이상적인 연애비용분담", choice: [QuestionChoice(choiceContent: "칼 더치페이 (5:5)"), QuestionChoice(choiceContent: "적당히 번갈아가며 (6:4)"), QuestionChoice(choiceContent: "여유 있는쪽이 더 부담 (7:3)")], userChoice: 1),
    Question(id: 4, question: "주말에 필요한 개인적인 시간", choice: [QuestionChoice(choiceContent: "딱히 생각해본적 없어요"), QuestionChoice(choiceContent: "가능하면 연인과 함께"), QuestionChoice(choiceContent: "하루 정도는 각자의 시간갖기")]),
    Question(id: 5, question: "애인이 다른 이성친구와 단둘이 만난다면", choice: [QuestionChoice(choiceContent: "친한 친구라면 술, 영화까지 가능"), QuestionChoice(choiceContent: "식사, 커피 외에는 불가"), QuestionChoice(choiceContent: "왜 단둘이 만나?")]),
    Question(id: 6, question: "연인과 얼마나 자주 연락하는게 좋나요?", choice: [QuestionChoice(choiceContent: "빠쁘더라도 최대한 자주"), QuestionChoice(choiceContent: "시간 여유가 있고 생각이 날 때 연락")]),
    Question(id: 7, question: "연인과의 갈등", choice: [QuestionChoice(choiceContent: "오해가 없게 바로바로 풀기"), QuestionChoice(choiceContent: "시간을 좀 갖고 진정된 후 풀기")]),
    Question(id: 8, question: "사귈 때 스킨십에 대한 생각", choice: [QuestionChoice(choiceContent: "스킨십도 연애의 중요한 요소"), QuestionChoice(choiceContent: "결혼 전 관계는 원치 않음")]),
    Question(id: 9, question: "SNS에 연인과의 사진 포스팅", choice: [QuestionChoice(choiceContent: "공개적으로 올리는건 부담"), QuestionChoice(choiceContent: "당당하게 올리는걸 선호")]),
    Question(id: 10, question: "시간 약속", choice: [QuestionChoice(choiceContent: "기본이므로 철저히 지켜야함"), QuestionChoice(choiceContent: "간혹 약속을 지키지 못해도 이해가능")]),
    Question(id: 11, question: "나중에 아이가 있었으면 하나요?", choice: [QuestionChoice(choiceContent: "지금은 원치 않아요"), QuestionChoice(choiceContent: "1~2 명의 아이"), QuestionChoice(choiceContent: "아니요")]),
    Question(id: 12, question: "미래에 부모님을 모실 수 있나요?", choice: [QuestionChoice(choiceContent: "상황에 따라 가능"), QuestionChoice(choiceContent: "모시기는 힘들고 다른 방법을 강구")]),
    Question(id: 13, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 14, question: "장거리 연애, 주말 부부", choice: [QuestionChoice(choiceContent: "사랑한다면 가능"), QuestionChoice(choiceContent: "장기적으로는 분명 어려움")]),
    Question(id: 15, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 16, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 17, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 18, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 19, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 20, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 21, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 22, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 23, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 24, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 25, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 26, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 27, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 28, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 29, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 30, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    
]
