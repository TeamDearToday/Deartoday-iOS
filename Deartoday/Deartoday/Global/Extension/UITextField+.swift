//
//  UITextField+.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/08.
//

import UIKit

extension UITextField {
    func setPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: self.frame.height))
        
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
        
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
}
