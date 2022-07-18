//
//  LoginRequest.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/18.
//

import Foundation

// MARK: - LoginReqeust

struct LoginRequest {
    let social: String = "APPLE"
    let socialToken: String
    let fcmToken: String
}
