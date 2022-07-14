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
        setUI()
        setLayout()
    }
    
    // MARK: - Custom Method
    
    private func setLayout() {
        labelBottomConstraint.constant = (getDeviceHeight() == 667) ? 20 : 44
    }
    
    private func setUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setComponentsAnimation()
        }
        labelCollection.forEach {
            $0.textColor = .white
            $0.font = .p1
            $0.font = .systemFont(ofSize: 13)
            $0.isHidden = false
        }
        letterButton.isHidden = false
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


