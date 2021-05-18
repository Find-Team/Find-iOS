//
//  GetInterviewCategory.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/13.
//

import Foundation

func getInterviewCategory(questionIndex: Int) -> String {
    if questionIndex >= 1 && questionIndex <= 4 {
        return "장점"
    }
    else if questionIndex >= 5 && questionIndex <= 9 {
        return "연애"
    }
    else if questionIndex >= 10 && questionIndex <= 13 {
        return "호불호"
    }
    else if questionIndex >= 14 && questionIndex <= 18 {
        return "라이프"
    }
    else {
        return ""
    }
}
