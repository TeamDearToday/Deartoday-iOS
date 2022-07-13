//
//  DialogView.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/13.
//

import UIKit

import SnapKit
import Then

final class DialogMessageView: UIView {
    
    @frozen
    enum DialogType {
        case past
        case present
        
        var backgroundImage: UIImage {
            switch self {
            case .past:
                return UIImage()
            case .present:
                return UIImage()
            }
        }
    }
    
    // MARK: - Property
    
    internal var dialogText: String = "" {
        didSet {
            dialogLabel.text = dialogText
            dialogLabel.addLetterSpacing()
            dialogLabel.addLineSpacing(spacing: 23)
        }
    }
    
    internal var dialogType: DialogType = .past {
        didSet {
            backgroundImageView.image = dialogType.backgroundImage
        }
    }
    
    // MARK: - UI Property
    
    private var backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private var dialogLabel = UILabel().then {
        $0.textColor = .darkGray01
        $0.font = .p6
        $0.textAlignment = .left
        $0.numberOfLines = 0
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
        backgroundColor = .clear
    }
    
    private func setLayout() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(dialogLabel)
        
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        dialogLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
