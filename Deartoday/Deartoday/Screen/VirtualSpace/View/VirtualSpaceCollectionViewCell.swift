//
//  TimeTravelVirtualSpaceCollectionViewCell.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/12.
//

import UIKit

import SnapKit
import Then
import Kingfisher

class VirtualSpaceCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String { return String(describing: self) }
    
    // MARK: - UI Property
    
    private var mediaImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: - Initializer
    
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
        contentView.layer.cornerRadius = 20
    }
    
    private func setLayout() {
        contentView.addSubview(mediaImageView)
        
        mediaImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    internal func setData(_ data: String) {
        let url = URL(string: data)
        mediaImageView.kf.setImage(with: url)
        
        mediaImageView.makeRound(radius: 20)
    }
}
