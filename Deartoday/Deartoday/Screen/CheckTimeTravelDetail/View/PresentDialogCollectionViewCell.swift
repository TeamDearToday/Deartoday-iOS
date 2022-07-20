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
    @IBOutlet weak var dummyLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        contentLabel.font = .caption2
        dummyLabel.font = .caption2
    }
    
    //dummy label sizetofit을 해서 width를 본다.
    //label의 최대 width 240
    
    //label width가 240보다 크면????
    //image view의 width는 272
    //image view의 height는 label의 height + 28
    
    //그게 아니면???
    //image view의 width는 sizetofit을 한 label의 width + 32
    //image view의 height는 50
    
    
    //폰트 한 줄 당 height는 22
    //줄 수 * 22 + 28 -> image view의 높이
    
    func setData(content: String) {
        contentLabel.text = content
        dummyLabel.text = content
    }
}
