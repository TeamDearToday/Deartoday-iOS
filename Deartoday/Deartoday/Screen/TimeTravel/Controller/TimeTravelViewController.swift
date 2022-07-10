//
//  TimeTravelViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/08.
//

import UIKit

import SnapKit
import Then

import Photos
import PhotosUI

final class TimeTravelViewController: UIViewController {
    
    // MARK: - Property
    
    private var todayDate = Date()
    
    private var momentDate = Date()
    
    private let dateFormatter = DateFormatter().then {
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(abbreviation: "ko_kr")
        $0.dateFormat = "yyyy.MM.dd"
    }
    
    // MARK: - UI Property
    
    private var backImageView = UIImageView().then {
        $0.image = Constant.Image.mainLeftWithg
    }
    
    private var coverView = UIView().then {
        $0.backgroundColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 0.8)
    }
    
    private var yearBackView = UIImageView().then {
        $0.image = Constant.Image.bgYear
    }
    
    private var yearLabel = UILabel().then {
        $0.text = "2022"
        $0.textColor = .lightBlue00
        $0.font = UIFont.GmarketSans(.medium, size: 24)
    }
    
    private var monthBackView = UIImageView().then {
        $0.image = Constant.Image.bgDate
    }
    
    private var monthLabel = UILabel().then {
        $0.text = "07"
        $0.textColor = .lightBlue00
        $0.font = UIFont.GmarketSans(.medium, size: 24)
    }
    
    private var dateBackView = UIImageView().then {
        $0.image = Constant.Image.bgDate
    }
    
    private var dateLabel = UILabel().then {
        $0.text = "02"
        $0.textColor = .lightBlue00
        $0.font = UIFont.GmarketSans(.medium, size: 24)
    }
    
    private lazy var exitButton = UIButton().then {
        $0.setImage(Constant.Image.icExit, for: .normal)
        $0.setImage(Constant.Image.icExit, for: .highlighted)
        $0.addTarget(self, action: #selector(exitButtonDidTap), for: .touchUpInside)
    }
    
    private var guideLabel = UILabel().then {
        $0.text = """
                  테이프를 터치하여
                  돌아가고 싶은 순간을 선택해주세요
                  """
        $0.font = UIFont.p2
        $0.textColor = .white
        $0.numberOfLines = 2
        $0.addLineSpacing(spacing: 20)
    }
    
    private var timeTravelView = TimeTravelView().then {
        $0.hasPhoto = false
        $0.isUserInteractionEnabled = true
    }
    
    lazy var returnButton = DDSButton().then {
        $0.text = "과거로 돌아가기"
        $0.hasLeftIcon = true
        $0.style = .disable
        $0.addTarget(self, action: #selector(returnButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        getNotification()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        view.backgroundColor = .white
        
        [yearBackView, monthBackView, dateBackView].forEach {
            $0.layer.applySketchShadow(color: UIColor(red: 0 / 255,
                                                      green: 26 / 255,
                                                      blue: 255 / 255,
                                                      alpha: 0.14),
                                       alpha: 1,
                                       x: 0,
                                       y: 0,
                                       blur: 10,
                                       spread: 0)
            $0.makeRound(radius: 8)
        }
        
        timeTravelView.delegate = self
    }
    
    private func setLayout() {
        view.addSubviews([backImageView,
                          coverView,
                          monthBackView,
                          yearBackView,
                          dateBackView,
                          exitButton,
                          guideLabel,
                          timeTravelView,
                          returnButton])
        
        yearBackView.addSubview(yearLabel)
        monthBackView.addSubview(monthLabel)
        dateBackView.addSubview(dateLabel)
        
        backImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        coverView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        yearBackView.snp.makeConstraints {
            $0.width.equalTo(114)
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(6)
        }
        
        monthBackView.snp.makeConstraints {
            $0.width.equalTo(73)
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(106)
        }
        
        dateBackView.snp.makeConstraints {
            $0.width.equalTo(73)
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(165)
        }
        
        [yearLabel, monthLabel, dateLabel].forEach {
            $0.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(14)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(44)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(yearBackView.snp.bottom).offset(56)
            $0.leading.equalToSuperview().inset(16)
        }
        
        timeTravelView.snp.makeConstraints {
            $0.top.equalTo(yearBackView.snp.bottom).offset(119)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(380)
        }
        
        returnButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(6)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
        }
    }
    
    // MARK: - @objc
    
    @objc func exitButtonDidTap() {
        dismiss(animated: true)
    }
    
    @objc func returnButtonDidTap() {
        UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseOut) {
            self.guideLabel.alpha = 0
            self.timeTravelView.dateTextField.alpha = 0
            self.timeTravelView.titleTextField.alpha = 0
            self.returnButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut) {
                self.timeTravelView.alpha = 0
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.timeTravelView.snp.updateConstraints {
                $0.top.equalTo(self.yearBackView.snp.bottom).offset(52)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.timeTravelView.snp.updateConstraints {
                $0.top.equalTo(self.yearBackView.snp.bottom).offset(119)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func enableReturnButton(_ notification: Notification) {
        returnButton.style = .present
    }
    
    // MARK: - Custom Method
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(enableReturnButton(_:)), name: NSNotification.Name("EnableReturnButton"), object: nil)
    }
    
    private func openPHPicker() {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 1
        let controller = PHPickerViewController(configuration: config)
        
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
}

// MARK: - PHPicker Delegate

extension TimeTravelViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard !results.isEmpty else {
            return
        }
        
        let imageResult = results[0]
        
        if let assetId = imageResult.assetIdentifier {
            let assetResults = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil)
            DispatchQueue.main.async {
                self.timeTravelView.hasPhoto = true
                if let date = assetResults.firstObject?.creationDate {
                    self.timeTravelView.dateText = self.dateFormatter.string(from: date)
                }
            }
        }
        
        if imageResult.itemProvider.canLoadObject(ofClass: UIImage.self) {
            imageResult.itemProvider.loadObject(ofClass: UIImage.self) { (selectedImage, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.timeTravelView.photoImage = selectedImage as? UIImage
                    }
                }
            }
        }
    }
}

// MARK: - Custom Delegate

extension TimeTravelViewController: TimeTravelViewDelegate {
    func photoImageViewDidTap() {
        openPHPicker()
    }
}
