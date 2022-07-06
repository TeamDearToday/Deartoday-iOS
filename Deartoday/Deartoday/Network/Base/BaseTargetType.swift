//
//  BaseTargetType.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType {
    
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
    
    var sampleData: Data {
        return Data()
    }
}
