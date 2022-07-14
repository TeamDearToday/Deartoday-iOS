//
//  CheckTImeTravelDataModel.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/13.
//

import Foundation

///추후 서버 연결 시 data model로 사용 가능하면 삭제
struct TimeTapeDataModel: Hashable {
    let timeTravelID, title: String
    let year, month, day: Int
    let writtenDate, image: String
}
