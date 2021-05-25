//
//  ValueFilter.swift
//  Find-iOS
//
//  Created by DANNA LEE on 2021/05/22.
//

import Foundation

struct ValueFilter {
    var question: String
    var isSame: Bool
}

var valueFilter: [ValueFilter] = [
    ValueFilter(question: "Q. 연인관계를 주변에 알리고 공개하는 것", isSame: true),
    ValueFilter(question: "Q. 연인과의 사생활 공유", isSame: false),
    ValueFilter(question: "Q. 이상적인 연애비용분담", isSame: true),
    ValueFilter(question: "Q. 모시기모시기모시기모시기모시기", isSame: true),
    ValueFilter(question: "Q. 이건 마지막 문제야 알겠징", isSame: false)
]
