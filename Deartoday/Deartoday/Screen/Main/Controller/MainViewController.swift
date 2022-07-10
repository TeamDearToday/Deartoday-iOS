//
//  ViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - UI Property

    @IBOutlet var messageCountLabelCollection: [UILabel]!
    @IBOutlet var dateLabelCollection: [UILabel]!
    @IBOutlet weak var timeTravelButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet var backgroundImageViewWidthConstraintCollection: [NSLayoutConstraint]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setData()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setConstraint()
        setLabelUI()
        setLayout()
    }
    
    private func setData() {
        setDateLabel()
    }
    
    private func setConstraint() {
        backgroundImageViewWidthConstraintCollection.forEach {
            $0.constant = getDeviceWidth()
        }
    }
    
    private func setLabelUI() {
        messageCountLabelCollection.forEach {
            $0.textColor = .blue02
            $0.font = .p3
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

