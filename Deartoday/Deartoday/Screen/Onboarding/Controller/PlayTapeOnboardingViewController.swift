//
//  PlayTapeOnboardingViewController.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/15.
//

import UIKit

final class PlayTapeOnboardingViewController: UIViewController {
    
    // MARK: - Property
    
    var playTapeNumber: Int?
    
    // MARK: - UI Property
    
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var circleButton: UIImageView!
    @IBOutlet weak var tapeButton: UIButton!
    @IBOutlet weak var startPlayerButton: UIButton!
    @IBOutlet var circleCollection: [UIView]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponentsUI()
        setPlayerButtonUI()
    }
    
    // MARK: - Custom Method
    
    private func setComponentsUI() {
        circleCollection.forEach {
            $0.layer.cornerRadius = $0.frame.width / 2
        }
        explanationLabel.font = .onboard0
        explanationLabel.textColor = .white
        startPlayerButton.titleLabel?.font = .btn0
        startPlayerButton.setTitleColor(.blue02, for: .normal)
    }
    
    private func showComponentsUI() {
        startPlayerButton.alpha = 1
    }
    
    private func hideComponentsUI() {
        circleCollection.forEach {
            $0.isHidden = true
        }
        explanationLabel.isHidden = true
        circleButton.isHidden = true
    }
    
    private func setPlayerButtonUI() {
        if playTapeNumber == 1 {
            hideComponentsUI()
            showComponentsUI()
        }
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
    
    @IBAction func playLottieButtonDidTap(_ sender: UIButton) {
        print("로티 재생 후")
        
        guard let letterOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.LetterOnboarding) as? LetterOnboardingViewController else { return }
        letterOnboarding.modalTransitionStyle = .crossDissolve
        letterOnboarding.modalPresentationStyle = .overFullScreen
        letterOnboarding.letterNumber = 4
        present(letterOnboarding, animated: true)
    }
}
