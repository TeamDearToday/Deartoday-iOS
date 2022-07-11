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

import Lottie

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
        $0.font = .h0
    }
    
    private var monthBackView = UIImageView().then {
        $0.image = Constant.Image.bgDate
    }
    
    private var monthLabel = UILabel().then {
        $0.text = "07"
        $0.textColor = .lightBlue00
        $0.font = .h0
    }
    
    private var dateBackView = UIImageView().then {
        $0.image = Constant.Image.bgDate
    }
    
    private var dateLabel = UILabel().then {
        $0.text = "02"
        $0.textColor = .lightBlue00
        $0.font = .h0
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
        $0.font = .p2
        $0.textColor = .glassBlue
        $0.numberOfLines = 2
        $0.addLineSpacing(spacing: 23)
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
    
    private let imagePicker = UIImagePickerController()
    
    private var playerAnimationView = AnimationView().then {
        $0.isHidden = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        getNotification()
        setAnimationView()
        setDelegate()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        view.backgroundColor = .white
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
        print("돌아가기 버튼 누름")
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
                $0.top.equalTo(self.yearBackView.snp.bottom).offset(self.getDeviceHeight() == 812 ? 52 : 19)
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
    
    private func setAnimationView() {
        view.addSubview(playerAnimationView)
        
        playerAnimationView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        playerAnimationView.play()
    }
    
    private func setDelegate() {
        timeTravelView.delegate = self
    }
}

// MARK: - Custom Delegate

extension TimeTravelViewController: TimeTravelViewDelegate {
    func photoImageViewDidTap() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(self.imagePicker, animated: true)
    }
}

// MARK: - UIImagePicker Delegate

extension TimeTravelViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 이미지 사진 업로드
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        
        timeTravelView.photoImageView.image = newImage
        
        // 이미지 날짜 업로드
        let asset = info[.phAsset] as? PHAsset
        
        let option = PHContentEditingInputRequestOptions()
        option.canHandleAdjustmentData = { _ in true }
        
        asset?.requestContentEditingInput(with: option, completionHandler: { (contentEditingInput, info) in
            if let date = contentEditingInput?.creationDate {
                self.timeTravelView.dateTextField.text = self.dateFormatter.string(from: date)
                self.timeTravelView.hasPhoto = true
            }
        })
        
        picker.dismiss(animated: true, completion: nil)
    }
}
