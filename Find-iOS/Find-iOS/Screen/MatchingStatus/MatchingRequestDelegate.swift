//
//  MatchingRequestDelegate.swift
//  Find-iOS
//
//  Created by Wonseok Lee on 2021/05/27.
//

import Foundation

protocol MatchingRequest {
    func matchingAPI(fromUserSequence: Int, matchingStatus: String, toUserSequence: Int)
}
