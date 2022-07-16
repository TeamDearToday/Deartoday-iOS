//
//  DTImagePickerViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/16.
//

import UIKit
import CoreGraphics

internal protocol DTImageCropControllerDelegate {
    func imageCropController(imageCropController: DTImageCropViewController, didFinishWithCroppedImage croppedImage: UIImage)
}

internal class DTImageCropViewController: UIViewController {
    var sourceImage: UIImage!
    var delegate: DTImageCropControllerDelegate?
    var cropSize: CGSize!
    var resizableCropArea = false

    private var croppedImage: UIImage!

    private var imageCropView: WDImageCropView!
    private var toolbar: UIToolbar!
    private var useButton: UIButton!
    private var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false

        self.title = "Choose Photo"

        self.setupNavigationBar()
        self.setupCropView()
        self.setupToolbar()

        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationController?.isNavigationBarHidden = true
        } else {
            self.navigationController?.isNavigationBarHidden = false
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.imageCropView.frame = self.view.bounds
        self.toolbar?.frame = CGRect.init(x: 0, y: self.view.frame.height - 54,
                                          width: self.view.frame.size.width, height: 54)
    }

    @objc func actionCancel(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func actionUse(sender: AnyObject) {
        croppedImage = self.imageCropView.croppedImage()
        self.delegate?.imageCropController(imageCropController: self, didFinishWithCroppedImage: croppedImage)
    }

    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                target: self, action: #selector(actionCancel))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Use", style: .plain,
            target: self, action: #selector(actionUse))
    }

    private func setupCropView() {
        self.imageCropView = WDImageCropView(frame: self.view.bounds)
        self.imageCropView.imageToCrop = sourceImage
        self.imageCropView.resizableCropArea = self.resizableCropArea
        self.imageCropView.cropSize = cropSize
        self.view.addSubview(self.imageCropView)
    }

    private func setupCancelButton() {
        self.cancelButton = UIButton()
        self.cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.cancelButton.titleLabel?.shadowOffset = CGSize(width: 0, height: -1)
        self.cancelButton.frame = CGRect(x: 0, y: 0, width: 58, height: 30)
        self.cancelButton.setTitle("Cancel", for: .normal)
        self.cancelButton.setTitleShadowColor(
            UIColor(red: 0.118, green: 0.247, blue: 0.455, alpha: 1), for: .normal)
        self.cancelButton.addTarget(self, action: #selector(actionCancel), for: .touchUpInside)
    }

    private func setupUseButton() {
        self.useButton = UIButton()
        self.useButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.useButton.titleLabel?.shadowOffset = CGSize(width: 0, height: -1)
        self.useButton.frame = CGRect.init(x: 0, y: 0, width: 58, height: 30)
        self.useButton.setTitle("Use", for: .normal)
        self.useButton.setTitleShadowColor(
            UIColor(red: 0.118, green: 0.247, blue: 0.455, alpha: 1), for: .normal)
        self.useButton.addTarget(self, action: #selector(actionUse), for: .touchUpInside)
    }

    private func toolbarBackgroundImage() -> UIImage {
        let components: [CGFloat] = [1, 1, 1, 1, 123.0 / 255.0, 125.0 / 255.0, 132.0 / 255.0, 1]

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 320, height: 54), true, 0)

        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: components, locations: nil, count: 2)!

        context!.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: 54), options: [])

        let viewImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return viewImage!
    }

    private func setupToolbar() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.toolbar = UIToolbar(frame: .zero)
            self.toolbar.isTranslucent = true
            self.toolbar.barStyle = .black
            self.view.addSubview(self.toolbar)

            self.setupCancelButton()
            self.setupUseButton()

            let info = UILabel(frame: CGRect.zero)
            info.text = ""
            info.textColor = UIColor(red: 0.173, green: 0.173, blue: 0.173, alpha: 1)
            info.backgroundColor = UIColor.clear
            info.shadowColor = UIColor(red: 0.827, green: 0.731, blue: 0.839, alpha: 1)
            info.shadowOffset = CGSize(width: 0, height: 1)
            info.font = UIFont.boldSystemFont(ofSize: 18)
            info.sizeToFit()

            let cancel = UIBarButtonItem(customView: self.cancelButton)
            let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let label = UIBarButtonItem(customView: info)
            let use = UIBarButtonItem(customView: self.useButton)

            self.toolbar.setItems([cancel, flex, label, flex, use], animated: false)
        }
    }
}
