//
//  GenericResponse.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    
    let status: Int
    let returnCode: String
    let returnMessage: String
    let info: T?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case returnCode = "returnCode"
        case returnMessage = "returnMessage"
        case info = "info"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        returnCode = (try? values.decode(String.self, forKey: .returnCode)) ?? ""
        returnMessage = (try? values.decode(String.self, forKey: .returnMessage)) ?? ""
        info = (try? values.decode(T.self, forKey: .info)) ?? nil
    }
    
}
