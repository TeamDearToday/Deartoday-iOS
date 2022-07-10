//
//  DDSTextField.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

import SnapKit

/* Dear today TextField : Dear today에서 사용되는 텍스트필드입니다. */

public class DDSTextField: UITextField {
    
    // MARK: - Property
    
    public override var placeholder: String? {
        didSet {
            setPlaceholder()
        }
    }
    
    public var isFocusing: Bool = false {
        didSet {
            text = ""
        }
    }
    
    // MARK: - UI Property
    
    private var underlineView = UIView().then {
        $0.backgroundColor = .blue02
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
    
    // MARK: - Set UI
    
    private func setUI() {
        textColor = .lightBlue01
        tintColor = .blue02
        backgroundColor = .clear
        setPadding()
    }
    
    private func setLayout() {
        addSubview(underlineView)
        
        snp.makeConstraints {
            $0.height.equalTo(47)
        }
        
        underlineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func setPlaceholder() {
        guard let placeholder = placeholder else {
            return
        }

        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.gray01]
        )
    }
}
