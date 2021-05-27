//
//  APITarget.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import Foundation
import Moya

//MARK: -API Lists
enum APITarget {
    case getMyMatching(_ userSequence: Int)
    case requestMatching(_ fromUserSequence: Int, _ matchingStatus: String, _ toUserSequence: Int)
}

extension APITarget: TargetType {
    
    //MARK: -baseURL
    var baseURL: URL {
        return URL(string: "http://15.164.213.118:8080")!
    }
    
    //MARK: -path
    var path: String {
        switch self {
        case .getMyMatching(let userSequence):
            return "/match/\(userSequence)"
        case .requestMatching:
            return "/match/"
        }
    }
    
    //MARK: -HTTP Method (get, post, put, delete...)
    var method: Moya.Method {
        switch self {
        case .getMyMatching:
            return .get
        case .requestMatching:
            return .post
        }
    }
    
    //MARK: -Fake Data for Testing
    var sampleData: Data {
        return Data()
    }
    
    
    //MARK: -Request Parameter Setting
    var task: Task {
        // 파라미터가 없다: .requestPlain
        // 파라미터가 있다: .requestParameters(parameters: [~], encoding: JSONEncoding.default)
        switch self {
        case .getMyMatching:
            // query로 추가
            return .requestParameters(parameters: ["offset" : 0], encoding: URLEncoding.queryString)
        case .requestMatching(let fromUserSequence, let matchingStatus, let toUserSequence):
            return .requestParameters(parameters: ["fromUserSequence": fromUserSequence, "matchingStatus": matchingStatus, "toUserSequence": toUserSequence], encoding: JSONEncoding.default)
        }
    }
    
    //MARK: -Response Type
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    //MARK: -HTTP header
    var headers: [String : String]? {
        switch self {
        case .getMyMatching, .requestMatching:
            return ["Content-Type" : "application/json"]
        }
    }
}

