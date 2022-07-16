//
//  DT.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/16.
//

import UIKit

private struct DTResizableViewBorderMultiplyer {
    var widthMultiplyer: CGFloat!
    var heightMultiplyer: CGFloat!
    var xMultiplyer: CGFloat!
    var yMultiplyer: CGFloat!
}

internal class DTResizableCropOverlayView: DTImageCropOverlayView {
    private let kBorderCorrectionValue: CGFloat = 12

    var contentView: UIView!
    var cropBorderView: DTCropBorderView!

    private var initialContentSize = CGSize(width: 0, height: 0)
    private var resizingEnabled: Bool!
    private var anchor: CGPoint!
    private var startPoint: CGPoint!
    private var resizeMultiplyer = DTResizableViewBorderMultiplyer()

    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            super.frame = newValue

            let toolbarSize = CGFloat(UIDevice.current.userInterfaceIdiom == .pad ? 0 : 54)
            let width = self.bounds.size.width
            let height = self.bounds.size.height

            contentView?.frame = CGRect.init(x: (width - initialContentSize.width) / 2,
                                             y: (height - toolbarSize - initialContentSize.height) / 2,
                                             width: initialContentSize.width,
                                             height: initialContentSize.height)

            cropBorderView?.frame = CGRect.init(
                x: (width - initialContentSize.width) / 2 - kBorderCorrectionValue,
                y: (height - toolbarSize - initialContentSize.height) / 2 - kBorderCorrectionValue,
                width: initialContentSize.width + kBorderCorrectionValue * 2,
                height: initialContentSize.height + kBorderCorrectionValue * 2)
        }
    }

    init(frame: CGRect, initialContentSize: CGSize) {
        super.init(frame: frame)

        self.initialContentSize = initialContentSize
        self.addContentViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: cropBorderView)

            anchor = self.calculateAnchorBorder(anchorPoint: touchPoint)
            fillMultiplyer()
            resizingEnabled = true
            startPoint = touch.location(in: self.superview)
        }
    }

    func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            if resizingEnabled! {
                self.resizeWithTouchPoint(point: touch.location(in: self.superview))
            }
        }
    }

    override func draw(_ rect: CGRect) {
        //fill outer rect
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).set()
        UIRectFill(self.bounds)

        //fill inner rect
        UIColor.clear.set()
        UIRectFill(self.contentView.frame)
    }

    private func addContentViews() {
        let toolbarSize = CGFloat(UIDevice.current.userInterfaceIdiom == .pad ? 0 : 54)
        let width = self.bounds.size.width
        let height = self.bounds.size.height

        contentView = UIView(frame: CGRect.init(x: (width - initialContentSize.width) / 2,
                                                y: (height - toolbarSize - initialContentSize.height) / 2,
                                                width: initialContentSize.width,
                                                height: initialContentSize.height))
        contentView.backgroundColor = .clear
        self.cropSize = contentView.frame.size
        self.addSubview(contentView)

        cropBorderView = DTCropBorderView(frame: CGRect.init(
            x: (width - initialContentSize.width) / 2 - kBorderCorrectionValue,
            y: (height - toolbarSize - initialContentSize.height) / 2 - kBorderCorrectionValue,
            width: initialContentSize.width + kBorderCorrectionValue * 2,
            height: initialContentSize.height + kBorderCorrectionValue * 2))
        self.addSubview(cropBorderView)
    }

    private func calculateAnchorBorder(anchorPoint: CGPoint) -> CGPoint {
        let allHandles = getAllCurrentHandlePositions()
        var closest: CGFloat = 3000
        var anchor: CGPoint!

        for handlePoint in allHandles {
            // Pythagoras is watching you :-)
            let xDist = handlePoint.x - anchorPoint.x
            let yDist = handlePoint.y - anchorPoint.y
            let dist = sqrt(xDist * xDist + yDist * yDist)

            closest = dist < closest ? dist : closest
            anchor = closest == dist ? handlePoint : anchor
        }

        return anchor
    }

    private func getAllCurrentHandlePositions() -> [CGPoint] {
        let leftX: CGFloat = 0
        let rightX = cropBorderView.bounds.size.width
        let centerX = leftX + (rightX - leftX) / 2

        let topY: CGFloat = 0
        let bottomY = cropBorderView.bounds.size.height
        let middleY = topY + (bottomY - topY) / 2

        // starting with the upper left corner and then following the rect clockwise
        let topLeft = CGPoint(x: leftX, y: topY)
        let topCenter = CGPoint(x: centerX, y: topY)
        let topRight = CGPoint(x: rightX, y: topY)
        let middleRight = CGPoint(x: rightX, y: middleY)
        let bottomRight = CGPoint(x: rightX, y: bottomY)
        let bottomCenter = CGPoint(x: centerX, y: bottomY)
        let bottomLeft = CGPoint(x: leftX, y: bottomY)
        let middleLeft = CGPoint(x: leftX, y: middleY)

        return [topLeft, topCenter, topRight, middleRight, bottomRight, bottomCenter, bottomLeft,
            middleLeft]
    }

    private func resizeWithTouchPoint(point: CGPoint) {
        // This is the place where all the magic happends
        // prevent goint offscreen...
        let border = kBorderCorrectionValue * 2
        var pointX = point.x < border ? border : point.x
        var pointY = point.y < border ? border : point.y
        pointX = pointX > self.superview!.bounds.size.width - border ?
            self.superview!.bounds.size.width - border : pointX
        pointY = pointY > self.superview!.bounds.size.height - border ?
            self.superview!.bounds.size.height - border : pointY

        let heightChange = (pointY - startPoint.y) * resizeMultiplyer.heightMultiplyer
        let widthChange = (startPoint.x - pointX) * resizeMultiplyer.widthMultiplyer
        let xChange = -1 * widthChange * resizeMultiplyer.xMultiplyer
        let yChange = -1 * heightChange * resizeMultiplyer.yMultiplyer

        var newFrame =  CGRect.init(
            x: cropBorderView.frame.origin.x + xChange,
            y: cropBorderView.frame.origin.y + yChange,
            width: cropBorderView.frame.size.width + widthChange,
            height: cropBorderView.frame.size.height + heightChange);
        newFrame = self.preventBorderFrameFromGettingTooSmallOrTooBig(frame: newFrame)
        self.resetFrame(to: newFrame)
        startPoint = CGPoint(x: pointX, y: pointY)
    }

    private func preventBorderFrameFromGettingTooSmallOrTooBig(frame: CGRect) -> CGRect {
        let toolbarSize = CGFloat(UIDevice.current.userInterfaceIdiom == .pad ? 0 : 54)
        var newFrame = frame

        if newFrame.size.width < 64 {
            newFrame.size.width = cropBorderView.frame.size.width
            newFrame.origin.x = cropBorderView.frame.origin.x
        }
        if newFrame.size.height < 64 {
            newFrame.size.height = cropBorderView.frame.size.height
            newFrame.origin.y = cropBorderView.frame.origin.y
        }

        if newFrame.origin.x < 0 {
            newFrame.size.width = cropBorderView.frame.size.width +
                (cropBorderView.frame.origin.x - self.superview!.bounds.origin.x)
            newFrame.origin.x = 0
        }

        if newFrame.origin.y < 0 {
            newFrame.size.height = cropBorderView.frame.size.height +
                (cropBorderView.frame.origin.y - self.superview!.bounds.origin.y)
            newFrame.origin.y = 0
        }

        if newFrame.size.width + newFrame.origin.x > self.frame.size.width {
            newFrame.size.width = self.frame.size.width - cropBorderView.frame.origin.x
        }

        if newFrame.size.height + newFrame.origin.y > self.frame.size.height - toolbarSize {
            newFrame.size.height = self.frame.size.height -
                cropBorderView.frame.origin.y - toolbarSize
        }

        return newFrame
    }

    private func resetFrame(to frame: CGRect) {
        cropBorderView.frame = frame
        contentView.frame = frame.insetBy(dx: kBorderCorrectionValue, dy: kBorderCorrectionValue)
        cropSize = contentView.frame.size
        self.setNeedsDisplay()
        cropBorderView.setNeedsDisplay()
    }

    private func fillMultiplyer() {
        // -1 left, 0 middle, 1 right
        resizeMultiplyer.heightMultiplyer = anchor.y == 0 ?
            -1 : anchor.y == cropBorderView.bounds.size.height ? 1 : 0
        // -1 up, 0 middle, 1 down
        resizeMultiplyer.widthMultiplyer = anchor.x == 0 ?
            1 : anchor.x == cropBorderView.bounds.size.width ? -1 : 0
        // 1 left, 0 middle, 0 right
        resizeMultiplyer.xMultiplyer = anchor.x == 0 ? 1 : 0
        // 1 up, 0 middle, 0 down
        resizeMultiplyer.yMultiplyer = anchor.y == 0 ? 1 : 0
    }
}
