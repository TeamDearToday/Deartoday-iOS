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
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Custom Method
    
    func setData(_ labelText: String) {
        titleTextLabel.text = labelText
    }
    
    private func setUI() {
        titleTextLabel.textColor = .darkGray01
        titleTextLabel.textAlignment = .left
        titleTextLabel.font = .p2
        titleTextLabel.addLineSpacing(spacing: 24)
    }
}
