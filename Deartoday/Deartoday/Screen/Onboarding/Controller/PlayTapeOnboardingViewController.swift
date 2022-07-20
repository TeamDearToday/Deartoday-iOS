//
//  PlayTapeOnboardingViewController.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/15.
//

import AVFoundation
import UIKit

import Lottie
import Then
import SnapKit

final class PlayTapeOnboardingViewController: UIViewController {
    
    // MARK: - Property
    
    var playTapeNumber: Int?
    var playerSound = AVAudioPlayer()
    
    // MARK: - UI Property
    
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var tapeButton: UIButton!
    @IBOutlet var circleCollection: [UIView]!
    @IBOutlet weak var circleButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var circleButtonLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponentsUI()
        setPlayerButtonUI()
        addCircleImageGesture()
        setLayout()
    }
    
    // MARK: - objc
    
    var startPlayerButton = DDSButton().then {
        $0.text = "플레이어 작동하기"
        $0.hasLeftIcon = true
        $0.style = .present
        $0.alpha = 0
        $0.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
    }
    
    @objc func startButtonDidTap() {
        startPlayerButton.alpha = 0
        
        let tapeLottieView = AnimationView(name: Constant.Lottie.tape)
        tapeLottieView.frame = self.view.bounds
        tapeLottieView.center = self.view.center
        tapeLottieView.contentMode = .scaleAspectFill
        self.view.addSubview(tapeLottieView)
        tapeLottieView.play()
        
        let url = Bundle.main.url(forResource: Constant.Sound.sound_player, withExtension: ".mp3")
        if let url = url {
            do {
                playerSound = try AVAudioPlayer(contentsOf: url)
                playerSound.prepareToPlay()
                playerSound.play()
            } catch {
                print("error")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
        guard let letterOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.LetterOnboarding) as? LetterOnboardingViewController else { return }
        letterOnboarding.modalTransitionStyle = .crossDissolve
        letterOnboarding.modalPresentationStyle = .overFullScreen
        letterOnboarding.letterNumber = 4
            self.present(letterOnboarding, animated: true)
        }
    }
    
    @objc func circleButtonDidTap() {
        hideComponentsUI()
        
        guard let letterOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.LetterOnboarding) as? LetterOnboardingViewController else { return }
        letterOnboarding.modalTransitionStyle = .crossDissolve
        letterOnboarding.modalPresentationStyle = .overFullScreen
        letterOnboarding.letterNumber = 2
        present(letterOnboarding, animated: true)
    }
    
    // MARK: - Custom Method
    
    private func setComponentsUI() {
        circleCollection.forEach {
            $0.layer.cornerRadius = $0.frame.width / 2
        }
        explanationLabel.font = .onboard0
        explanationLabel.textColor = .white
    }
    
    private func showComponentsUI() {
        startPlayerButton.alpha = 1
    }
    
    private func hideComponentsUI() {
        circleCollection.forEach {
            $0.isHidden = true
        }
        tapeButton.isHidden = true
        explanationLabel.isHidden = true
        circleImageView.isHidden = true
    }
    
    private func setPlayerButtonUI() {
        if playTapeNumber == 1 {
            hideComponentsUI()
            showComponentsUI()
        }
    }
    
    private func addCircleImageGesture() {
        let addCircleImageGesture = UITapGestureRecognizer(target: self, action: #selector(circleButtonDidTap))
        circleImageView.addGestureRecognizer(addCircleImageGesture)
    }
    
    private func setLayout() {
        view.addSubview(startPlayerButton)
        
        startPlayerButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(6)
            $0.bottom.equalToSuperview().inset(36)
        }
        circleButtonTopConstraint.constant = ((getDeviceHeight() == 667) ? 140 : (getDeviceHeight() == 844) ? 195 : 185)
        circleButtonLeadingConstraint.constant = (getDeviceHeight() == 884) ? 168 : 158
    }
    
    // MARK: IBAction
    
    @IBAction func tapeButtonDidTap(_ sender: UIButton) {
        hideComponentsUI()
        
        guard let letterOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.LetterOnboarding) as? LetterOnboardingViewController else { return }
        letterOnboarding.modalTransitionStyle = .crossDissolve
        letterOnboarding.modalPresentationStyle = .overFullScreen
        letterOnboarding.letterNumber = 2
        present(letterOnboarding, animated: true)
    }
}
