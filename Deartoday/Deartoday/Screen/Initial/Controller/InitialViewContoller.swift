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
        $0.setBackgroundImage(Constant.Image.btnApple, for: .normal)
        $0.addTarget(self, action: #selector(appleSignInButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
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
        
        guard let mainViewController = UIStoryboard(name: Constant.Storyboard.Main, bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController else { return }
        mainViewController.modalPresentationStyle = .fullScreen
        mainViewController.modalTransitionStyle = .crossDissolve
        present(mainViewController, animated: true)
    }
    
    // MARK: - Custom Method
    
    private func setLayout() {
        view.addSubviews([backgroundView, logoImageView, appleLoginButton])
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(68)
            $0.top.equalToSuperview().inset(getDeviceHeight() == 667 ? 190 : 258)
        }
        appleLoginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(logoImageView.snp.bottom).offset(10)
        }
    }
}

extension InitialViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    // Apple ID 연동 성공 시
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            guard let identityToken = credential.identityToken else { return }
//            guard let socialToken = String(data: identityToken, encoding: .utf8) else { return }
//            guard let FCMToken = UserDefaults.standard.value(forKey: "Init") as? String else { return }
//
//            LoginAPI.shared.login(social: "APPLE", socialToken: socialToken, FCMToken: FCMToken) { appleLoginData, err in
//                guard let appleloginData = appleLoginData else { return }
//            }
//        }
//    }
    
    // Apple ID 연동 실패
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
