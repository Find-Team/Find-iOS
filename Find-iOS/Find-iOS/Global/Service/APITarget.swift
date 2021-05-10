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
    case example_post(token: String, first: String, second: String)
    case example_get
}

extension APITarget: TargetType {
    
    //MARK: -baseURL
    var baseURL: URL {
        return URL(string: "http://~")!
    }
    
    //MARK: -path
    var path: String {
        switch self {
        case .example_post:
            return "/user/one"
        case .example_get:
            return "/user/two"
        }
    }
    
    //MARK: -HTTP Method (get, post, put, delete...)
    var method: Moya.Method {
        switch self {
        case .example_post:
            return .post
        case .example_get:
            return .get
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
        case .example_post(_, let email, let password):
            return .requestParameters(parameters: ["email" : email, "password": password], encoding: JSONEncoding.default)
        case .example_get:
            return .requestPlain
        }
        
    }
    
    //MARK: -Response Type
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    //MARK: -HTTP header
    var headers: [String : String]? {
        switch self {
        case .example_post(let token, _, _):
            return ["Content-Type" : "application/json", "token": token]
        case .example_get:
            return ["Content-Type" : "application/json"]
        }
    }
}

