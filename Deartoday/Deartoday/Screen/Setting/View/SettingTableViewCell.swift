//
//  SettingTableViewCell.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/21.
//

import UIKit

import SnapKit
import Then

final class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"
    
    // MARK: - UI Property
    
    var titleLabel = UILabel().then {
        $0.font = .p2
        $0.textAlignment = .left
        $0.textColor = .darkGray01
        $0.addLineSpacing(spacing: 24)
    }
    
    var switchButton = UISwitch().then {
        $0.isOn = true
        $0.onTintColor = .blue01
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .lightBlue01
    }
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func setLayout() {
        contentView.addSubviews([titleLabel, switchButton,
                                 separatorView])
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        switchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
