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
                                 "Authorization": NetworkConstant.accessToken]
    
    static var accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjJkODA5NzMxZDIzN2MyMDhlYWFjZWExIn0sImlhdCI6MTY2MDIyOTI5MiwiZXhwIjoxNjYxNDM4ODkyfQ.QySrNWZLSOotLJwy-BlTOME5gYd7r1XB2WyJ29onUto"
}
