//
//  CheckTimeTravelResponse.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/18.
//

import Foundation

// MARK: - CheckTimeTravelResponse

struct CheckTimeTravelResponse: Codable {
    let timeTravels: [TimeTapeDataModel]
}
