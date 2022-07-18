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
                                 "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjJkNTAyMWEyNDEzM2E4OTU3M2YzODM3In0sImlhdCI6MTY1ODE2NjQwNCwiZXhwIjoxNjU4MTcwMDA0fQ.NmPXwlvWf-hMmvn-DTOxTDKfQf_BxoR9NnH2GMSoUFI"]
}
