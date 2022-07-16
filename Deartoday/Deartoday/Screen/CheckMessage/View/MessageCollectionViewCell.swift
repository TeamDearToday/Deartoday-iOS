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
    @IBOutlet weak var contentLabelHeightConstraint: NSLayoutConstraint!
    
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
        adjustContentSize()
    }
    
    private func adjustContentSize() {
        contentLabel.sizeToFit()
        let labelHeight = (((UIScreen.main.bounds.width - 55)/2)-59)
        contentLabelHeightConstraint.constant = (contentLabel.frame.height > labelHeight) ?
        labelHeight : contentLabel.frame.height
    }
    
    func setData(content: String) {
        contentLabel.text = content
        adjustContentSize()
    }
}
