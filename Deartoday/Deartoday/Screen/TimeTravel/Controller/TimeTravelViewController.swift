//
//  TimeTravelViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/08.
//

import UIKit

import SnapKit
import Then

final class TimeTravelViewController: UIViewController {
    
    // MARK: - Property
    
    private var todayDate = Date()
    
    private var momentDate = Date()
    
    // MARK: - UI Property
    
    private var backImageView = UIImageView().then {
        $0.backgroundColor = .systemPink
        $0.isHidden = true
    }
    
    private var coverView = UIView().then {
        $0.backgroundColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 0.8)
        $0.isHidden = true
    }
    
    private var dateTextField = DDSTextField().then {
        $0.placeholder = "이 순간의 날짜를 선택해주세요"
    }
    
    private var titleTextField = DDSTextField().then {
        $0.placeholder = "이 순간의 제목을 붙여주세요"
    }
    
    private lazy var returnButton = DDSButton().then {
        $0.style = .disable
        $0.text = "과거로 돌아가기"
        $0.hasLeftIcon = true
        $0.addTarget(self, action: #selector(returnButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setTextField()
    }
    
    // MARK: - @objc
    
    @objc func returnButtonDidTap() {
        print("돌아가기 버튼 누름")
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews([backImageView,
                          coverView,
                          dateTextField,
                          titleTextField,
                          returnButton])
        
        backImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        coverView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        dateTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(386)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(dateTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        returnButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(6)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
    }
    
    private func setTextField() {
        [dateTextField, titleTextField].forEach {
            $0.delegate = self
        }
    }
}

// MARK: - UITextField Delegate

extension TimeTravelViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
