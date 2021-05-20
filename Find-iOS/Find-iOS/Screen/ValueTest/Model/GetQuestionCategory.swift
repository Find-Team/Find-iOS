//
//  GetQuestionCategory.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/07.
//

import Foundation

func getQuestionCategory(questionIndex: Int) -> String {
    if questionIndex >= 1 && questionIndex <= 10 {
        return "관계"
    }
    else if questionIndex >= 11 && questionIndex <= 20 {
        return "가족"
    }
    else if questionIndex >= 21 && questionIndex <= 30 {
        return "커리어"
    }
    else {
        return ""
    }
}
