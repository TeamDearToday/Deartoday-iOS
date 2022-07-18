//
//  CheckMessageService.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/18.
//

import Moya

enum CheckMessageService {
    case checkMessage
}

extension CheckMessageService: BaseTargetType {
    var path: String {
        switch self {
        case .checkMessage:
            return URLConstant.answers
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .checkMessage:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return NetworkConstant.hasTokenHeader
    }
}
