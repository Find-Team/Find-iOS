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
    ValueFilter(question: "Q. 애인이 다른 이성친구와 단둘이 만난다면", isSame: true),
    ValueFilter(question: "Q. 연인과의 갈등", isSame: false),
    ValueFilter(question: "Q. 주말에 필요한 개인적인 시간", isSame: true),
    ValueFilter(question: "Q. 사회생활 중 유흥업소 출입", isSame: true)
]
