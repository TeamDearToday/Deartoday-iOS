//
//  CheckTimeTravelDetailResponse.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/19.
//

import Foundation

// MARK: - CheckTimeTravelDetailResponse

struct CheckTimeTravelDetailResponse: Codable {
    let title: String
    let year, month, day: Int
    let writtenDate, image: String
    let messages: [Message]
}

// MARK: - Message

struct Message: Codable {
    let question, answer: String
}
