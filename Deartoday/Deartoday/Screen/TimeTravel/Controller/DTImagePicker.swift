//
//  DTImagePicker.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/16.
//

import UIKit

public protocol DTImagePickerDelegate {
    func imagePicker(imagePicker: DTImagePicker, pickedImage: UIImage)
    func imagePickerDidCancel(imagePicker: DTImagePicker)
}

public class DTImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate, DTImageCropControllerDelegate {
    public var delegate: DTImagePickerDelegate?
    public var cropSize: CGSize!
    public var resizableCropArea = false

    private var _imagePickerController: UIImagePickerController!

    public var imagePickerController: UIImagePickerController {
        return _imagePickerController
    }
    
    override init() {
        super.init()

        self.cropSize = CGSize.init(width: 320, height: 320)
        _imagePickerController = UIImagePickerController()
        _imagePickerController.delegate = self
        _imagePickerController.sourceType = .photoLibrary
    }

    private func hideController() {
        self._imagePickerController.dismiss(animated: true, completion: nil)
    }

    public func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        if self.delegate?.imagePickerDidCancel != nil {
            self.delegate?.imagePickerDidCancel(imagePicker: self)
        } else {
            self.hideController()
        }
    }

    public func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let cropController = DTImageCropViewController()
        cropController.sourceImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
        cropController.resizableCropArea = self.resizableCropArea
        cropController.cropSize = self.cropSize
        cropController.delegate = self
        picker.pushViewController(cropController, animated: true)
    }

    func imageCropController(imageCropController: DTImageCropViewController, didFinishWithCroppedImage croppedImage: UIImage) {
        self.delegate?.imagePicker(imagePicker: self, pickedImage: croppedImage)
    }
}
