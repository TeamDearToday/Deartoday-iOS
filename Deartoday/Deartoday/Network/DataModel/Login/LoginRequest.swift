//
//  LoginRequest.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/18.
//

import Foundation

// MARK: - LoginReqeust

struct LoginRequest: Codable {
    let social: String
    let socialToken: String
    let fcmToken: String
}
