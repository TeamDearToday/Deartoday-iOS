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
    
    private let messageStackView = UIStackView().then {
        $0.spacing = 4
    }
    
    private let memoImageView = UIImageView().then {
        $0.image = Constant.Image.icnMemo
    }
    
    private let messageCountLabel = UILabel().then {
        $0.text = "어쩌구"
    }
    
    private let checkMessageButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(checkMessageComponentDidTap), for: .touchUpInside)
    }
    
    private let checkMessageView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let timeTravelStackView = UIStackView().then {
        $0.spacing = 4
    }
    
    private let tapeImageView = UIImageView().then {
        $0.image = Constant.Image.icnTape
    }
    
    private let timeTravelCountLabel = UILabel().then {
        $0.text = "어쩌구"
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
        messageStackView.addSubviews([memoImageView, messageCountLabel])
        timeTravelStackView.addSubviews([tapeImageView, timeTravelCountLabel])
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
        scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
            make.width.equalTo(view.snp.width).priority(.low)
            make.height.equalTo(view.snp.height)
        }
        
        leftImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(getDeviceWidth())
        }
        
        rightImageView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(getDeviceWidth())
            make.leading.equalTo(leftImageView.snp.trailing)
        }
    }
    
    private func setLeftScreenConstraint() {
        
    }
    
    private func setRightScreenConstraint() {

    }
    
    private func setHeaderViewConstraint() {
        
    }
    
    private func setPageControlConstraint() {
        
    }
}
