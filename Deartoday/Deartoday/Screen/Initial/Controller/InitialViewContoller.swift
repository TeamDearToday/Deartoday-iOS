//
//  InitialViewContoller.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/18.
//

import AuthenticationServices
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
        $0.backgroundColor = .black
        $0.makeRound(radius: 4)
        $0.addTarget(self, action: #selector(appleSignInButtonDidTap), for: .touchUpInside)
    }
    
    var appleLogo = UIImageView().then {
        $0.image = UIImage(systemName: "applelogo")
        $0.contentMode = .scaleAspectFill
        $0.tintColor = .white
    }
    
    var appleLoginLabel = UILabel().then {
        $0.text = "Apple로 계속하기"
        $0.textColor = .white
        $0.font = .p8
        $0.sizeToFit()
    }
    
    var appleLoginView = UIView().then {
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    
    var appleLoginStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        addAppleLoginViewGesture()
    }
    
    // MARK: - @objc
    
    @objc func appleSignInButtonDidTap() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // MARK: - Custom Method
    
    private func presentMainView() {
        guard let mainViewController = UIStoryboard(name: Constant.Storyboard.Main, bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController else { return }
        mainViewController.modalPresentationStyle = .fullScreen
        mainViewController.modalTransitionStyle = .crossDissolve
        present(mainViewController, animated: true)
    }
    
    private func addAppleLoginViewGesture() {
        let addAppleLoginViewGesture = UITapGestureRecognizer(target: self, action: #selector(appleSignInButtonDidTap))
        appleLoginView.addGestureRecognizer(addAppleLoginViewGesture)
    }
    
    private func setLayout() {
        view.addSubviews([backgroundView,
                          logoImageView,
                          appleLoginButton,
                          appleLoginStackView,
                          appleLoginView])
        appleLoginStackView.addArrangedSubview(appleLogo)
        appleLoginStackView.addArrangedSubview(appleLoginLabel)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.9)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(logoImageView.snp.bottom).offset(10)
            $0.height.equalTo(48)
        }
        
        appleLogo.snp.makeConstraints {
            $0.height.equalTo(24)
        }
        
        appleLoginStackView.snp.makeConstraints {
            $0.centerY.centerX.equalTo(appleLoginButton)
        }
        
        appleLoginView.snp.makeConstraints {
            $0.edges.equalTo(appleLoginStackView)
        }
    }
}

extension InitialViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let identityToken = credential.identityToken else { return }
            guard let socialToken = String(data: identityToken, encoding: .utf8) else { return }
            guard let fcmToken = UserDefaults.standard.value(forKey: "Init") as? String else { return }

            LoginAPI.shared.login(param: LoginRequest(social: "APPLE", socialToken: socialToken, fcmToken: fcmToken)) { appleLoginData, err in
                guard let appleloginData = appleLoginData else { return }
                guard let accessToken = appleLoginData?.data?.accessToken else { return }
                print("accessToken:\(accessToken)")
//                UserDefaults.standard.set("\(accessToken)", forKey: "hasToken")
                self.presentMainView()
            }
        }
    }
    
    // Apple ID 연동 실패
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
