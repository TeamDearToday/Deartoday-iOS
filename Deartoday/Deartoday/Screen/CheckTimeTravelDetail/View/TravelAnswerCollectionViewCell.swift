//
//  TravelAnswerCollectionViewCell.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/19.
//

import UIKit

final class TravelAnswerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TravelAnswerCollectionViewCell"

    // MARK: - UI Property
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentImageVIewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        titleLabel.font = .caption2
        contentLabel.font = .caption2
    }
    
    private func updateImageViewUI() {
        //image view height는 라벨의 현재 사이즈에 28 더하기
        //width는 32 더하기
        //label width 정해놓긴 했는데 안댈라나?
    }
    
    func setData(answer: String) {
        contentLabel.text = answer
        updateImageViewUI()
    }
}
