//
//  DDSButton.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

import SnapKit
import Then

/* Dear today TextField : Dear today에서 사용되는 버튼입니다. */

final class DDSButton: UIButton {
    
    // MARK: - Button Style
    
    enum ButtonStyle {
        case present
        case past
        case disable
        
        var textColor: UIColor {
            
            // MARK: - TODO: Color Asset 변경
            
            switch self {
            case .present:
                return UIColor.blue
            case .past:
                return UIColor.darkGray
            case .disable:
                return UIColor.lightGray
            }
        }
        
        var backgroundImage: UIImage {
            
            // MARK: - TODO: Image Asset 변경
            
            switch self {
            case .present:
                return UIImage(named: "") ?? UIImage()
            case .past:
                return UIImage(named: "") ?? UIImage()
            case .disable:
                return UIImage(named: "") ?? UIImage()
            }
        }
        
        var buttonLeftIcon: UIImage {
            
            // MARK: - TODO: Image Asset 변경
            
            switch self {
            case .present:
                return UIImage(named: "") ?? UIImage()
            case .past, .disable:
                return UIImage(named: "") ?? UIImage()
            }
        }
        
        var isDisabled: Bool {
            switch self {
            case .present, .past:
                return false
            case .disable:
                return true
            }
        }
    }
    
    // MARK: - Property
    
    public var text: String? = nil {
        didSet {
            textLabel.text = text
            setTitle(text, for: .normal)
        }
    }
    
    public var hasLeftIcon: Bool = false {
        didSet {
            if hasLeftIcon { setTitle("", for: .normal)}
            setLeftIconImage()
        }
    }
    
    public var style: ButtonStyle = .present {
        didSet {
            self.isEnabled = !style.isDisabled
            setTitleColor()
            setStyle()
        }
    }
    
    // MARK: - UI Property
    
    private lazy var stackView = UIStackView().then {
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.spacing = 6
    }
    
    private var leftIconImageView = UIImageView().then {
        $0.backgroundColor = .lightGray
    }
    
    private var textLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    
    private func setTitleColor() {
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        setTitleColor(style.textColor, for: .normal)
        setTitleColor(style.textColor, for: .highlighted)
        
        switch style {
        case .present:
            textLabel.textColor = .blue
        case .past:
            textLabel.textColor = .darkGray
        case .disable:
            textLabel.textColor = .lightGray
        }
    }
    
    private func setStyle() {
        setBackgroundImage(style.backgroundImage, for: .normal)
        setBackgroundImage(style.backgroundImage, for: .highlighted)
    }
    
    private func setLeftIconImage() {
        stackView.isHidden = !hasLeftIcon
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(leftIconImageView)
        stackView.addArrangedSubview(textLabel)
        
        leftIconImageView.snp.makeConstraints {
            $0.width.height.equalTo(22)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(22+textLabel.intrinsicContentSize.width+6)
        }
    }
}
