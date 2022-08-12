//
//  MessagesCollectionViewCell.swift
//  Deartoday
//
//  Created by 이경민 on 2022/08/12.
//

import UIKit

import SnapKit
import Then

final class MessagesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MessagesCollectionViewCell"
    
    // MARK: - UI Property
    
    private let contentLabel = UILabel().then {
        $0.font = .p6
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    private let writerLabel = UILabel().then {
        $0.font = .p6
        $0.textColor = .black
        $0.text = "From. 미래의 나"
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        backgroundColor = .yellow03
    }
    
    private func setLayout() {
        setHierarchy()
        setConstraint()
    }
    
    private func setHierarchy() {
        addSubviews([contentLabel, writerLabel])
    }
    
    private func setConstraint() {
        contentLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        writerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(7)
        }
    }
    
    private func adjustContentSize() {
        contentLabel.setTextWithLineHeight(text: contentLabel.text, lineHeight: 16.8)
        contentLabel.sizeToFit()
        let labelHeight = (((UIScreen.main.bounds.width - 55)/2)-59)
        let isLongContent = (contentLabel.frame.height > labelHeight)
        contentLabel.lineBreakMode = isLongContent ? .byTruncatingTail : .byCharWrapping
        contentLabel.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(isLongContent ? labelHeight : contentLabel.frame.height)
        }
    }
    
    func setData(content: String) {
        contentLabel.text = content
        adjustContentSize()
    }
}
