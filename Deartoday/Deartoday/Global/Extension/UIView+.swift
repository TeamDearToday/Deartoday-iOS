//
//  UIView+.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

extension UIView {
    public func makeShadow(_ color: UIColor, _ opacity: Float, _ offset: CGSize, _ radius: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    public func makeRound(radius: CGFloat = 4) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    public func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
