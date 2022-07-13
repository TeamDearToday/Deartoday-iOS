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
    }
    
    private func setMessageViewUI() {
        messageView.backgroundColor = .yellow03
    }
    
    private func setLabelUI() {
        contentLabel.font = .p6
        writerLabel.font = .p6
    }
    
    // MARK: - IBAction
    
    
}
