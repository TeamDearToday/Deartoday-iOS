//
//  TimeTravelInfoView.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/18.
//

import UIKit

final class TimeTravelInfoView: UIView {

    // MARK: - Property
    
    // MARK: - UI Property
    
    private let timeTravelToLabel = UILabel().then {
        $0.textColor = .blue02
        $0.font = .h0
    }
    
    private let rewindImageView = UIImageView().then {
        $0.image = Constant.Image.rewind
        $0.tintColor = .gray01
    }
    
    private let timeTravelFromLabel = UILabel().then {
        $0.textColor = .gray01
        $0.font = .caption0
    }
    
    private let timeTravelTitleLabel = UILabel().then {
        $0.textColor = .darkGray00
        $0.font = .h2
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    // MARK: - Custom Method

    private func setUI() {
        setHierarchy()
        setConstraint()
    }
    
    private func setHierarchy() {
        addSubviews([timeTravelToLabel,
                    rewindImageView,
                    timeTravelFromLabel,
                    timeTravelTitleLabel])
    }
    
    private func setConstraint() {
        timeTravelToLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(0)
        }
        
        timeTravelFromLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(timeTravelToLabel.snp.centerY)
        }
        
        rewindImageView.snp.makeConstraints { make in
            make.trailing.equalTo(timeTravelFromLabel.snp.leading).offset(4)
            make.centerY.equalTo(timeTravelToLabel.snp.centerY)
            make.width.height.equalTo(22)
        }
        
        timeTravelTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(timeTravelToLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
        }
    }
}
