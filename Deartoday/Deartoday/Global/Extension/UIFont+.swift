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

// MARK: - Font StyleGuide

extension UIFont {

  class var h0: UIFont {
    return UIFont(name: "GmarketSans-Medium", size: 24.0)!
  }

  class var p1: UIFont {
    return UIFont(name: "Pretendard-Regular", size: 20.0)!
  }

  class var p5En: UIFont {
    return UIFont(name: "GmarketSans-Medium", size: 19.0)!
  }

  class var p0En: UIFont {
    return UIFont(name: "GmarketSans-Medium", size: 19.0)!
  }

  class var btn1En: UIFont {
    return UIFont(name: "GmarketSans-Bold", size: 16.0)!
  }

  class var btn0: UIFont {
    return UIFont(name: "Pretendard-Medium", size: 16.0)!
  }

  class var p2: UIFont {
    return UIFont(name: "Pretendard-Regular", size: 16.0)!
  }

  class var p4: UIFont {
    return UIFont(name: "Pretendard-Medium", size: 15.0)!
  }

  class var p3: UIFont {
    return UIFont(name: "Pretendard-Medium", size: 15.0)!
  }

  class var caption0: UIFont {
    return UIFont(name: "Pretendard-Regular", size: 14.0)!
  }

  class var onboard0: UIFont {
    return UIFont(name: "Pretendard-Regular", size: 13.0)!
  }

  class var caption1: UIFont {
    return UIFont(name: "Pretendard-Regular", size: 12.0)!
  }
    
}
