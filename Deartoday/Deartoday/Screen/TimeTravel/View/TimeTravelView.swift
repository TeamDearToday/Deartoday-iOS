//
//  TimeTravelView.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/08.
//

import UIKit

import SnapKit
import Then

import Photos
import PhotosUI

protocol TimeTravelViewDelegate: TimeTravelViewController {
    func photoImageViewDidTap()
}

final class TimeTravelView: UIView {
    
    // MARK: - Property
    
    public var hasPhoto: Bool = false {
        didSet {
            [dateTextField, titleTextField].forEach {
                $0.isHidden = !hasPhoto
            }
        }
    }
    
    public var photoImage: UIImage? = nil {
        didSet {
            photoImageView.image = photoImage
        }
    }
    
    public var dateText: String? = nil {
        didSet {
            dateTextField.text = dateText
        }
    }
    
    private let dateFormatter = DateFormatter().then {
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(abbreviation: "ko_kr")
        $0.dateFormat = "yyyy.MM.dd"
    }
    
    weak var delegate: TimeTravelViewDelegate?
    
    // MARK: - UI Property
    
    private var videoTapeImageView = UIImageView().then {
        $0.image = Constant.Image.imgTape
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFill
    }
    
    private var photoImageView = UIImageView().then {
        $0.backgroundColor = .lightBlue00
        $0.makeRound(radius: 8)
        $0.isUserInteractionEnabled = true
    }
    
    lazy var dateTextField = DDSTextField().then {
        $0.placeholder = "이 순간의 날짜를 선택해주세요"
        $0.inputView = datePickerView
    }
    
    var titleTextField = DDSTextField().then {
        $0.placeholder = "이 순간의 제목을 붙여주세요"
    }
    
    private var datePickerView = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko")
        
        let date = Date()
        $0.maximumDate = date
        
        let minimumDate = Calendar.current.date(byAdding: .year, value: -22, to: date)
        $0.minimumDate = minimumDate
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setTextField()
        setPhotoImageView()
        setToolbar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        backgroundColor = .clear
    }
    
    private func setLayout() {
        addSubviews([videoTapeImageView,
                     dateTextField,
                     titleTextField])
        
        videoTapeImageView.addSubview(photoImageView)
        
        videoTapeImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(197)
        }
        
        photoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(66)
            $0.leading.equalToSuperview().inset(100)
            $0.trailing.equalToSuperview().inset(106)
            $0.bottom.equalToSuperview().inset(54)
        }
        
        dateTextField.snp.makeConstraints {
            $0.top.equalTo(videoTapeImageView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(dateTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setTextField() {
        [dateTextField, titleTextField].forEach {
            $0.delegate = self
        }
    }
    
    private func setPhotoImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoImageViewDidTap(_:)))
        videoTapeImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.tintColor = .blue
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelbutton = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(cancelButtonDidTap))
        let donebutton = UIBarButtonItem(title: "선택", style: .done, target: self, action: #selector(doneButtonDidTap))
        
        toolBar.setItems([flexibleSpace, cancelbutton, donebutton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        dateTextField.inputAccessoryView = toolBar
    }

    // MARK: - @objc
    
    @objc private func photoImageViewDidTap(_ sender: UITapGestureRecognizer) {
        delegate?.photoImageViewDidTap()
    }
    
    @objc func cancelButtonDidTap() {
        endEditing(true)
    }
    
    @objc func doneButtonDidTap() {
        dateTextField.text = dateFormatter.string(from: datePickerView.date)
        endEditing(true)
    }
}

// MARK: - UITextField Delegate

extension TimeTravelView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if dateTextField.hasText && titleTextField.hasText {
            
            // MARK: - FIX: Notification 말고 다른 방법 없을까?
            
            NotificationCenter.default.post(name: NSNotification.Name("EnableReturnButton"), object: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
