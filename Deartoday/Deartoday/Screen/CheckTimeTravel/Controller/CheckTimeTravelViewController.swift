//
//  CheckTimeTravelViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/13.
//

import UIKit

final class CheckTimeTravelViewController: UIViewController {

    // MARK: - Property
    // MARK: - UI Property
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emptyDescriptionLabel: UILabel!
    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var rewindImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setHeaderViewUI()
        setEmptyViewUI()
    }
}

// MARK: - Component UI Setting functions

extension CheckTimeTravelViewController {
    private func setHeaderViewUI() {
        titleLabel.textColor = .darkGray01
        titleLabel.setPartialLabelColor(targetStringList: ["시간 여행"], color: .blue02)
        titleLabel.font = .h1
        descriptionLabel.textColor = .gray00
        descriptionLabel.font = .caption2
    }
    
    private func setEmptyViewUI() {
        emptyDescriptionLabel.font = .caption2
        emptyDescriptionLabel.textColor = .gray01
        emptyTitleLabel.font = .btn0
        emptyTitleLabel.textColor = .blue02
        rewindImageView.tintColor = .blue02
    }
}
