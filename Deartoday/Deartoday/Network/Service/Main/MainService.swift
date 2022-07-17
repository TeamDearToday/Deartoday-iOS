//
//  MainService.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/18.
//

import Moya

enum MainService {
    case main
}

extension MainService: BaseTargetType {
    var path: String {
        switch self {
        case .main:
            return URLConstant.main
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .main:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return NetworkConstant.hasTokenHeader
    }
}
