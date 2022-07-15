//
//  MessageCollectionViewCell.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/15.
//

import UIKit

final class MessageCollectionViewCell: UICollectionViewCell {

    static let identifier = "MessageCollectionViewCell"
    
    // MARK: - UI Property
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    // MARK: - Custom Method
    
    private func setUI() {
        backgroundColor = .yellow03
        contentLabel.font = .p6
        writerLabel.font = .p6
    }
    
    func setData(content: String) {
        contentLabel.text = content
    }
}
