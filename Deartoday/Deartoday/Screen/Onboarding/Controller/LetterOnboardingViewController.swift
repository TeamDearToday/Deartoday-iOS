//
//  LetterOnboardingViewController.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/14.
//

import UIKit

final class LetterOnboardingViewController: UIViewController {
    
    // MARK: - UI Property
    
    @IBOutlet weak var dearLabel: UILabel!
    @IBOutlet weak var checkPlayerButton: UIButton!
    @IBOutlet var letterLabelCollection: [UILabel]!
    @IBOutlet weak var letterTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var dearLabelTopConstraint: NSLayoutConstraint!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelUI()
        setLayout()
    }
    
    // MARK: - Custom Method
    
    private func setLabelUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setComponentsAnimation()
        }
        dearLabel.font = .p5En
        dearLabel.textColor = .blue02
        
        letterLabelCollection.forEach {
            $0.font = .p4
            $0.textColor = .darkGray01
        }
    }
    
    private func setLayout() {
        letterTopConstraint.constant = (getDeviceHeight() == 667) ? 100 : 160
        dearLabelTopConstraint.constant = (getDeviceHeight() == 667) ? -58 : -64
    }
    
    private func setComponentsAnimation() {
        UIView.animate(withDuration: 0.6, animations: {
            self.dearLabel.alpha = 1
            self.letterLabelCollection[0].alpha = 1 }, completion: { _ in
                UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                    self.letterLabelCollection[1].alpha = 1
                }, completion: { _ in
                    UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                        self.letterLabelCollection[2].alpha = 1
                    }, completion: { _ in
                        UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                            self.letterLabelCollection[3].alpha = 1
                        }, completion: { _ in
                            UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                                self.letterLabelCollection[4].alpha = 1
                            }, completion: { _ in
                                UIView.animate(withDuration: 0.3, delay: 1.2, animations: {
                                    self.checkPlayerButton.alpha = 1
                                }, completion: nil )
                            } )
                        })
                    })
                })
            })
    }
}
