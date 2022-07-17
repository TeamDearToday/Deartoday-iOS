//
//  TimeTravelService.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/17.
//

import Moya

enum TimeTravelService {
    case oldMedia(year: Int)
}

extension TimeTravelService: BaseTargetType {
    var path: String {
        switch self {
        case .oldMedia:
            return URLConstant.oldMedia
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .oldMedia(let year):
            return .requestParameters(
                parameters: ["year": year],
                encoding: URLEncoding.queryString)
        
        }
    }
    
    var headers: [String : String]? {
        return NetworkConstant.hasTokenHeader
    }
}

