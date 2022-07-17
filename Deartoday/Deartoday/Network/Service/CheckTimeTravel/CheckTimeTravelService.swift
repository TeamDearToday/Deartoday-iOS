//
//  CheckTimeTravelService.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/18.
//

import Moya

enum CheckTimeTravelService {
    case checkTimeTravel
}

extension CheckTimeTravelService: BaseTargetType {
    var path: String {
        switch self {
        case .checkTimeTravel:
            return URLConstant.timeTravel
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .checkTimeTravel:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return NetworkConstant.hasTokenHeader
    }
}
