//
//  UIScreen+.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

extension UIScreen {
    public var hasNotch: Bool{
        let deviceRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        if deviceRatio > 0.5{
            return false
        } else {
            return true
        }
    }
}
