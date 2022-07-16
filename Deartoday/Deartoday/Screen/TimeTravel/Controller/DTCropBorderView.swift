//
//  DTCropBorderView.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/16.
//

import UIKit

internal class DTCropBorderView: UIView {
    private let kNumberOfBorderHandles: CGFloat = 8
    private let kHandleDiameter: CGFloat = 24

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context!.setStrokeColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor)
        context!.setLineWidth(1.5)
        context!.addRect((CGRect.init(x: kHandleDiameter / 2, y: kHandleDiameter / 2, width: rect.size.width - kHandleDiameter, height: rect.size.height - kHandleDiameter)))
        context?.strokePath()
        
        context?.setFillColor(CGColor(red: 1, green: 1, blue: 1, alpha: 0.95))
        for handleRect in calculateAllNeededHandleRects() {
            context?.fillEllipse(in: handleRect)
        }
    }

    private func calculateAllNeededHandleRects() -> [CGRect] {
        let width = self.frame.width
        let height = self.frame.height

        let leftColX: CGFloat = 0
        let rightColX = width - kHandleDiameter
        let centerColX = rightColX / 2

        let topRowY: CGFloat = 0
        let bottomRowY = height - kHandleDiameter
        let middleRowY = bottomRowY / 2

        let topLeft = CGRect.init(x: leftColX, y: topRowY, width: kHandleDiameter, height: kHandleDiameter)
        let topCenter = CGRect.init(x: centerColX, y: topRowY, width: kHandleDiameter, height: kHandleDiameter)
        let topRight = CGRect.init(x: rightColX, y: topRowY, width: kHandleDiameter, height: kHandleDiameter)
        let middleRight = CGRect.init(x: rightColX, y: middleRowY, width: kHandleDiameter, height: kHandleDiameter)
        let bottomRight = CGRect.init(x: rightColX, y: bottomRowY, width: kHandleDiameter, height: kHandleDiameter)
        let bottomCenter = CGRect.init(x: centerColX, y: bottomRowY, width: kHandleDiameter, height: kHandleDiameter)
        let bottomLeft = CGRect.init(x: leftColX, y: bottomRowY, width: kHandleDiameter, height: kHandleDiameter)
        let middleLeft = CGRect.init(x: leftColX, y: middleRowY, width: kHandleDiameter, height: kHandleDiameter)

        return [topLeft, topCenter, topRight, middleRight, bottomRight, bottomCenter, bottomLeft,
            middleLeft]
    }
}
