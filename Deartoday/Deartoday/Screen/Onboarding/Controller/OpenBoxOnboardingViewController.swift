//
//  OpenBoxOnboardingViewController.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/13.
//

import UIKit

final class OpenBoxOnboardingViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var letterButton: UIButton!
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet weak var labelBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setInitAnimation()
        setComponentsUI()
        setLayout()
    }
    
    // MARK: - Custom Method
    
    private func setLayout() {
        labelBottomConstraint.constant = (getDeviceHeight() == 667) ? 20 : 44
    }
    
    private func setComponentsUI() {
        labelCollection.forEach {
            $0.textColor = .white
            $0.font = .onboard0
        }
        letterButton.titleLabel?.font = .btn0
        letterButton.setTitleColor(.blue02, for: .normal)
    }
    
    private func setInitAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setComponentsAnimation()
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func letterButtonDidTap(_ sender: UIButton) {
        labelCollection.forEach {
            $0.isHidden = true
        }
        letterButton.isHidden = true
        
        guard let letterOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.LetterOnboarding) as? LetterOnboardingViewController else { return }
        letterOnboarding.modalPresentationStyle = .overFullScreen
        letterOnboarding.modalTransitionStyle = .crossDissolve
        present(letterOnboarding, animated: true)
    }
    
    // MARK: - Animation function
    
    private func setComponentsAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.labelCollection[0].transform = CGAffineTransform(translationX: 0, y: -16)
            self.labelCollection[0].alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                self.labelCollection[1].transform = CGAffineTransform(translationX: 0, y: -16)
                self.labelCollection[1].alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                    self.labelCollection[2].transform = CGAffineTransform(translationX: 0, y: -16)
                    self.labelCollection[2].alpha = 1
                }, completion: { _ in
                    UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
                        self.letterButton.alpha = 1
                    }, completion: nil )
                })
            })
        })
    }
}


