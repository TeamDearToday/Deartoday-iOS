//
//  UILabel+.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

extension UILabel {
    public func addLetterSpacing(kernValue: Double = -0.3, paragraphValue: CGFloat = 4.0) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = paragraphValue
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            attributedText = attributedString
            lineBreakStrategy = .hangulWordPriority
            textAlignment = .center
        }
    }
    
    public func addLineSpacing(spacing: CGFloat) {
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.minimumLineHeight = spacing
            style.maximumLineHeight = spacing
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
            self.attributedText = attributeString
        }
    }
    
    ///Label의 일부만 색을 바꿀 수 있는 익스텐션
    func setPartialLabelColor(targetStringList: [String], color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        targetStringList.forEach {
            let range = (fullText as NSString).range(of: $0)
            attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        }
        attributedText = attributedString
    }
}


