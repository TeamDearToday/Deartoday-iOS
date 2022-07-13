//
//  DialogViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/13.
//

import UIKit

import SnapKit
import Then

final class DialogViewController: UIViewController {
    
    // MARK: - Property
    
    internal var year: String = "0000" {
        didSet {
            yearLabel.text = "\(year)"
        }
    }
    
    internal var month: String = "00" {
        didSet {
            monthLabel.text = "\(month)"
        }
    }
    
    internal var day: String = "00" {
        didSet {
            dayLabel.text = "\(day)"
        }
    }
    
    internal var guideText: String = "" {
        didSet {
            guideLabel.text = guideText
            guideLabel.addLineSpacing(spacing: 25)
            guideLabel.textAlignment = .center
        }
    }
    
    // MARK: - UI Property
    
    private var backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Constant.Image.imgHomePastLeft
    }
    
    private var yearBackView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Constant.Image.bgYearYellow
    }
    
    private var yearLabel = UILabel().then {
        $0.text = "0000"
    }
    
    private var monthBackView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Constant.Image.bgMonthYellow
    }
    
    private var monthLabel = UILabel().then {
        $0.text = "00"
    }
    
    private var dayBackView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Constant.Image.bgMonthYellow
    }
    
    private var dayLabel = UILabel().then {
        $0.text = "00"
    }
    
    private var exitButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(Constant.Image.icExit, for: .normal)
        $0.setImage(Constant.Image.icExit, for: .highlighted)
        $0.tintColor = .yellow02
    }
    
    private var guideLabel = UILabel().then {
        $0.textColor = .lightGray00
        $0.font = .p3
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private lazy var nextButton = DDSButton().then {
        $0.text = "안녕!"
        $0.hasLeftIcon = false
        $0.style = .present
        $0.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    // MARK: - @objc
    
    @objc func exitButtonDidTap() {
        dismiss(animated: true)
    }
    
    @objc func nextButtonDidTap() {
        guideText = "당신에게 궁금한게 많은지 이것저것 질문을 합니다."
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        view.backgroundColor = .gray
        
        guideText = """
                    지금의 당신을 발견한 2016년도의 당신,
                    반갑게 손을 흔들며 당신을 맞이하네요.
                    한 번 인사를 건네보세요!
                    """
        
        [yearLabel, monthLabel, dayLabel].forEach {
            $0.textColor = .gray00
            $0.font = .h0
        }
    }
    
    private func setLayout() {
        view.addSubviews([backgroundImageView,
                          yearBackView,
                          monthBackView,
                          dayBackView,
                          exitButton,
                          guideLabel,
                          nextButton])
        
        yearBackView.addSubview(yearLabel)
        monthBackView.addSubview(monthLabel)
        dayBackView.addSubview(dayLabel)
        
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        yearBackView.snp.makeConstraints {
            $0.width.equalTo(114)
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(6)
        }
        
        monthBackView.snp.makeConstraints {
            $0.width.equalTo(73)
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(106)
        }
        
        dayBackView.snp.makeConstraints {
            $0.width.equalTo(73)
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(165)
        }
        
        [yearLabel , monthLabel, dayLabel].forEach {
            $0.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(14)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(44)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(324)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(150)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
        }
    }
}
