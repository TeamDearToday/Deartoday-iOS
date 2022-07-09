//
//  TimeTravelView.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/08.
//

import UIKit

final class TimeTravelView: UIView {
    
    // MARK: - Property
    
    
    // MARK: - UI Property
    
    private var videoTapeImageView = UIImageView().then {
        $0.backgroundColor = .yellow
    }
    
    private var photoImageView = UIImageView().then {
        $0.backgroundColor = .blue
        $0.makeRound(radius: 8)
    }
    
    private var dateTextField = DDSTextField().then {
        $0.placeholder = "이 순간의 날짜를 선택해주세요"
    }
    
    private var titleTextField = DDSTextField().then {
        $0.placeholder = "이 순간의 제목을 붙여주세요"
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setTextField()
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
}

// MARK: - UITextField Delegate

extension TimeTravelView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

