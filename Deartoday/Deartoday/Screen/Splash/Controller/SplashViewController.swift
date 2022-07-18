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
        view.addSubview(soundOnImageView)
        
        soundOnImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(6)
            (getDeviceHeight() == 667) ? $0.bottom.equalToSuperview().inset(70) : $0.bottom.equalToSuperview().inset(90)
        }
        
    }
    
    private func setAnimation() {
        UIView.animate(withDuration: 0.4, delay: 1.8, animations: {
            self.soundOnImageView.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 2.2, animations: {
                self.soundOnImageView.alpha = 0
            }, completion: { _ in
                guard let onboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.Onboarding) as? OnboardingViewController else { return }
                onboarding.modalTransitionStyle = .crossDissolve
                onboarding.modalPresentationStyle = .fullScreen
                self.present(onboarding, animated: true)
            })
        })
    }
}
