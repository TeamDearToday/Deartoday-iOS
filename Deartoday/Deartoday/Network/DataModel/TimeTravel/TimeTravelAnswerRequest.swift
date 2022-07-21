//
//  TimeTravelAnswerResponse.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/18.
//

import UIKit

// MARK: - TimeTravel Answer Request

struct TimeTravelAnswerRequest: Codable {
    let title: String
    let year: Int
    let month: Int
    let day: Int
    let writtenDate: String
    let questions: [String]
    let answers: [String]
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case year = "year"
        case month = "month"
        case day = "day"
        case writtenDate = "writtenDate"
        case questions = "questions"
        case answers = "answers"
    }
}
