//
//  TimeTravelVirtualSpaceModel.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/12.
//

import Foundation

struct VirtualSpaceDataModel: Codable {
    let image: String
}

extension VirtualSpaceDataModel {
    static let images: [VirtualSpaceDataModel] = [
        VirtualSpaceDataModel(image: ""),
        VirtualSpaceDataModel(image: ""),
        VirtualSpaceDataModel(image: ""),
        VirtualSpaceDataModel(image: "")
    ]
}
