//
//  PastImageCollectionViewCell.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/19.
//

import UIKit

import Kingfisher

final class PastImageCollectionViewCell: UICollectionViewCell {

    static let identifier = "PastImageCollectionViewCell"

    // MARK: - UI Property
    
    @IBOutlet weak var pastImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        pastImageView.layer.cornerRadius = 8
    }
}
