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
}

struct QuestionChoice {
    let choiceContent : String
}

var valueQuestions: [Question] = [
    Question(id: 1, question: "연인관계를 주변에 알리는 것에 대해\n어떻게 생각하세요?", choice: [QuestionChoice(choiceContent: "관계가 깊어지기 전까지는 금물"), QuestionChoice(choiceContent: "가까운 사람에게만"), QuestionChoice(choiceContent: "당당하게 행동")])]
