//
//  TimeTravelQuestionResponse.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/18.
//

import Foundation

// MARK: - TimeTravelQuestion Response

struct TimeTravelQuestionResponse: Codable {
    let questions, lastMessage: [String]
}
