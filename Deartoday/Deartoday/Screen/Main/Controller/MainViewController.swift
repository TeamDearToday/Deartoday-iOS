//
//  ViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Property
    
    // MARK: - UI Property

    @IBOutlet var dateLabelCollection: [UILabel]!
    
    @IBOutlet weak var timeTravelButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet var backgroundImageViewWidthConstraintCollection: [NSLayoutConstraint]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    // MARK: - @objc
    
    // MARK: - Custom Method
    
    private func setUI() {
        setConstraint()
        setDateLabel()
        setLayout()
    }
    
    private func setConstraint() {
        backgroundImageViewWidthConstraintCollection.forEach {
            $0.constant = getDeviceWidth()
        }
    }
    
    private func setDateLabel() {
        for i in 0...2 {
            dateLabelCollection[i].font = .h0
            dateLabelCollection[i].textColor = .lightBlue00
            dateLabelCollection[i].text = getDateInfo()[i]
        }
    }
    
    private func setLayout() {
        timeTravelButtonHeightConstraint.constant = getDeviceWidth() * (246 / 375)
    }
    
    // MARK: - IBAction
    
    @IBAction func timeTravelButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func checkMessageButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func checkTimeTravelButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func settingButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func helpButtonDidTap(_ sender: Any) {
    }
}

