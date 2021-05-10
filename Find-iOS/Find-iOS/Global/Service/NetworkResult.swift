//
//  NetworkResult.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failure(Int)
}
