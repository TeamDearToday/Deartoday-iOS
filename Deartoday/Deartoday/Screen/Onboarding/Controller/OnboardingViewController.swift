//
//  OnboardingViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import AVFoundation
import UIKit

import Lottie

final class OnboardingViewController: UIViewController {
    
    // MARK: Property
    
    var boxSound = AVAudioPlayer()
    
    // MARK: - UI Property
    
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var boxButton: UIButton!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var labelBottomConstraint: NSLayoutConstraint!
    @IBOutlet var circleCollection: [UIView]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setComponentsUI()
        setFirstAnimation()
        addCircleImageGesture()
    }
    
    // MARK: - @objc
    
    @objc func circleButtonDidTap() {
        let boxLottieView = AnimationView(name: Constant.Lottie.box)
        boxLottieView.frame = self.view.bounds
        boxLottieView.center = self.view.center
        boxLottieView.contentMode = .scaleAspectFill
        self.view.addSubview(boxLottieView)
        boxLottieView.play()
        
        let url = Bundle.main.url(forResource: Constant.Sound.sound_box, withExtension: "mp3")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            if let url = url {
                do {
                    self.boxSound = try AVAudioPlayer(contentsOf: url)
                    self.boxSound.prepareToPlay()
                    self.boxSound.play()
                } catch {
                    print("error")
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            guard let openBoxOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.OpenBoxOnboarding) as? OpenBoxOnboardingViewController else { return }
            openBoxOnboarding.modalTransitionStyle = .crossDissolve
            openBoxOnboarding.modalPresentationStyle = .fullScreen
            self.present(openBoxOnboarding, animated: true)
        }
    }
    
    // MARK: - Custom Method
    
    private func addCircleImageGesture() {
        let addCircleImageGesture = UITapGestureRecognizer(target: self, action: #selector(circleButtonDidTap))
        circleImageView.addGestureRecognizer(addCircleImageGesture)
    }
    
    private func setComponentsUI() {
        labelCollection.forEach {
            $0.textColor = .white
            $0.font = .onboard0
        }
        
        circleCollection.forEach {
            $0.layer.cornerRadius = $0.frame.width / 2
        }
        nextButton.titleLabel?.font = .btn0
        nextButton.setTitleColor(.blue02, for: .normal)
    }
    
    private func hideComponents() {
            labelCollection.forEach {
                $0.isHidden = true
            }
            nextButton.isHidden = true
    }
    
    private func showComponents() {
        circleCollection.forEach {
            $0.isHidden = false
        }
        labelCollection[2].isHidden = false
        circleImageView.isHidden = false
        boxButton.isEnabled = true
    }
    
    private func setFirstAnimation() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            UIView.animate(withDuration: 0.5, animations: {
                self.labelCollection[0].transform = CGAffineTransform(translationX: 0, y: -16)
                self.labelCollection[0].alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                    self.labelCollection[1].transform = CGAffineTransform(translationX: 0, y: -16)
                    self.labelCollection[1].alpha = 1
                }, completion: { _ in
                    UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
                        self.nextButton.alpha = 1
                    }, completion: nil )
                })
            })
        }
    }
    
    private func setSecondAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.labelCollection[2].transform = CGAffineTransform(translationX: 0, y: -16)
            self.labelCollection[2].alpha = 1
        }, completion: nil )
    }
    
    private func setLayout() {
        labelBottomConstraint.constant = (getDeviceHeight() == 667) ? 45 : 69
    }
    
    // MARK: - IBAction
    
    @IBAction func nextButtonDidTap(_ sender: UIButton) {
        hideComponents()
        setSecondAnimation()
        showComponents()
    }
    
    @IBAction func boxButtonDidTap(_ sender: UIButton) {
        let boxLottieView = AnimationView(name: Constant.Lottie.box)
        boxLottieView.frame = self.view.bounds
        boxLottieView.center = self.view.center
        boxLottieView.contentMode = .scaleAspectFit
        self.view.addSubview(boxLottieView)
        boxLottieView.play()
        
        let url = Bundle.main.url(forResource: Constant.Sound.sound_box, withExtension: "mp3")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            if let url = url {
                do {
                    self.boxSound = try AVAudioPlayer(contentsOf: url)
                    self.boxSound.prepareToPlay()
                    self.boxSound.play()
                } catch {
                    print("error")
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            guard let openBoxOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.OpenBoxOnboarding) as? OpenBoxOnboardingViewController else { return }
            openBoxOnboarding.modalTransitionStyle = .crossDissolve
            openBoxOnboarding.modalPresentationStyle = .fullScreen
            self.present(openBoxOnboarding, animated: true)
        }
    }
}
