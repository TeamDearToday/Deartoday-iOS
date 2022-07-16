//
//  DTImageCropView.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/16.
//

import UIKit
import QuartzCore

private class ScrollView: UIScrollView {
    fileprivate override func layoutSubviews() {
        super.layoutSubviews()

        if let zoomView = self.delegate?.viewForZooming?(in: self) {
            let boundsSize = self.bounds.size
            var frameToCenter = zoomView.frame

            // center horizontally
            if frameToCenter.size.width < boundsSize.width {
                frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
            } else {
                frameToCenter.origin.x = 0
            }

            // center vertically
            if frameToCenter.size.height < boundsSize.height {
                frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
            } else {
                frameToCenter.origin.y = 0
            }

            zoomView.frame = frameToCenter
        }
    }
}

internal class WDImageCropView: UIView, UIScrollViewDelegate {
    var resizableCropArea = false

    private var scrollView: UIScrollView!
    private var imageView: UIImageView!
    private var cropOverlayView: DTImageCropOverlayView!
    private var xOffset: CGFloat!
    private var yOffset: CGFloat!

    private static func scaleRect(rect: CGRect, scale: CGFloat) -> CGRect {
        return CGRect.init(
            x: rect.origin.x * scale,
            y: rect.origin.y * scale,
            width: rect.size.width * scale,
            height: rect.size.height * scale)
    }

    var imageToCrop: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }

    var cropSize: CGSize {
        get {
            return self.cropOverlayView.cropSize
        }
        set {
            if let view = self.cropOverlayView {
                view.cropSize = newValue
            } else {
                if self.resizableCropArea {
                    self.cropOverlayView = DTResizableCropOverlayView(frame: self.bounds,
                                                                      initialContentSize: CGSize(width: newValue.width, height: newValue.height))
                } else {
                    self.cropOverlayView = DTImageCropOverlayView(frame: self.bounds)
                }
                self.cropOverlayView.cropSize = newValue
                self.addSubview(self.cropOverlayView)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.isUserInteractionEnabled = true
        self.backgroundColor = .black
        
        self.scrollView = ScrollView(frame: frame)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.scrollView.clipsToBounds = false
        self.scrollView.backgroundColor = .clear
        self.addSubview(self.scrollView)

        self.imageView = UIImageView(frame: self.scrollView.frame)
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.backgroundColor = .black
        self.scrollView.addSubview(self.imageView)

        self.scrollView.minimumZoomScale = self.scrollView.frame.width / self.scrollView.frame.height
        self.scrollView.maximumZoomScale = 20
        self.scrollView.setZoomScale(1.0, animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if !resizableCropArea {
            return self.scrollView
        }

        let resizableCropView = cropOverlayView as! DTResizableCropOverlayView
        let outerFrame = resizableCropView.cropBorderView.frame.insetBy(dx: -10, dy: -10)

        if outerFrame.contains(point) {
            if resizableCropView.cropBorderView.frame.size.width < 60 ||
                resizableCropView.cropBorderView.frame.size.height < 60 {
                return super.hitTest(point, with: event)
            }

            let innerTouchFrame = resizableCropView.cropBorderView.frame.insetBy(dx: 30, dy: 30)
            if innerTouchFrame.contains(point) {
                return self.scrollView
            }

            let outBorderTouchFrame = resizableCropView.cropBorderView.frame.insetBy(dx: -10, dy: -10)
            if outBorderTouchFrame.contains(point) {
                return super.hitTest(point, with: event)
            }

            return super.hitTest(point, with: event)
        }

        return self.scrollView
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let size = self.cropSize;
        let toolbarSize = CGFloat(UIDevice.current.userInterfaceIdiom == .pad ? 0 : 54)
        self.xOffset = floor((self.bounds.width - size.width) * 0.5)
        self.yOffset = floor((self.bounds.height - toolbarSize - size.height) * 0.5)

        let height = self.imageToCrop!.size.height
        let width = self.imageToCrop!.size.width

        var factor: CGFloat = 0
        var factoredHeight: CGFloat = 0
        var factoredWidth: CGFloat = 0

        if width > height {
            factor = width / size.width
            factoredWidth = size.width
            factoredHeight =  height / factor
        } else {
            factor = height / size.height
            factoredWidth = width / factor
            factoredHeight = size.height
        }

        self.cropOverlayView.frame = self.bounds
        self.scrollView.frame = CGRect.init(x: xOffset, y: yOffset, width: size.width, height: size.height)
        self.scrollView.contentSize = CGSize(width: size.width, height: size.height)
        self.imageView.frame = CGRect.init(x: 0, y: floor((size.height - factoredHeight) * 0.5),
                                           width: factoredWidth, height: factoredHeight)
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    func croppedImage() -> UIImage {
        var visibleRect = resizableCropArea ?
            calcVisibleRectForResizeableCropArea() : calcVisibleRectForCropArea()

        let rectTransform = orientationTransformedRectOfImage(image: imageToCrop!)
        visibleRect = visibleRect.applying(rectTransform);

        let imageRef = imageToCrop!.cgImage!.cropping(to: visibleRect)
        let result = UIImage(cgImage: imageRef!, scale: imageToCrop!.scale,
            orientation: imageToCrop!.imageOrientation)

        return result
    }

    private func calcVisibleRectForResizeableCropArea() -> CGRect {
        let resizableView = cropOverlayView as! DTResizableCropOverlayView

        var sizeScale = self.imageView.image!.size.width / self.imageView.frame.size.width
        sizeScale *= self.scrollView.zoomScale

        var visibleRect = resizableView.contentView.convert(resizableView.contentView.bounds,
                                                            to: imageView)
        visibleRect = WDImageCropView.scaleRect(rect: visibleRect, scale: sizeScale)

        return visibleRect
    }

    private func calcVisibleRectForCropArea() -> CGRect {
        let scaleWidth = imageToCrop!.size.width / cropSize.width
        let scaleHeight = imageToCrop!.size.height / cropSize.height
        var scale: CGFloat = 0

        if cropSize.width == cropSize.height {
            scale = max(scaleWidth, scaleHeight)
        } else if cropSize.width > cropSize.height {
            scale = imageToCrop!.size.width < imageToCrop!.size.height ?
                max(scaleWidth, scaleHeight) :
                min(scaleWidth, scaleHeight)
        } else {
            scale = imageToCrop!.size.width < imageToCrop!.size.height ?
                min(scaleWidth, scaleHeight) :
                max(scaleWidth, scaleHeight)
        }

        // extract visible rect from scrollview and scale it
        var visibleRect = scrollView.convert(scrollView.bounds, to:imageView)
        visibleRect = WDImageCropView.scaleRect(rect: visibleRect, scale: scale)

        return visibleRect
    }

    private func orientationTransformedRectOfImage(image: UIImage) -> CGAffineTransform {
        var rectTransform: CGAffineTransform!

        switch image.imageOrientation {
        case .left:
            rectTransform = CGAffineTransform(rotationAngle: .pi / 2).translatedBy(
                x: 0, y: -image.size.height)
        case .right:
            rectTransform = CGAffineTransform(rotationAngle: .pi / 2).translatedBy(
                x: -image.size.width, y: 0)
        case .down:
            rectTransform = CGAffineTransform(rotationAngle: .pi).translatedBy(
                x: -image.size.width, y: -image.size.height)
        default:
            rectTransform = CGAffineTransform(rotationAngle: .pi / 2).translatedBy(
                x: 0, y: -image.size.height)
        }

        return rectTransform.scaledBy(x: image.scale, y: image.scale)
    }
}
