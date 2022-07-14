//
//  PlayTapeOnboardingViewController.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/15.
//

import UIKit

final class PlayTapeOnboardingViewController: UIViewController {
    
    // MARK: - UI Property
    
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var circleButton: UIImageView!
    @IBOutlet weak var tapeButton: UIButton!
    @IBOutlet var circleCollection: [UIView]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponentsUI()
    }
    
    // MARK: - Custom Method
    
    private func setComponentsUI() {
        circleCollection.forEach {
            $0.layer.cornerRadius = $0.frame.width / 2
        }
        explanationLabel.font = .onboard0
        explanationLabel.textColor = .white
    }
    
    // MARK: IBAction
    
    @IBAction func tapeButtonDidTap(_ sender: UIButton) {
        guard let LetterOnboarding = UIStoryboard(name: Constant.Storyboard.Onboarding, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.LetterOnboarding) as?
    }
}
