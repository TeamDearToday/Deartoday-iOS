//
//  TimeTravelVirtualSpaceModel.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/12.
//

import Foundation

struct TimeTravelVirtualSpaceDataModel: Codable {
    let image: String
}

extension TimeTravelVirtualSpaceDataModel {
    static let images: [TimeTravelVirtualSpaceDataModel] = [
        TimeTravelVirtualSpaceDataModel(image: ""),
        TimeTravelVirtualSpaceDataModel(image: ""),
        TimeTravelVirtualSpaceDataModel(image: ""),
        TimeTravelVirtualSpaceDataModel(image: "")
    ]
}
