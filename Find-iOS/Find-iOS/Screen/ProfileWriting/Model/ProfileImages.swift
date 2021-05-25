//
//  ProfileImages.swift
//  Find-iOS
//
//  Created by Seri Park on 2021/05/18.
//

import UIKit

struct ProfileImages: Equatable {
    var images = [UIImage]()
    var isRep: Bool = false
    static func == (lhs: ProfileImages, rhs: ProfileImages) -> Bool {
        return lhs.images == rhs.images
    }
}

