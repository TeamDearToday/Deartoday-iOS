//
//  LoginService.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/18.
//

import Moya

enum LoginService {
    case login(param: LoginRequest)
}

extension LoginService: BaseTargetType {
    var path: String {
        switch self {
        case .login:
            return URLConstant.login
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        return NetworkConstant.noTokenHeader
    }
}
