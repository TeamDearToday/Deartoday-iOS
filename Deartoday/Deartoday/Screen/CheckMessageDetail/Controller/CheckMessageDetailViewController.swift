//
//  CheckMessageDetailViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/13.
//

import UIKit

final class CheckMessageDetailViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var messageViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setMessageViewUI()
        setLabelUI()
        setMessageViewDynamicHeight()
    }
    
    private func setMessageViewUI() {
        messageView.backgroundColor = .yellow03
    }
    
    private func setLabelUI() {
        contentLabel.font = .p6
        writerLabel.font = .p6
    }
    
    private func setMessageViewDynamicHeight() {
        messageViewHeightConstraint.constant = (contentLabel.frame.height < 145)
        ? 200 : contentLabel.layer.frame.height + 80
    }
    
    // MARK: - IBAction
    
    
}
