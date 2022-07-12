//
//  DeartodayAlertViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/12.
//

import UIKit

import SnapKit
import Then

final class DeartodayAlertViewController: UIViewController {
    
    // MARK: - Property

    var alertType: AlertType = .exit
    
    // MARK: - UI Property
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.7)
    }
    
    private let alertView = UIView().then {
        $0.backgroundColor = .lightGray01
        $0.layer.cornerRadius = 16
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "시간 여행을 그만두시겠어요?"
        $0.textColor = .darkGray00
        $0.font = .p5
        $0.sizeToFit()
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "그만둔 시간 여행은 저장되지 않아요"
        $0.textColor = .gray00
        $0.font = .caption0
        $0.sizeToFit()
        $0.isHidden = false
    }
    
    private let horizontalView = UIView().then {
        $0.backgroundColor = .glassGray
    }
    
    private let verticalView = UIView().then {
        $0.backgroundColor = .glassGray
    }
    
    private let denyButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("그만두기", for: .normal)
        $0.setTitleColor(.darkGray00, for: .normal)
        $0.titleLabel?.font = .btn0
        $0.addTarget(self, action: #selector(denyButtonDidTap), for: .touchUpInside)
    }
    
    private let okButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("계속하기", for: .normal)
        $0.setTitleColor(.blue02, for: .normal)
        $0.titleLabel?.font = .btn0
        $0.addTarget(self, action: #selector(okButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - @objc
    
    @objc private func denyButtonDidTap() {
        print("print deny")
    }
    
    @objc private func okButtonDidTap() {
        print("print ok")
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setHierarchy()
        setConstraint()
    }
    
    private func setHierarchy() {
        view.addSubviews([backgroundView, alertView,
                         titleLabel, descriptionLabel,
                         horizontalView, verticalView,
                         denyButton, okButton])
    }
    
    private func setConstraint() {
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.width.equalTo(343)
            $0.height.equalTo(185)
            $0.centerX.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(alertView.snp.top).offset(40)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        horizontalView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(57)
            $0.leading.equalTo(alertView.snp.leading)
            $0.trailing.equalTo(alertView.snp.trailing)
            $0.height.equalTo(1)
        }
        
        verticalView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.top.equalTo(horizontalView.snp.bottom)
            $0.bottom.equalTo(alertView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        denyButton.snp.makeConstraints {
            $0.top.equalTo(horizontalView.snp.bottom)
            $0.leading.equalTo(alertView.snp.leading)
            $0.bottom.equalTo(alertView.snp.bottom)
            $0.trailing.equalTo(verticalView.snp.leading)
            $0.height.equalTo(63)
        }
        
        okButton.snp.makeConstraints {
            $0.top.equalTo(horizontalView.snp.bottom)
            $0.leading.equalTo(verticalView.snp.trailing)
            $0.trailing.equalTo(alertView.snp.trailing)
            $0.bottom.equalTo(alertView.snp.bottom)
        }
    }
}
