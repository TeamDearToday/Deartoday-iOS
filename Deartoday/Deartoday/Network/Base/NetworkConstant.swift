//
//  NetworkConstatn.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import Foundation

struct NetworkConstant {
    
    static let noTokenHeader = ["Content-Type": "application/json"]
    static let hasTokenHeader = ["Content-Type": "application/json",
                                 "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjJjZTgwZDk2ZDZlMjJlOGMzNjFhNDVkIn0sImlhdCI6MTY1ODE0ODY5MywiZXhwIjoxNjU4MTUyMjkzfQ.g7i4SLpLy2dffMRiVUR7PsjmDioNXNtc0HqlugyV8ts"]
    
    static var accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjJkM2FmYjZhOTc0MWNmMjFhOTg5ZTk0In0sImlhdCI6MTY1ODA3MjM2NywiZXhwIjoxNjU4MDc1OTY3fQ.EOSvL0yAlCnyMv4rBIGvWWPCDfFnu9Pw-1w-fkX8ITg"
}
