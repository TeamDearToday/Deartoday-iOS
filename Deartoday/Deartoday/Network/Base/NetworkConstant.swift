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
                                 "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjJkMDE3ZDlmYmU5OTAyZDc4MDhmZDk5In0sImlhdCI6MTY1ODIyNjgyNSwiZXhwIjoxNjU5NDM2NDI1fQ.irPgZNs3PSvhGWN1R8gMNlWnjKOLGlGosVEgpRVT_5g"]
    
    static var accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjJkMDE3ZDlmYmU5OTAyZDc4MDhmZDk5In0sImlhdCI6MTY1ODIxOTQ2NSwiZXhwIjoxNjU5NDI5MDY1fQ._MbCpp8PqnBM6y6J0OMjjrxMqGjLxBTFwpbPOtBAKX4"
}
