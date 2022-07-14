//
//  CheckMessageViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/12.
//

import UIKit

final class CheckMessageViewController: UIViewController {
    
    // MARK: - UI Property
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyDescriptionLabel: UILabel!
    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var timeTravelImageView: UIImageView!
    @IBOutlet weak var rewindImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setGesture()
    }
    
    // MARK: - @objc
    
    @objc private func timeTravelButtonDidTap() {
        let timeTravel = TimeTravelViewController()
        timeTravel.modalTransitionStyle = .crossDissolve
        timeTravel.modalPresentationStyle = .overFullScreen
        present(timeTravel, animated: true) {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setHeaderViewUI()
        setEmptyViewUI()
    }
    
    private func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(timeTravelButtonDidTap))
        timeTravelImageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Component UI Setting functions

extension CheckMessageViewController {
    private func setHeaderViewUI() {
        titleLabel.font = .h1
        titleLabel.textColor = .darkGray01
        titleLabel.setPartialLabelColor(targetStringList: ["메시지"], color: .blue02)
        descriptionLabel.font = .caption2
        descriptionLabel.textColor = .gray00
    }
    
    private func setEmptyViewUI() {
        emptyDescriptionLabel.font = .caption2
        emptyDescriptionLabel.textColor = .gray01
        emptyTitleLabel.font = .btn0
        emptyTitleLabel.textColor = .blue02
        rewindImageView.tintColor = .blue02
    }
}
