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
    let image: Data?
    let year: Int
    let month: Int
    let day: Int
    let currentDate: String
    let questions: [String]
    let answers: [String]
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case image = "image"
        case year = "year"
        case month = "month"
        case day = "day"
        case currentDate = "currentDate"
        case questions = "questions"
        case answers = "answers"
    }
    
    init(_ title: String, _ image: UIImage?, _ year: Int, _ month: Int, _ day: Int, _ currentDate: String, _ questions: [String], _ answers: [String]) {
        self.title = title
        self.image = image?.pngData()
        self.year = year
        self.month = month
        self.day = day
        self.currentDate = currentDate
        self.questions = questions
        self.answers = answers
    }
}
