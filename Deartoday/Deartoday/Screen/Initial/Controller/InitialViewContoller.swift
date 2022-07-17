//
//  InitialViewContoller.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/18.
//

import UIKit

import SnapKit
import Then

final class InitialViewController: UIViewController {
    // MARK: - Property
    
    // MARK: - UI Property
    
    var backgroundView = UIView().then {
        $0.backgroundColor = .lightBlue00
    }
    
    var logoImageView = UIImageView().then {
        $0.image = Constant.Image.logo
    }
    
    var appleLoginButton = UIButton().then {
        $0.setBackgroundImage(Constant.Image.btnApple, for: .normal)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    // MARK: - @objc
    
    // MARK: - Custom Method
    
    private func setLayout() {
        view.addSubviews([backgroundView, logoImageView, appleLoginButton])
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        if getDeviceHeight() == 667 {
            logoImageView.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(68)
                $0.top.equalToSuperview().inset(190)
            }
        } else {
            logoImageView.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(68)
                $0.top.equalToSuperview().inset(258)
            }
        }
        appleLoginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(logoImageView.snp.bottom).inset(10)
        }
    }
}
