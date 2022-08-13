//
//  MessageDetailViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/08/13.
//

import UIKit

import SnapKit
import Then

final class MessageDetailViewController: UIViewController {
    
    // MARK: - Property
    
    internal var content: String = ""
    private let messageWidth = UIScreen.main.bounds.width - 175
    
    // MARK: - UI Property
    
    private let messageView = UIView().then {
        $0.backgroundColor = .yellow03
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.font = .p6
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.text = content
        $0.setTextWithLineHeight(text: content, lineHeight: 16.8)
        $0.sizeToFit()
    }
    
    private let writerLabel = UILabel().then {
        $0.font = .p6
        $0.textColor = .black
        $0.text = "From. 미래의 나"
    }
    
    private let closeButton = UIButton().then {
        $0.setImage(Constant.Image.icClose, for: .normal)
        $0.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDynamicHeight()
    }
    
    // MARK: - @objc
    
    @objc private func closeButtonDidTap() {
        dismiss(animated: false)
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
    }
    
    private func setLayout() {
        setHierarchy()
        setConstraint()
    }
    
    private func setDynamicHeight() {
        let height = contentLabel.frame.height < 145 ? messageWidth : contentLabel.layer.frame.height + 80
        messageView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    private func setHierarchy() {
        view.addSubviews([messageView, closeButton])
        messageView.addSubviews([contentLabel, writerLabel])
    }
    
    private func setConstraint() {
        messageView.snp.makeConstraints { make in
            make.width.height.equalTo(messageWidth)
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(messageView.snp.bottom).offset(8)
            make.width.height.equalTo(44)
            make.centerX.equalTo(messageView)
        }
        
        writerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(13)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
