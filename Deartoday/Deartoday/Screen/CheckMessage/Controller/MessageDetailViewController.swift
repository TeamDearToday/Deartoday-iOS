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
    
    private lazy var scrollView: UIScrollView = {
        return UIScrollView(frame: .zero).then {
            $0.backgroundColor = .clear
            $0.bounces = false
            $0.contentInsetAdjustmentBehavior = .never
        }
    }()
    
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.font = .p6
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.lineBreakMode = .byCharWrapping
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
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
        let maxHeight = getDeviceHeight() - 400
        let contentHeight = contentLabel.frame.height + 80
        let messageHeight = contentHeight < messageWidth ? messageWidth :
        (contentHeight > maxHeight ? maxHeight : contentHeight)
        
        messageView.snp.updateConstraints { make in
            make.height.equalTo(messageHeight)
        }
        scrollView.snp.updateConstraints { make in
            make.height.equalTo(messageHeight - 80)
        }
    }

    private func setHierarchy() {
        view.addSubviews([messageView, closeButton])
        messageView.addSubviews([scrollView, writerLabel])
        scrollView.addSubview(contentView)
        contentView.addSubview(contentLabel)
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
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(messageWidth - 80)
        }

        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(0)
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
        }

        contentLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(0)
            make.trailing.equalTo(messageView.snp.trailing).inset(20)
            make.bottom.equalToSuperview().inset(0)
        }
    }
}
