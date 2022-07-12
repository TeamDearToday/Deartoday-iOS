//
//  OnboardingViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit
import Then
import SnapKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Property
    
    // MARK: - UI Property
    @IBOutlet var firstLabelCollection: [UILabel]!
    @IBOutlet weak var secondLabel: UILabel!
    
    private var nextButton = DDSButton().then {
        $0.style = .present
        $0.text = "다음"
        $0.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setFirstLabelUI()
        setFirstAlpha()
        setFirstAnimation()
    }
    
    // MARK: - @objc
    
    @objc func nextButtonDidTap() {
        setFirstAlpha()
    }
    
    // MARK: - Custom Method
    
    private func setFirstLabelUI() {
        firstLabelCollection.forEach {
            $0.textColor = .white
            $0.font = .p1
            $0.font = .systemFont(ofSize: 13)
            $0.textAlignment = .center
        }
    }
    
    private func setLayout() {
        view.addSubviews([nextButton])
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(firstLabelCollection[1].snp.bottom).offset(79)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-46)
        
        }
    }
    
    private func setFirstAlpha() {
        firstLabelCollection.forEach {
            $0.alpha = 0
        }
        nextButton.alpha = 0
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
}
