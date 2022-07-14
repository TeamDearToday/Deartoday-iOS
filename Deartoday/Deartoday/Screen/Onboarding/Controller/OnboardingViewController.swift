//
//  OnboardingViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

import SnapKit
import Then

final class OnboardingViewController: UIViewController {
    
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
        setUI()
        setFirstAnimation()
        addCircleImageGesture()
    }
    
    // MARK: - @objc
    
    @objc func circleButtonDidTap() {
        guard let openBoxOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.OpenBoxOnboarding) as? OpenBoxOnboardingViewController else { return }
        
        openBoxOnboarding.modalPresentationStyle = .fullScreen
        openBoxOnboarding.modalTransitionStyle = .crossDissolve
        self.present(openBoxOnboarding, animated: true)
    }
    
    // MARK: - Custom Method
    
    private func addCircleImageGesture() {
        let addCircleImageGesture = UITapGestureRecognizer(target: self, action: #selector(circleButtonDidTap))
        circleImageView.addGestureRecognizer(addCircleImageGesture)
    }
    
    private func setUI() {
        labelCollection.forEach {
            $0.textColor = .white
            $0.font = .onboard0
        }
        
        circleCollection.forEach {
            $0.layer.cornerRadius = $0.frame.width / 2
        }
    }
    
    private func hideComponents() {
            labelCollection.forEach {
                $0.isHidden = true
            }
            nextButton.isHidden = true
    }
    
    private func showComponents() {
        labelCollection[2].isHidden = false
        circleImageView.isHidden = false
        boxButton.isEnabled = true
        
        circleCollection.forEach {
            $0.isHidden = false
        }
    }
    
    private func setFirstAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
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
        guard let openBoxOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.OpenBoxOnboarding) as? OpenBoxOnboardingViewController else { return }
        openBoxOnboarding.modalTransitionStyle = .crossDissolve
        openBoxOnboarding.modalPresentationStyle = .fullScreen
        present(openBoxOnboarding, animated: true)
    }
}
