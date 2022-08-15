//
//  MainsViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/08/16.
//

import UIKit

final class MainsViewController: UIViewController {
    
    // MARK: - Property
    
    private var isPushed: Bool = false
    
    // MARK: - UI Property
    
    private lazy var scrollView: UIScrollView = {
        return UIScrollView(frame: .zero).then {
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
            $0.clipsToBounds = true
            $0.contentInsetAdjustmentBehavior = .never
            $0.bounces = false
            $0.bouncesZoom = false
        }
    }()
    
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let leftImageView = UIImageView().then {
        $0.image = Constant.Image.mainLeftWithg
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let timeTravelImageView = UIImageView().then {
        $0.image = Constant.Image.btnCircleBasic
    }
    
    private let rewindImageView = UIImageView().then {
        $0.image = Constant.Image.rewind
        $0.tintColor = .blue02
    }
    
    private let timeTravelView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let timeTravelButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(timeTravelComponentDidTap), for: .touchUpInside)
    }
    
    private let rightImageView = UIImageView().then {
        $0.image = Constant.Image.mainRightWithg
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let checkMessageImageView = UIImageView().then {
        $0.image = Constant.Image.btnCircleBasic
    }
    
    private let checkTimeTravelImageView = UIImageView().then {
        $0.image = Constant.Image.btnCircleBasic
    }
    
    private lazy var messageStackView = UIStackView().then {
        $0.spacing = 4
        $0.axis = .horizontal
    }
    
    private let memoImageView = UIImageView().then {
        $0.image = Constant.Image.icnMemo
        $0.tintColor = .blue02
    }
    
    private let messageCountLabel = UILabel().then {
        $0.font = .p3
        $0.textColor = .blue02
        $0.text = "0"
    }
    
    private let checkMessageButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(checkMessageComponentDidTap), for: .touchUpInside)
    }
    
    private let checkMessageView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var timeTravelStackView = UIStackView().then {
        $0.spacing = 4
        $0.axis = .horizontal
    }
    
    private let tapeImageView = UIImageView().then {
        $0.image = Constant.Image.icnTape
        $0.tintColor = .blue02
    }
    
    private let timeTravelCountLabel = UILabel().then {
        $0.font = .p3
        $0.textColor = .blue02
        $0.text = "99"
    }
    
    private let checkTimeTravelButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(checkTimeTravelCompontntDidTap), for: .touchUpInside)
    }
    
    private let checkTimeTravelView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setGesture()
    }
    
    // MARK: - @objc
    
    @objc private func timeTravelComponentDidTap() {
        if isPushed { return }
        isPushed = true
        let timeTravel = TimeTravelViewController()
        timeTravel.modalTransitionStyle = .crossDissolve
        timeTravel.modalPresentationStyle = .fullScreen
        present(timeTravel, animated: true)
    }
    
    @objc private func checkMessageComponentDidTap() {
        if isPushed { return }
        isPushed = true
        let checkMessage = CheckMessageViewController()
        navigationController?.pushViewController(checkMessage, animated: true)
    }
    
    @objc private func checkTimeTravelCompontntDidTap() {
        if isPushed { return }
        isPushed = true
        guard let checkTimeTravel = UIStoryboard(name: Constant.Storyboard.CheckTimeTravel, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.CheckTimeTravel) as? CheckTimeTravelViewController else { return }
        navigationController?.pushViewController(checkTimeTravel, animated: true)
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
    }
    
    private func setLayout() {
        setHierarchy()
        setConstraint()
    }
    
    private func setHierarchy() {
        view.addSubviews([scrollView])
        scrollView.addSubview(contentView)
        contentView.addSubviews([leftImageView, rightImageView,
                                 timeTravelImageView, rewindImageView, timeTravelButton, timeTravelView,
                                 checkMessageImageView, messageStackView, checkMessageButton, checkMessageView,
                                 checkTimeTravelImageView, timeTravelStackView, checkTimeTravelButton, checkTimeTravelView])
        messageStackView.addArrangedSubview(memoImageView)
        messageStackView.addArrangedSubview(messageCountLabel)
        timeTravelStackView.addArrangedSubview(tapeImageView)
        timeTravelStackView.addArrangedSubview(timeTravelCountLabel)
    }
    
    private func setConstraint() {
        setBackgroundConstraint()
        setLeftScreenConstraint()
        setRightScreenConstraint()
        setHeaderViewConstraint()
        setPageControlConstraint()
    }
    
    private func setGesture() {
        let timeTravelGesture = UITapGestureRecognizer(target: self, action: #selector(timeTravelComponentDidTap))
        timeTravelView.addGestureRecognizer(timeTravelGesture)
        let checkMessageGesture = UITapGestureRecognizer(target: self, action: #selector(checkMessageComponentDidTap))
        checkMessageView.addGestureRecognizer(checkMessageGesture)
        let checkTimeTravelGesture = UITapGestureRecognizer(target: self, action: #selector(checkTimeTravelCompontntDidTap))
        checkTimeTravelView.addGestureRecognizer(checkTimeTravelGesture)
    }
}

// MARK: - Constraint

extension MainsViewController {
    private func setBackgroundConstraint() {
        scrollView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
            $0.width.equalTo(view.snp.width).priority(.low)
            $0.height.equalTo(view.snp.height)
        }
        
        leftImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(getDeviceWidth())
        }
        
        rightImageView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.width.equalTo(getDeviceWidth())
            $0.leading.equalTo(leftImageView.snp.trailing)
        }
    }
    
    private func setLeftScreenConstraint() {
        timeTravelButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(constraintByNotch(convertByHeightRatio(312), 268))
            $0.leading.equalToSuperview().inset(convertByWidthRatio(16))
            $0.height.equalTo(convertByWidthRatio(246))
            $0.width.equalTo(convertByWidthRatio(246) * (265 / 246))
        }
        
        timeTravelImageView.snp.makeConstraints {
            $0.leading.equalTo(timeTravelButton.snp.leading).offset(convertByWidthRatio(81))
            $0.bottom.equalTo(timeTravelButton.snp.top).offset(-11)
            $0.width.equalTo(68)
            $0.height.equalTo(90)
        }
        
        rewindImageView.snp.makeConstraints {
            $0.top.equalTo(timeTravelImageView.snp.top).offset(20)
            $0.width.height.equalTo(28)
            $0.centerX.equalTo(timeTravelImageView)
        }
        
        timeTravelView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(timeTravelImageView).offset(0)
        }
    }
    
    private func setRightScreenConstraint() {
        checkMessageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(constraintByNotch(convertByWidthRatio(164), 120))
            $0.trailing.equalToSuperview().inset(convertByWidthRatio(25))
            $0.height.equalTo(convertByWidthRatio(177))
            $0.width.equalTo(convertByWidthRatio(177) * (181 / 177))
        }
        
        checkMessageImageView.snp.makeConstraints {
            $0.trailing.equalTo(checkMessageButton.snp.trailing).inset(75)
            $0.bottom.equalTo(checkMessageButton.snp.top).offset(45)
            $0.width.equalTo(68)
            $0.height.equalTo(90)
        }
        
        messageStackView.snp.makeConstraints {
            $0.top.equalTo(checkMessageImageView.snp.top).offset(23)
            $0.centerX.equalTo(checkMessageImageView)
        }
        
        memoImageView.snp.makeConstraints {
            $0.width.height.equalTo(22)
        }
        
        checkMessageView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(checkMessageImageView).offset(0)
        }
        
        checkTimeTravelButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(constraintByNotch(convertByWidthRatio(463), 419))
            $0.trailing.equalToSuperview().inset(convertByWidthRatio(38))
            $0.height.equalTo(convertByWidthRatio(189))
            $0.width.equalTo(convertByWidthRatio(189) * (313 / 189))
        }
        
        checkTimeTravelImageView.snp.makeConstraints {
            $0.trailing.equalTo(checkTimeTravelButton.snp.trailing).inset(99)
            $0.bottom.equalTo(checkTimeTravelButton.snp.top).offset(45)
            $0.width.equalTo(68)
            $0.height.equalTo(90)
        }
        
        timeTravelStackView.snp.makeConstraints {
            $0.top.equalTo(checkTimeTravelImageView.snp.top).offset(23)
            $0.centerX.equalTo(checkTimeTravelImageView)
        }
        
        tapeImageView.snp.makeConstraints {
            $0.width.height.equalTo(22)
        }
        
        checkTimeTravelView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(checkTimeTravelImageView).offset(0)
        }
    }
    
    private func setHeaderViewConstraint() {
        
    }
    
    private func setPageControlConstraint() {
        
    }
}
