//
//  TimeTravelViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/08.
//

import UIKit

import SnapKit
import Then

final class TimeTravelViewController: UIViewController {
    
    // MARK: - Property
    
    private var todayDate = Date()
    
    private var momentDate = Date()
    
    // MARK: - UI Property
    
    private var backImageView = UIImageView().then {
        $0.image = Constant.Image.mainLeftWithg
    }
    
    private var coverView = UIView().then {
        $0.backgroundColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 0.8)
    }
    
    private var yearBackView = UIView().then {
        $0.backgroundColor = UIColor(red: 240 / 255, green: 246 / 255, blue: 255 / 255, alpha: 0.2)
    }
    
    private var yearLabel = UILabel().then {
        $0.text = "2022"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 24, weight: .medium)
    }
    
    private var monthBackView = UIView().then {
        $0.backgroundColor = UIColor(red: 240 / 255, green: 246 / 255, blue: 255 / 255, alpha: 0.2)
    }
    
    private var monthLabel = UILabel().then {
        $0.text = "07"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 24, weight: .medium)
    }
    
    private var dateBackView = UIView().then {
        $0.backgroundColor = UIColor(red: 240 / 255, green: 246 / 255, blue: 255 / 255, alpha: 0.2)
    }
    
    private var dateLabel = UILabel().then {
        $0.text = "02"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 24, weight: .medium)
    }
    
    private var exitButton = UIButton().then {
        $0.backgroundColor = .systemPink
    }
    
    private var guideLabel = UILabel().then {
        $0.text = """
                  테이프를 터치하여
                  돌아가고 싶은 순간을 선택해주세요
                  """
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .white
        $0.numberOfLines = 2
    }
    
    private var timeTravelView = TimeTravelView()
    
    private lazy var returnButton = DDSButton().then {
        $0.style = .disable
        $0.text = "과거로 돌아가기"
        $0.hasLeftIcon = true
        $0.addTarget(self, action: #selector(returnButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        view.backgroundColor = .white
        
        [yearBackView, monthBackView, dateBackView].forEach {
            $0.layer.applySketchShadow(color: UIColor(red: 0 / 255,
                                                      green: 26 / 255,
                                                      blue: 255 / 255,
                                                      alpha: 0.14),
                                       alpha: 1,
                                       x: 0,
                                       y: 0,
                                       blur: 10,
                                       spread: 0)
            $0.makeRound(radius: 8)
        }
    }
    
    private func setLayout() {
        view.addSubviews([backImageView,
                          coverView,
                          monthBackView,
                          yearBackView,
                          dateBackView,
                          exitButton,
                          guideLabel,
                          timeTravelView,
                          returnButton])
        
        yearBackView.addSubview(yearLabel)
        monthBackView.addSubview(monthLabel)
        dateBackView.addSubview(dateLabel)
        
        backImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        coverView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        yearBackView.snp.makeConstraints {
            $0.width.equalTo(94)
            $0.height.equalTo(36)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        monthBackView.snp.makeConstraints {
            $0.width.equalTo(53)
            $0.height.equalTo(36)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalTo(yearBackView.snp.trailing).offset(6)
        }
        
        dateBackView.snp.makeConstraints {
            $0.width.equalTo(53)
            $0.height.equalTo(36)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalTo(monthBackView.snp.trailing).offset(6)
        }
        
        [yearLabel, monthLabel, dateLabel].forEach {
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
            $0.top.equalTo(yearBackView.snp.bottom).offset(56)
            $0.leading.equalToSuperview().inset(16)
        }
        
        timeTravelView.snp.makeConstraints {
            $0.top.equalTo(yearBackView.snp.bottom).offset(119)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(380)
        }
        
        returnButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(6)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
    }
    
    // MARK: - @objc
    
    @objc func returnButtonDidTap() {
        print("돌아가기 버튼 누름")
    }
}
