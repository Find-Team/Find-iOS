//
//  GetMyMatchingData.swift
//  Find-iOS
//
//  Created by Wonseok Lee on 2021/05/27.
//

import Foundation

// MARK: - Info
struct GetMyMatchingData: Codable {
    let connected,receivedFeeling, sendFeeling, receivedDibs, sendDibs: [Connected]
}

// MARK: - Connected
struct Connected: Codable {
    let userSequence: Int
    let profileImageURL: String
    let nickName: String
    let age: Int
    let job, location, directMessage: String

    enum CodingKeys: String, CodingKey {
        case userSequence
        case profileImageURL = "profileImageUrl"
        case nickName, age, job, location, directMessage
    }
}

