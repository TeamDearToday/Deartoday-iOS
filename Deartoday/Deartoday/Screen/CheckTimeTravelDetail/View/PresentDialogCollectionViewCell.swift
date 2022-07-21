//
//  PresentDialogCollectionViewCell.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/20.
//

import UIKit

final class PresentDialogCollectionViewCell: UICollectionViewCell {

    static let identifier = "PresentDialogCollectionViewCell"

    // MARK: - UI Property
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        contentLabel.font = .caption2
    }
    
    private func updateUI() {
        contentLabel.setTextWithLineHeight(text: contentLabel.text, lineHeight: 22)
        contentLabel.textAlignment = .right
        contentLabel.sizeToFit()
        print("print fsdf", contentLabel.frame.width)
        imageViewWidthConstraint.constant = contentLabel.frame.width + 32
        imageViewHeightConstraint.constant = contentLabel.frame.height + 28
    }
    
    func setData(content: String) {
        contentLabel.text = content
        updateUI()
    }
}
