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
    let choiceOne : String
    let choiceTwo : String
    let choiceThree : String
    var userChoice : Int = 0
}

var valueQuestions: [Question] = [
    Question(id: 1, question: "연인관계를 주변에 알리는 것에 대해\n어떻게 생각하세요?", choiceOne: "관계가 깊어지기 전까지는 금물", choiceTwo: "가까운 사람에게만", choiceThree: "당당하게 행동"),
    Question(id: 2, question: "개발 조아?", choiceOne: "네", choiceTwo: "아니오", choiceThree: "모르겠어요")]
