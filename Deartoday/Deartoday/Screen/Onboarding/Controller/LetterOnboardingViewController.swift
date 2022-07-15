//
//  LetterOnboardingViewController.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/14.
//

import UIKit

final class LetterOnboardingViewController: UIViewController {
    
    // MARK: - Property
    
    var letterValue: Int?
    
    // MARK: - UI Property
    
    @IBOutlet weak var dearLabel: UILabel!
    @IBOutlet var letterLabelCollection: [UILabel]!
    @IBOutlet var nextButtonCollection: [UIButton]!
    @IBOutlet weak var letterTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var dearLabelTopConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelUI()
        setLayout()
        if letterValue == 1 {
            setFirstInitAnimation()
        } else if letterValue == 2 {
            setSecondInitAnimation()
        }
    }
    
    // MARK: - Custom Method
    private func setLabelUI() {
        letterLabelCollection.forEach {
            $0.font = .p4
            $0.textColor = .darkGray01
        }
        nextButtonCollection.forEach {
            $0.titleLabel?.font = .btn0
            $0.setTitleColor(.blue02, for: .normal)
        }
        dearLabel.font = .p5En
        dearLabel.textColor = .blue02
    }
    
    private func setFirstInitAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setFirstComponentsAnimation()
        }
    }
    
    private func setSecondInitAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setSecondComponentsAnimation()
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func checkPlayerButtonDidTap(_ sender: UIButton) {
        guard let playTapeOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.PlayTapeOnboarding) as? PlayTapeOnboardingViewController else { return }
        playTapeOnboarding.modalTransitionStyle = .crossDissolve
        playTapeOnboarding.modalPresentationStyle = .fullScreen
        present(playTapeOnboarding, animated: true)
    }
    
    // MARK: - Animation function
    
    private func setLayout() {
        letterTopConstraint.constant = (getDeviceHeight() == 667) ? 100 : 160
        dearLabelTopConstraint.constant = (getDeviceHeight() == 667) ? -58 : -64
    }
    
    private func setFirstComponentsAnimation() {
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
                                    self.nextButtonCollection[0].alpha = 1
                                }, completion: nil )
                            } )
                        })
                    })
                })
            })
    }
    
    private func setSecondComponentsAnimation() {
        UIView.animate(withDuration: 0.6, animations: {
            self.letterLabelCollection[5].alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                self.letterLabelCollection[6].alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 1.2, animations: {
                    self.nextButtonCollection[1].alpha = 1
                }, completion: nil)
            } )
        })
    }
}
