//
//  InterviewImages.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/16.
//

import UIKit

struct InterviewImages: Equatable {
    let category : String
    var images = [UIImage]()
    
    static func == (lhs: InterviewImages, rhs: InterviewImages) -> Bool {
        return lhs.images == rhs.images
    }
}

// MARK: - 장점, 연애, 호불호, 라이프 별 이미지
var interviewImgs: [InterviewImages] = [
    InterviewImages(category: "pros", images: []),
    InterviewImages(category: "love", images: []),
    InterviewImages(category: "taste", images: []),
    InterviewImages(category: "life", images: []),
]
