//
//  OnboardingViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

import SnapKit
import Then

class OnboardingViewController: UIViewController {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    @IBOutlet var firstLabelCollection: [UILabel]!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var boxButton: UIButton!
    @IBOutlet weak var circleButtonImage: UIImageView!
    @IBOutlet weak var labelBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setFirstLabelUI()
        setSecondLabelUI()
        setFirstAnimation()
        imageGestrue()
    }
    
    // MARK: - @objc
    
    @objc func circleButtonDidTap() {
        print("로티")
    }
    
    // MARK: - Custom Method
    
    @IBAction func nextButtonDidTap(_ sender: UIButton) {
        hideComponents(isFirst: true)
        setSecondAnimation()
        showCircleButton()
        isEnableBoxButton()
    }
    
    @IBAction func boxButtonDidTap(_ sender: UIButton) {
        print("로티")
    }
    
    private func imageGestrue() {
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(circleButtonDidTap))
        circleButtonImage.addGestureRecognizer(imageGesture)
    }
    
    private func setFirstLabelUI() {
        firstLabelCollection.forEach {
            $0.textColor = .white
            $0.font = .p1
            $0.font = .systemFont(ofSize: 13)
            $0.textAlignment = .center
        }
    }
    
    private func setSecondLabelUI() {
        secondLabel.textColor = .white
        secondLabel.font = .p1
        secondLabel.font = .systemFont(ofSize: 13)
        secondLabel.textAlignment = .center
    }
    
    private func hideComponents(isFirst: Bool) {
        if isFirst {
            firstLabelCollection.forEach {
                $0.isHidden = true
            }
            nextButton.isHidden = true
        }
        else {
            secondLabel.isHidden = true
        }
    }
    
    private func setFirstAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
            self.firstLabelCollection[0].transform = CGAffineTransform(translationX: 0, y: -16)
            self.firstLabelCollection[0].alpha = 1
        }, completion: { _ in
                       UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
            self.firstLabelCollection[1].transform = CGAffineTransform(translationX: 0, y: -16)
            self.firstLabelCollection[1].alpha = 1
                       }, completion: { _ in
                           UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
                               self.nextButton.alpha = 1
                           }, completion: { _ in })
                       })
    })
    }
    
    private func setSecondAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.secondLabel.transform = CGAffineTransform(translationX: 0, y: -16)
            self.secondLabel.alpha = 1
        }, completion: { _ in })
    }
    
    private func setLayout() {
        let isSe2 = getDeviceHeight() == 667
        labelBottomConstraint.constant = isSe2 ? 45 : 69
    }
    
    private func showCircleButton() {
        circleButtonImage.isHidden = false
    }
    
    private func isEnableBoxButton() {
        boxButton.isEnabled = true
    }
}
