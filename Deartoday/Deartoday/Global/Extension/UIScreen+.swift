//
//  UIScreen+.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

extension UIScreen {
    var hasNotch: Bool {
        return !( (UIScreen.main.bounds.width / UIScreen.main.bounds.height) > 0.5 )
    }
}
