//
//  APIService.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import Foundation
import Moya

struct APIService {
    
    static let shared = APIService() // Sigletone Object
    let provider = MoyaProvider<APITarget>() // MoyaProvider 인스턴스 생성(요청을 보낼 때 사용해야함)
    
    // 이런식으로 쭉쭉 이어나가면 됨
    func getMyMatching(userSequence: Int, completion: @escaping (NetworkResult<GetMyMatchingData>)->(Void)) {
        let target: APITarget = .getMyMatching(userSequence)
        judgeObject(target, completion: completion)
    }
    
    func matchingRequest(fromUserSequence: Int, matchingStatus: String, toUserSequence: Int, completion: @escaping (NetworkResult<Any>)->(Void)) {
        let target: APITarget = .requestMatching(fromUserSequence, matchingStatus, toUserSequence)
        judgeSimpleObject(target, completion: completion)
    }
}

extension APIService {
    
    func judgeObject<T: Codable>(_ target: APITarget, completion: @escaping (NetworkResult<T>) -> Void) {
        provider.request(target) { response in
            switch response {
            case .success(let result):
                do {
                    let decoder = JSONDecoder()
                    let body = try decoder.decode(GenericResponse<T>.self, from: result.data)
                    if let data = body.info {
                        completion(.success(data))
                    }
                } catch {
                    print("구조체를 확인해보세요")
                }
            case .failure(let error):
                completion(.failure(error.response!.statusCode))
            }
        }
    }
    
    // Response Data 사용할 일 없을 때 사용
    func judgeSimpleObject(_ target: APITarget, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(target) { response in
            switch response {
            case .success(let result):
                do {
                    let decoder = JSONDecoder()
                    let body = try decoder.decode(PlainData.self, from: result.data)
                    completion(.success(body))
                } catch {
                    print("구조체를 확인해보세요")
                }
            case .failure(let error):
                completion(.failure(error.response!.statusCode))
            }
        }
    }
}
