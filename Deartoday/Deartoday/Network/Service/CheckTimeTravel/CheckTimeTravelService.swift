//
//  CheckTimeTravelService.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/18.
//

import Moya

enum CheckTimeTravelService {
    case checkTimeTravel
    case checkTimeTravelDetail(timeTravelId: String)
}

extension CheckTimeTravelService: BaseTargetType {
    var path: String {
        switch self {
        case .checkTimeTravel:
            return URLConstant.timeTravel
        case .checkTimeTravelDetail(let timeTravelId):
            return "\(URLConstant.timeTravel)/\(timeTravelId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkTimeTravel, .checkTimeTravelDetail(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .checkTimeTravel, .checkTimeTravelDetail(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return NetworkConstant.hasTokenHeader
    }
}
