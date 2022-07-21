//
//  LetterOnboardingViewController.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/14.
//

import UIKit

final class LetterOnboardingViewController: UIViewController {
    
    // MARK: - Property
    
    var letterNumber: Int?
    var nextButtonNumber: Int = 0
    
    // MARK: - UI Property
    
    @IBOutlet var letterGreetingCollection: [UILabel]!
    @IBOutlet var letterLabelCollection: [UILabel]!
    @IBOutlet var letterLabelLineSpacingCollection: [UILabel]!
    @IBOutlet var onboardingButtonCollection: [UIButton]!
    @IBOutlet weak var letterTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var dearLabelTopConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelUI()
        setLayout()
        setAnimation()
    }
    
    // MARK: - Custom Method
    
    private func setLabelUI() {
        letterLabelCollection.forEach {
            $0.font = .p4
            $0.textColor = .darkGray01
        }
        letterLabelLineSpacingCollection.forEach {
            $0.font = .p4
            $0.textColor = .darkGray01
            $0.addLineSpacing(spacing: 28)
            $0.textAlignment = .left
        }
        onboardingButtonCollection.forEach {
            $0.titleLabel?.font = .btn0
            $0.setTitleColor(.blue02, for: .normal)
        }
        letterGreetingCollection.forEach {
            $0.font = .p5En
            $0.textColor = .blue02
        }
    }
    
    private func setLayout() {
        letterTopConstraint.constant = (getDeviceHeight() == 667) ? 100 : 160
        dearLabelTopConstraint.constant = (getDeviceHeight() == 667) ? -58 : -64
    }
    
    private func setAnimation() {
        if letterNumber == 1 {
            setFirstInitAnimation()
        } else if letterNumber == 2 {
            setSecondInitAnimation()
        } else if letterNumber == 4 {
            setFourthInitAnimation()
        }
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
    
    private func setThirdInitAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setThirdComponentsAnimation()
        }
    }
    
    private func setFourthInitAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setFourthComponentsAnimation()
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func checkPlayerButtonDidTap(_ sender: UIButton) {
        guard let playTapeOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.PlayTapeOnboarding) as? PlayTapeOnboardingViewController else { return }
        playTapeOnboarding.modalTransitionStyle = .crossDissolve
        playTapeOnboarding.modalPresentationStyle = .fullScreen
        present(playTapeOnboarding, animated: true)
    }
    
    @IBAction func nextButtonDidTap(_ sender: UIButton) {
        nextButtonNumber += 1
        
        if nextButtonNumber == 1 {
            letterLabelCollection[1].alpha = 0
            letterLabelLineSpacingCollection[4].alpha = 0
            onboardingButtonCollection[1].alpha = 0
            setThirdInitAnimation()
        } else {
            guard let playTapeOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.PlayTapeOnboarding) as? PlayTapeOnboardingViewController else { return }
            playTapeOnboarding.modalTransitionStyle = .crossDissolve
            playTapeOnboarding.modalPresentationStyle = .fullScreen
            playTapeOnboarding.playTapeNumber = 1
            present(playTapeOnboarding, animated: true)
        }
    }
    
    @IBAction func startLoginButtonDidTap(_ sender: UIButton) {
//        let initialViewController = InitialViewController()
//        initialViewController.modalTransitionStyle = .crossDissolve
//        initialViewController.modalPresentationStyle = .fullScreen
//        present(initialViewController, animated: true)
        guard let main = UIStoryboard(name: Constant.Storyboard.Main, bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController") as? UINavigationController else { return }
        changeRootViewController(main)
    }

}

// MARK: - Animation function

extension LetterOnboardingViewController {
    
    private func setFirstComponentsAnimation() {
        UIView.animate(withDuration: 0.6, animations: {
            self.letterGreetingCollection[0].alpha = 1
            self.letterLabelCollection[0].alpha = 1 }, completion: { _ in
                UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                    self.letterLabelLineSpacingCollection[0].alpha = 1
                }, completion: { _ in
                    UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                        self.letterLabelLineSpacingCollection[1].alpha = 1
                    }, completion: { _ in
                        UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                            self.letterLabelLineSpacingCollection[2].alpha = 1
                        }, completion: { _ in
                            UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                                self.letterLabelLineSpacingCollection[3].alpha = 1
                            }, completion: { _ in
                                UIView.animate(withDuration: 0.3, delay: 1.2, animations: {
                                    self.onboardingButtonCollection[0].alpha = 1
                                }, completion: nil )
                            } )
                        })
                    })
                })
            })
    }
    
    private func setSecondComponentsAnimation() {
        UIView.animate(withDuration: 0.6, animations: {
            self.letterLabelCollection[1].alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                self.letterLabelLineSpacingCollection[4].alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 1.2, animations: {
                    self.onboardingButtonCollection[1].alpha = 1
                }, completion: nil)
            } )
        })
    }
    
    private func setThirdComponentsAnimation() {
        UIView.animate(withDuration: 0.6, animations: {
            self.letterLabelLineSpacingCollection[5].alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                self.letterLabelLineSpacingCollection[6].alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                    self.letterLabelCollection[2].alpha = 1
                }, completion: { _ in
                    UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                        self.letterLabelCollection[3].alpha = 1
                    }, completion: { _ in
                        UIView.animate(withDuration: 0.3, delay: 1.2, animations: {
                            self.onboardingButtonCollection[1].alpha = 1
                        }, completion: nil)
                    })
                })
            })
        })
    }
    
    private func setFourthComponentsAnimation() {
        UIView.animate(withDuration: 0.6, animations: {
            self.letterLabelLineSpacingCollection[7].alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                self.letterLabelLineSpacingCollection[8].alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                    self.letterLabelLineSpacingCollection[9].alpha = 1
                }, completion: { _ in
                    UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                        self.letterLabelCollection[4].alpha = 1
                        self.letterGreetingCollection[1].alpha = 1
                    }, completion: { _ in
                        UIView.animate(withDuration: 0.3, delay: 1.2, animations: {
                            self.onboardingButtonCollection[2].alpha = 1
                        }, completion: nil )
                    })
                })
            })
        })
    }
}
