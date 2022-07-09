//
//  UIFont+.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/09.
//

import UIKit

extension UIFont {
    
    // MARK: - Pretendard
    
    public enum PretendardType: String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "SemiBold"
    }
    
    static func Pretendard(_ type: PretendardType, size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-\(type.rawValue)", size: size)!
    }
    
    // MARK: - GmarketSans
    
    public enum GmarketSansType: String {
        case bold = "Bold"
        case medium = "Medium"
    }
    
    static func GmarketSans(_ type: GmarketSansType, size: CGFloat) -> UIFont {
        return UIFont(name: "GmarketSans\(type.rawValue)", size: size)!
    }
}
