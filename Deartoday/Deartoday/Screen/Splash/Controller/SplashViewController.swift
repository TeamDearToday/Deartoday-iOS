//
//  SplashViewController.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/18.
//

import UIKit

import Lottie
import SnapKit
import Then

final class SplashViewController: UIViewController {
    
    // MARK: - UI Property
    
    var soundOnImageView = UIImageView().then {
        $0.image = Constant.Image.soundon
        $0.alpha = 0
    }
    
    var soundOntextLabel = UILabel().then {
        $0.text = """
                  소리를 키면 보다 풍부한 몰입감을 느낄 수 있습니다.
                  사운드 설정은 설정 메뉴에서 언제든지 변경할 수 있어요.
                  """
        $0.numberOfLines = 2
        $0.addLineSpacing(spacing: 20)
        $0.font = .p6
        $0.textColor = .darkGray
        $0.textAlignment = .center
        $0.alpha = 0
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSplash()
        setLayout()
        setAnimation()
    }
    
    // MARK: - Custom Method
    
    private func showSplash() {
        let spashScreen = AnimationView(name: Constant.Lottie.splash)
        spashScreen.frame = self.view.bounds
        spashScreen.center = self.view.center
        spashScreen.contentMode = .scaleAspectFill
        self.view.addSubview(spashScreen)
        spashScreen.play()
    }
    
    private func setLayout() {
        view.addSubviews([soundOnImageView,
                          soundOntextLabel])
        
        soundOnImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(6)
            $0.bottom.equalToSuperview().inset(getDeviceHeight() == 667 ? 70 : 90 )
        }
        soundOntextLabel.snp.makeConstraints {
            $0.centerX.equalTo(soundOnImageView)
            $0.top.equalTo(soundOnImageView).inset(18)
        }
    }
    
    private func setAnimation() {
        UIView.animate(withDuration: 0.4, delay: 1.8, animations: {
            self.soundOnImageView.alpha = 1
            self.soundOntextLabel.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 2.2, animations: {
                self.soundOnImageView.alpha = 0
                self.soundOntextLabel.alpha = 0
            }, completion: { _ in
                guard let onboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.Onboarding) as? OnboardingViewController else { return }
                onboarding.modalTransitionStyle = .crossDissolve
                onboarding.modalPresentationStyle = .fullScreen
                self.present(onboarding, animated: true)
            })
        })
    }
}
