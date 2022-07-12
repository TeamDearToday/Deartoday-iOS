//
//  DeartodayAlertViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/12.
//

import UIKit

import SnapKit
import Then

@frozen
enum AlertType {
    case exit
    case logout
}

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
        $0.text = ""
        $0.textColor = .darkGray00
        $0.font = .p5
        $0.sizeToFit()
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "그만둔 시간 여행은 저장되지 않아요"
        $0.textColor = .gray00
        $0.font = .caption0
        $0.sizeToFit()
        $0.isHidden = true
    }
    
    private let horizontalView = UIView().then {
        $0.backgroundColor = .glassGray
    }
    
    private let verticalView = UIView().then {
        $0.backgroundColor = .glassGray
    }
    
    private let denyButton = UIButton().then {
        $0.backgroundColor = .brown
        $0.setTitleColor(.darkGray00, for: .normal)
        $0.titleLabel?.font = .btn0
        $0.addTarget(self, action: #selector(denyButtonDidTap), for: .touchUpInside)
    }
    
    private let okButton = UIButton().then {
        $0.backgroundColor = .green
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
    

}
