//
//  Questions.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/07.
//

import Foundation

struct Question {
    let id : Int /// 문제 id (1-30)
    let question : String /// 문제
    let choice : [QuestionChoice] /// 선택지 배열
    var userChoice : Int = 0 /// 사용자가 고른 답
    var isChosen : Bool = false /// 5개에 선택이 되었는지
}

struct QuestionChoice {
    let choiceContent : String /// 선택지 내용
}

var valueQuestions: [Question] = [
    Question(id: 1, question: "연인관계를 주변에 알리는 것", choice: [QuestionChoice(choiceContent: "관계가 깊어지기 전까지는 금물"), QuestionChoice(choiceContent: "가까운 사람에게만"), QuestionChoice(choiceContent: "당당하게 행동")]),
    Question(id: 2, question: "연인과의 사생활 공유", choice: [QuestionChoice(choiceContent: "모든걸 공유"), QuestionChoice(choiceContent: "합의한 부분들에 대해서만 공유"), QuestionChoice(choiceContent: "사생활이나 비밀을 지켜주기")]),
    Question(id: 3, question: "이상적인 연애비용분담", choice: [QuestionChoice(choiceContent: "칼 더치페이 (5:5)"), QuestionChoice(choiceContent: "적당히 번갈아가며 (6:4)"), QuestionChoice(choiceContent: "여유 있는쪽이 더 부담 (7:3)")]),
    Question(id: 4, question: "연인과 얼마나 자주 연락하는게 좋나요?", choice: [QuestionChoice(choiceContent: "빠쁘더라도 최대한 자주"), QuestionChoice(choiceContent: "시간 여유가 있고 생각이 날 때 연락")]),
    Question(id: 5, question: "애인이 다른 이성친구와 단둘이 만난다면", choice: [QuestionChoice(choiceContent: "친한 친구라면 술, 영화까지 가능"), QuestionChoice(choiceContent: "식사, 커피 외에는 불가"), QuestionChoice(choiceContent: "왜 단둘이 만나?")]),
    Question(id: 6, question: "관계에서의 우선순위", choice: [QuestionChoice(choiceContent: "연인이 가장 우선순위에요"), QuestionChoice(choiceContent: "오랜 친구들이 더 중요해요"), QuestionChoice(choiceContent: "친구, 지인, 연인 모두 중요해요")]),
    Question(id: 7, question: "연인과의 갈등", choice: [QuestionChoice(choiceContent: "오해가 없게 바로바로 풀기"), QuestionChoice(choiceContent: "시간을 좀 갖고 진정된 후 풀기")]),
    Question(id: 8, question: "사귈 때 스킨십에 대한 생각", choice: [QuestionChoice(choiceContent: "스킨십도 연애의 중요한 요소"), QuestionChoice(choiceContent: "결혼 전 관계는 원치 않음")]),
    Question(id: 9, question: "SNS에 연인과의 사진 포스팅", choice: [QuestionChoice(choiceContent: "공개적으로 올리는건 부담"), QuestionChoice(choiceContent: "당당하게 올리는걸 선호")]),
    Question(id: 10, question: "장거리 연애, 주말 부부", choice: [QuestionChoice(choiceContent: "사랑한다면 가능"), QuestionChoice(choiceContent: "장기적으로는 분명 어려움")]),
    Question(id: 11, question: "시간 약속", choice: [QuestionChoice(choiceContent: "기본이므로 철저히 지켜야함"), QuestionChoice(choiceContent: "간혹 약속을 지키지 못해도 이해가능")]),
    Question(id: 12, question: "주말에 필요한 개인적인 시간", choice: [QuestionChoice(choiceContent: "딱히 생각해본적 없어요"), QuestionChoice(choiceContent: "가능하면 연인과 함께"), QuestionChoice(choiceContent: "하루 정도는 나만의 시간필요")]),
    Question(id: 13, question: "직업 선택시 중요한 요소", choice: [QuestionChoice(choiceContent: "행복할 수 있는 일"), QuestionChoice(choiceContent: "안정적인 생활이 먼저")]),
    Question(id: 14, question: "자기계발", choice: [QuestionChoice(choiceContent: "일이 바빠 아직은 힘듦"), QuestionChoice(choiceContent: "일 외에도 적당히 하는 중"), QuestionChoice(choiceContent: "다양하게 매우 열심")]),
    Question(id: 15, question: "행복한 삶을 위해 필요한 경제력", choice: [QuestionChoice(choiceContent: "안정적인 삶이 가능한 정도면 충분"), QuestionChoice(choiceContent: "보통수준 이상의 경제력이 필수")]),
    Question(id: 16, question: "평소 생활리듬", choice: [QuestionChoice(choiceContent: "아침형"), QuestionChoice(choiceContent: "올빼미형")]),
    Question(id: 17, question: "20~30대 소비습관", choice: [QuestionChoice(choiceContent: "부족하더라도 미래를 위해 절약"), QuestionChoice(choiceContent: "젊을 때만 할 수 있는 것들을 위해 충분히 투자")]),
    Question(id: 18, question: "평소 운동", choice: [QuestionChoice(choiceContent: "규칙적으로 함"), QuestionChoice(choiceContent: "규칙적으로 못함")]),
    Question(id: 19, question: "종교의 중요성", choice: [QuestionChoice(choiceContent: "중요하지 않아요"), QuestionChoice(choiceContent: "정도를 지킨다면 괜찮아요"), QuestionChoice(choiceContent: "매우 중요해요")]),
    Question(id: 20, question: "정치성향", choice: [QuestionChoice(choiceContent: "보수에 가까워요"), QuestionChoice(choiceContent: "진보에 가까워요"), QuestionChoice(choiceContent: "무관심한 편이에요")]),
    Question(id: 21, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")]),
    Question(id: 22, question: "나중에 아이가 있었으면 하나요?", choice: [QuestionChoice(choiceContent: "지금은 원치 않아요"), QuestionChoice(choiceContent: "1~2 명의 아이"), QuestionChoice(choiceContent: "아니요")]),
    Question(id: 23, question: "미래에 부모님을 모실 수 있나요?", choice: [QuestionChoice(choiceContent: "상황에 따라 가능"), QuestionChoice(choiceContent: "모시기는 힘들고 다른 방법을 강구")]),
    Question(id: 24, question: "결혼 전 경제력", choice: [QuestionChoice(choiceContent: "충분히 뒷받침돼야만 함"), QuestionChoice(choiceContent: "함께 살림 차릴 정도면 가능"), QuestionChoice(choiceContent: "부족해도 같이 만들어가면 됨")]),
    Question(id: 25, question: "결혼 후 자산관리", choice: [QuestionChoice(choiceContent: "부부 각자 분리해서 관리"), QuestionChoice(choiceContent: "부부 공동으로 관리")]),
    Question(id: 26, question: "맞벌이 부부의 가사분담", choice: [QuestionChoice(choiceContent: "남편이 꼭 도울 필요는 없음"), QuestionChoice(choiceContent: "남편도 적극적으로 해야만 함"), QuestionChoice(choiceContent: "정해진 남녀 역할 구분이 없다고 봄")]),
    Question(id: 27, question: "반려동물", choice: [QuestionChoice(choiceContent: "키우고 싶어요"), QuestionChoice(choiceContent: "키우기는 어려워요"), QuestionChoice(choiceContent: "배우자와 협의")]),
    Question(id: 28, question: "배우자의 종교생활", choice: [QuestionChoice(choiceContent: "배우자에 맞춰 줄 수 있음"), QuestionChoice(choiceContent: "각자의 종교활동은 존중 해야 함"), QuestionChoice(choiceContent: "이해할 수 없음")]),
    Question(id: 29, question: "사회생활 중 유흥업소 출입", choice: [QuestionChoice(choiceContent: "사회생활이라 불가피, 이해가능"), QuestionChoice(choiceContent: "어떠한 이유에서도 가지 않는게 맞음")]),
    Question(id: 30, question: "사랑하는 이의 부채", choice: [QuestionChoice(choiceContent: "결혼 전의 부채는 스스로"), QuestionChoice(choiceContent: "불가피한 상황이라면 함께 부담")])
]


var yourValueQuestions: [Question] = [
    Question(id: 1, question: "연인관계를 주변에 알리는 것", choice: [QuestionChoice(choiceContent: "관계가 깊어지기 전까지는 금물"), QuestionChoice(choiceContent: "가까운 사람에게만"), QuestionChoice(choiceContent: "당당하게 행동")], userChoice: 3),
    Question(id: 2, question: "연인과의 사생활 공유", choice: [QuestionChoice(choiceContent: "모든걸 공유"), QuestionChoice(choiceContent: "합의한 부분들에 대해서만 공유"), QuestionChoice(choiceContent: "사생활이나 비밀을 지켜주기")], userChoice: 3),
    Question(id: 3, question: "이상적인 연애비용분담", choice: [QuestionChoice(choiceContent: "칼 더치페이 (5:5)"), QuestionChoice(choiceContent: "적당히 번갈아가며 (6:4)"), QuestionChoice(choiceContent: "여유 있는쪽이 더 부담 (7:3)")], userChoice: 2),
    Question(id: 4, question: "연인과 얼마나 자주 연락하는게 좋나요?", choice: [QuestionChoice(choiceContent: "빠쁘더라도 최대한 자주"), QuestionChoice(choiceContent: "시간 여유가 있고 생각이 날 때 연락")], userChoice: 1),
    Question(id: 5, question: "애인이 다른 이성친구와 단둘이 만난다면", choice: [QuestionChoice(choiceContent: "친한 친구라면 술, 영화까지 가능"), QuestionChoice(choiceContent: "식사, 커피 외에는 불가"), QuestionChoice(choiceContent: "왜 단둘이 만나?")], userChoice: 3),
    Question(id: 6, question: "관계에서의 우선순위", choice: [QuestionChoice(choiceContent: "연인이 가장 우선순위에요"), QuestionChoice(choiceContent: "오랜 친구들이 더 중요해요"), QuestionChoice(choiceContent: "친구, 지인, 연인 모두 중요해요")], userChoice: 3),
    Question(id: 7, question: "연인과의 갈등", choice: [QuestionChoice(choiceContent: "오해가 없게 바로바로 풀기"), QuestionChoice(choiceContent: "시간을 좀 갖고 진정된 후 풀기")], userChoice: 1),
    Question(id: 8, question: "사귈 때 스킨십에 대한 생각", choice: [QuestionChoice(choiceContent: "스킨십도 연애의 중요한 요소"), QuestionChoice(choiceContent: "결혼 전 관계는 원치 않음")], userChoice: 1),
    Question(id: 9, question: "SNS에 연인과의 사진 포스팅", choice: [QuestionChoice(choiceContent: "공개적으로 올리는건 부담"), QuestionChoice(choiceContent: "당당하게 올리는걸 선호")], userChoice: 2),
    Question(id: 10, question: "장거리 연애, 주말 부부", choice: [QuestionChoice(choiceContent: "사랑한다면 가능"), QuestionChoice(choiceContent: "장기적으로는 분명 어려움")], userChoice: 1),
    Question(id: 11, question: "시간 약속", choice: [QuestionChoice(choiceContent: "기본이므로 철저히 지켜야함"), QuestionChoice(choiceContent: "간혹 약속을 지키지 못해도 이해가능")], userChoice: 2),
    Question(id: 12, question: "주말에 필요한 개인적인 시간", choice: [QuestionChoice(choiceContent: "딱히 생각해본적 없어요"), QuestionChoice(choiceContent: "가능하면 연인과 함께"), QuestionChoice(choiceContent: "하루 정도는 나만의 시간필요")], userChoice: 1),
    Question(id: 13, question: "직업 선택시 중요한 요소", choice: [QuestionChoice(choiceContent: "행복할 수 있는 일"), QuestionChoice(choiceContent: "안정적인 생활이 먼저")], userChoice: 1),
    Question(id: 14, question: "자기계발", choice: [QuestionChoice(choiceContent: "일이 바빠 아직은 힘듦"), QuestionChoice(choiceContent: "일 외에도 적당히 하는 중"), QuestionChoice(choiceContent: "다양하게 매우 열심")], userChoice: 3),
    Question(id: 15, question: "행복한 삶을 위해 필요한 경제력", choice: [QuestionChoice(choiceContent: "안정적인 삶이 가능한 정도면 충분"), QuestionChoice(choiceContent: "보통수준 이상의 경제력이 필수")], userChoice: 1),
    Question(id: 16, question: "평소 생활리듬", choice: [QuestionChoice(choiceContent: "아침형"), QuestionChoice(choiceContent: "올빼미형")], userChoice: 2),
    Question(id: 17, question: "20~30대 소비습관", choice: [QuestionChoice(choiceContent: "부족하더라도 미래를 위해 절약"), QuestionChoice(choiceContent: "젊을 때만 할 수 있는 것들을 위해 충분히 투자")], userChoice: 2),
    Question(id: 18, question: "평소 운동", choice: [QuestionChoice(choiceContent: "규칙적으로 함"), QuestionChoice(choiceContent: "규칙적으로 못함")], userChoice: 1),
    Question(id: 19, question: "종교의 중요성", choice: [QuestionChoice(choiceContent: "중요하지 않아요"), QuestionChoice(choiceContent: "정도를 지킨다면 괜찮아요"), QuestionChoice(choiceContent: "매우 중요해요")], userChoice: 2),
    Question(id: 20, question: "정치성향", choice: [QuestionChoice(choiceContent: "보수에 가까워요"), QuestionChoice(choiceContent: "진보에 가까워요"), QuestionChoice(choiceContent: "무관심한 편이에요")], userChoice: 1),
    Question(id: 21, question: "사랑하는 사람이 생긴다면 결혼은?", choice: [QuestionChoice(choiceContent: "1~2 년 이내라도 고려"), QuestionChoice(choiceContent: "아직 결혼생각은 이름"), QuestionChoice(choiceContent: "비혼주의")], userChoice: 2),
    Question(id: 22, question: "나중에 아이가 있었으면 하나요?", choice: [QuestionChoice(choiceContent: "지금은 원치 않아요"), QuestionChoice(choiceContent: "1~2 명의 아이"), QuestionChoice(choiceContent: "아니요")], userChoice: 2),
    Question(id: 23, question: "미래에 부모님을 모실 수 있나요?", choice: [QuestionChoice(choiceContent: "상황에 따라 가능"), QuestionChoice(choiceContent: "모시기는 힘들고 다른 방법을 강구")], userChoice: 1),
    Question(id: 24, question: "결혼 전 경제력", choice: [QuestionChoice(choiceContent: "충분히 뒷받침돼야만 함"), QuestionChoice(choiceContent: "함께 살림 차릴 정도면 가능"), QuestionChoice(choiceContent: "부족해도 같이 만들어가면 됨")], userChoice: 1),
    Question(id: 25, question: "결혼 후 자산관리", choice: [QuestionChoice(choiceContent: "부부 각자 분리해서 관리"), QuestionChoice(choiceContent: "부부 공동으로 관리")], userChoice: 2),
    Question(id: 26, question: "맞벌이 부부의 가사분담", choice: [QuestionChoice(choiceContent: "남편이 꼭 도울 필요는 없음"), QuestionChoice(choiceContent: "남편도 적극적으로 해야만 함"), QuestionChoice(choiceContent: "정해진 남녀 역할 구분이 없다고 봄")], userChoice: 3),
    Question(id: 27, question: "반려동물", choice: [QuestionChoice(choiceContent: "키우고 싶어요"), QuestionChoice(choiceContent: "키우기는 어려워요"), QuestionChoice(choiceContent: "배우자와 협의")], userChoice: 1),
    Question(id: 28, question: "배우자의 종교생활", choice: [QuestionChoice(choiceContent: "배우자에 맞춰 줄 수 있음"), QuestionChoice(choiceContent: "각자의 종교활동은 존중 해야 함"), QuestionChoice(choiceContent: "이해할 수 없음")], userChoice: 2),
    Question(id: 29, question: "사회생활 중 유흥업소 출입", choice: [QuestionChoice(choiceContent: "사회생활이라 불가피, 이해가능"), QuestionChoice(choiceContent: "어떠한 이유에서도 가지 않는게 맞음")], userChoice: 2),
    Question(id: 30, question: "사랑하는 이의 부채", choice: [QuestionChoice(choiceContent: "결혼 전의 부채는 스스로"), QuestionChoice(choiceContent: "불가피한 상황이라면 함께 부담")], userChoice: 2)
]

struct DummyQuestions {
    let id: Int
    let question: String
    let answer: String
}

var sameQuestions: [DummyQuestions] = [
    DummyQuestions(id: 1, question: "연인관계를 주변에 알리고 공개하는 것", answer: "당당하게 행동"),
    DummyQuestions(id: 2, question: "연인과의 사생활 공유", answer: "사생활이나 비밀은 지켜주기"),
    DummyQuestions(id: 3, question: "이상적인 연애비용분담", answer: "적당히 번갈아가며 (6:4)"),
    DummyQuestions(id: 4, question: "연애중 연락빈도", answer: "바쁘더라도 최대한 자주"),
    DummyQuestions(id: 5, question: "애인이 다른 이성친구와 단둘이 만난다면", answer: "왜 단둘이 만나?"),
    DummyQuestions(id: 8, question: "사귈 때 스킨십에 대한 생각", answer: "스킨십도 연애의 중요한 요소"),
    DummyQuestions(id: 1, question: "시간 약속", answer: "간혹 약속을 지키지 못해도 이해가능"),
    DummyQuestions(id: 2, question: "주말에 필요한 개인적인 시간", answer: "하루 정도는 나만의 시간필요"),
    DummyQuestions(id: 8, question: "평소 운동", answer: "규칙적으로 함"),
    DummyQuestions(id: 9, question: "종교의 중요성", answer: "정도를 지킨다면 괜찮아요"),
    DummyQuestions(id: 10, question: "정치성향", answer: "보수에 가까워요"),
    DummyQuestions(id: 2, question: "나중에 아이가 있었으면 하나요?", answer: "1~2 명의 아이"),
    DummyQuestions(id: 3, question: "미래에 부모님을 모실 수 있나요?", answer: "상황에 따라 가능"),
    DummyQuestions(id: 5, question: "결혼 후 자산관리", answer: "부부 공동으로 관리"),
    DummyQuestions(id: 6, question: "맞벌이 부부의 가사분담", answer: "정해진 남녀 역할구분이 없다고봄"),
    DummyQuestions(id: 7, question: "반려동물", answer: "키우고 싶어요"),
    DummyQuestions(id: 8, question: "배우자의 종교생활", answer: "각자의 종교활동은 존중 해야함"),
    DummyQuestions(id: 9, question: "사회생활 중 유흥업소 출입", answer: "어떠한 이유에서도 가지 않는게 맞음")
]

var differentQuestions: [DummyQuestions] = [
    DummyQuestions(id: 6, question: "관계에서의 우선순위", answer: "연인이 가장 우선순위에요"),
    DummyQuestions(id: 7, question: "연인과의 갈등", answer: "시간을 좀 갖고 진정된 후 풀기"),
    DummyQuestions(id: 9, question: "SNS에 연인과의 사진 포스팅", answer: "공개적으로 올리는건 부담"),
    DummyQuestions(id: 10, question: "장거리 연애, 주말 부부", answer: "장기적으로는 분명 어려움"),
    DummyQuestions(id: 3, question: "직업 선택시 중요한 요소", answer: "안정적인 생활이 먼저"),
    DummyQuestions(id: 4, question: "자기계발", answer: "일이 바빠 아직은 힘듬"),
    DummyQuestions(id: 5, question: "행복한 삶을 위해 필요한 경제력", answer: "보통수준 이상의 경제력이 필수"),
    DummyQuestions(id: 6, question: "평소 생활리듬", answer: "아침형"),
    DummyQuestions(id: 7, question: "20~30대 소비습관", answer: "부족하더라도 미래를 위해 절약"),
    DummyQuestions(id: 1, question: "사랑하는 사람이 생긴다면 결혼은?", answer: "1~2 년 이내라도 고려"),
    DummyQuestions(id: 4, question: "결혼 전 경제력", answer: "함께 살림 차릴 정도면 가능"),
    DummyQuestions(id: 10, question: "사랑하는 이의 부채", answer: "결혼전의 부채는 스스로")
]
