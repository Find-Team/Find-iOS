//
//  FeelingData.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/23.
//

import Foundation

struct Matching {
    let imageName: String
    let nickName: String
    let info: [String]
    let introduce: String?
    let section: Int?
}

struct ExpandableSection {
    var isExpanded: Bool
    var data: Matching
}

// 연결된 상대
var connectedDatas: [ExpandableSection] = [
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "한글_8자_옹야", info: ["26살","패션잡지에디터","서울"], introduce: "만나서 반가워!", section: 0)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "한글_8자_옹야", info: ["26살","패션잡지에디터","서울"], introduce: "만나서 반가워!", section: 0)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "한글_8자_옹야", info: ["26살","패션잡지에디터","서울"], introduce: "만나서 반가워!", section: 0)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "한글_8자_옹야", info: ["26살","패션잡지에디터","서울"], introduce: "만나서 반가워!", section: 0)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "한글_8자_옹야", info: ["26살","패션잡지에디터","서울"], introduce: "만나서 반가워!", section: 0)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "한글_8자_옹야", info: ["26살","패션잡지에디터","서울"], introduce: "만나서 반가워!", section: 0)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "한글_8자_옹야", info: ["26살","패션잡지에디터","서울"], introduce: "만나서 반가워!", section: 0)),
]

// 받은 호감
var receivedFeelings: [Matching] = [
    Matching(imageName: "", nickName: "받은_호감_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: nil),
    Matching(imageName: "", nickName: "받은_호감_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: nil),
    Matching(imageName: "", nickName: "받은_호감_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: nil),
    Matching(imageName: "", nickName: "받은_호감_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: nil),
    Matching(imageName: "", nickName: "받은_호감_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: nil),
]

// 보낸 호감
var sendedFeelings: [Matching] = [
    Matching(imageName: "", nickName: "보낸_호감_부분", info: ["26살","패션잡지에디터","서울"], introduce: "안녕하세요 나는 누군데에", section: nil),
    Matching(imageName: "", nickName: "보낸_호감_부분", info: ["26살","패션잡지에디터","서울"], introduce: "안녕하세요 나는 누군데에", section: nil),
    Matching(imageName: "", nickName: "보낸_호감_부분", info: ["26살","패션잡지에디터","서울"], introduce: "안녕하세요 나는 누군데에", section: nil),
    Matching(imageName: "", nickName: "보낸_호감_부분", info: ["26살","패션잡지에디터","서울"], introduce: "안녕하세요 나는 누군데에", section: nil),
    Matching(imageName: "", nickName: "보낸_호감_부분", info: ["26살","패션잡지에디터","서울"], introduce: "안녕하세요 나는 누군데에", section: nil),
]

// 받은 찜
var receivedDibs: [ExpandableSection] = [
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "받은_찜_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: 0)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "받은_찜_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: 0)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "받은_찜_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: 0)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "받은_찜_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: 0)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "받은_찜_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: 0)),
]

// 보낸 찜
var sendedDibs: [ExpandableSection] = [
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "보낸_찜_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: 1)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "보낸_찜_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: 1)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "보낸_찜_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: 1)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "보낸_찜_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: 1)),
    ExpandableSection(isExpanded: false, data: Matching(imageName: "", nickName: "보낸_찜_부분", info: ["26살","패션잡지에디터","서울"], introduce: nil, section: 1)),
]

