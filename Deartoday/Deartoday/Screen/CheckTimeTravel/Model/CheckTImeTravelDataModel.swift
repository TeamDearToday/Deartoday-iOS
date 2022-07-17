//
//  CheckTImeTravelDataModel.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/13.
//

import Foundation

// MARK: - TapeDataModel

struct TimeTapeDataModel: Codable, Hashable {
    let timeTravelID, title: String
    let year, month, day: Int
    let writtenDate, image: String

    enum CodingKeys: String, CodingKey {
        case timeTravelID = "timeTravelId"
        case title, year, month, day, writtenDate, image
    }
}
