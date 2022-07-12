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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - @objc
    
    
    // MARK: - Custom Method
    
    private func setUI() {
        setLabelUI()
    }
    
    private func setLabelUI() {
        titleLabel.font = .h1
        titleLabel.textColor = .darkGray01
        titleLabel.setPartialLabelColor(targetStringList: ["메시지"], color: .blue02)
        descriptionLabel.font = .caption2
        descriptionLabel.textColor = .gray00
    }
    
    // MARK: - IBAction
}
