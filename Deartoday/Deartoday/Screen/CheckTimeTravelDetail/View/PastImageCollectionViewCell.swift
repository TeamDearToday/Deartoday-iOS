//
//  PastImageCollectionViewCell.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/18.
//

import UIKit

import SnapKit
import Then

final class PastImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PastImageCollectionViewCell"
    
    // MARK: - UI Property
    
    private let pastImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        addSubviews([pastImageView])
        pastImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setData(image: String) {
        pastImageView.kf.setImage(with: URL(string: image))
    }
}
