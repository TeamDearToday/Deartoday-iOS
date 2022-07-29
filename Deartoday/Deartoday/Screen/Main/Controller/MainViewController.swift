//
//  ViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Property
    
    private var isPushed: Bool = false
    
    // MARK: - UI Property

    @IBOutlet weak var backgroundScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var timeTravelView: UIView!
    @IBOutlet weak var checkTimeTravelView: UIView!
    @IBOutlet weak var checkMessageView: UIView!
    @IBOutlet var iconImageViewCollection: [UIImageView]!
    @IBOutlet var messageCountLabelCollection: [UILabel]!
    @IBOutlet var dateLabelCollection: [UILabel]!
    @IBOutlet weak var pageControlBottomConstraint: NSLayoutConstraint!
    @IBOutlet var boxButtonTopConstraintCollection: [NSLayoutConstraint]!
    @IBOutlet var boxButtonHeightConstraintCollection: [NSLayoutConstraint]!
    @IBOutlet var backgroundImageViewWidthConstraintCollection: [NSLayoutConstraint]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setData()
        setDelegate()
        setGesture()
        setBackSwipeGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setInitializeState()
        setPageControl(page: backgroundScrollView.contentOffset.x == 0 ? 0 : 1)
        getMainData()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setConstraint()
        setLabelUI()
        setLayout()
    }
    
    private func setData() {
        setDate()
    }
    
    private func setDelegate() {
        backgroundScrollView.delegate = self
    }
    
    private func setDate() {
        for i in 0...2 {
            dateLabelCollection[i].text = getDateInfo()[i]
        }
    }
    
    private func setPageControl(page: Int) {
        pageControl.setIndicatorImage(UIImage(systemName: "circle.fill"), forPage: page)
        pageControl.setIndicatorImage(UIImage(systemName: "circle"), forPage: page == 0 ? 1 : 0)
    }
    
    private func setCountLabel(count: Int) {
        messageCountLabelCollection.forEach {
            $0.text = count > 99 ? "99+" : "\(count)"
        }
    }
    
    private func setGesture() {
        let timeTravelTapGesture = UITapGestureRecognizer(target: self, action: #selector(timeTravelComponentDidTap))
        timeTravelView.addGestureRecognizer(timeTravelTapGesture)
        let checkMessageTapGesture = UITapGestureRecognizer(target: self, action: #selector(checkMessageComponentDidTap))
        checkMessageView.addGestureRecognizer(checkMessageTapGesture)
        let checkTravelTapGesture = UITapGestureRecognizer(target: self, action: #selector(checkTimeTravelComponentDidTap))
        checkTimeTravelView.addGestureRecognizer(checkTravelTapGesture)
    }
    
    private func setInitializeState() {
        isPushed = false
    }
    
    // MARK: - @objc
    
    @objc private func timeTravelComponentDidTap() {
        goToTimeTravelViewController()
    }
    
    @objc private func checkMessageComponentDidTap() {
        goToCheckMessageViewController()
    }
    
    @objc private func checkTimeTravelComponentDidTap() {
        goToCheckTimeTravelViewController()
    }
    
    // MARK: - IBAction
    
    @IBAction func timeTravelButtonDidTap(_ sender: Any) {
        goToTimeTravelViewController()
    }
    
    @IBAction func checkMessageButtonDidTap(_ sender: Any) {
        goToCheckMessageViewController()
    }
    
    @IBAction func checkTimeTravelButtonDidTap(_ sender: Any) {
        goToCheckTimeTravelViewController()
    }
    
    @IBAction func settingButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func helpButtonDidTap(_ sender: Any) {
    }
}

// MARK: - UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            setPageControl(page: 0)
        }
        else if scrollView.contentOffset.x == getDeviceWidth() {
            setPageControl(page: 1)
        }
    }
}

// MARK: - Network

extension MainViewController {
    private func getMainData() {
        MainAPI.shared.getMain { mainData in
            guard let mainData = mainData else { return }
            self.setCountLabel(count: mainData.data?.timeTravelCount ?? 0)
        }
    }
}

// MARK: - Component UI Setting functions

extension MainViewController {
    ///Color Asset 추가 시 refactoring 가능
    private func setLabelUI() {
        messageCountLabelCollection.forEach {
            $0.textColor = .blue02
            $0.font = .p3
        }
        dateLabelCollection.forEach {
            $0.font = .h0
            $0.textColor = .lightBlue00
        }
        iconImageViewCollection.forEach {
            $0.tintColor = .blue02
        }
    }
    
    private func setConstraint() {
        backgroundImageViewWidthConstraintCollection.forEach {
            $0.constant = getDeviceWidth()
        }
    }
    
    private func setLayout() {
        boxButtonHeightConstraintCollection.forEach {
            $0.constant = getDeviceWidth() * ($0.constant / 375)
        }
        boxButtonTopConstraintCollection.forEach {
            $0.constant = (UIScreen.main.hasNotch) ?
            getDeviceHeight() * ($0.constant / 812) : $0.constant - 44
        }
        pageControlBottomConstraint.constant = UIScreen.main.hasNotch ? 0 : 20
    }
}

// MARK: - View Controller transition

extension MainViewController {
    private func goToTimeTravelViewController() {
        if isPushed { return }
        isPushed = true
        let timeTravel = TimeTravelViewController()
        timeTravel.modalTransitionStyle = .crossDissolve
        timeTravel.modalPresentationStyle = .fullScreen
        present(timeTravel, animated: true)
    }
    
    private func goToCheckMessageViewController() {
        if isPushed { return }
        isPushed = true
        guard let checkMessage = UIStoryboard(name: Constant.Storyboard.CheckMessage, bundle: nil)
            .instantiateViewController(withIdentifier: Constant.ViewController.CheckMessage) as? CheckMessageViewController else { return }
        navigationController?.pushViewController(checkMessage, animated: true)
    }
    
    private func goToCheckTimeTravelViewController() {
        if isPushed { return }
        isPushed = true
        guard let checkTimeTravel = UIStoryboard(name: Constant.Storyboard.CheckTimeTravel, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.CheckTimeTravel) as? CheckTimeTravelViewController else { return }
        navigationController?.pushViewController(checkTimeTravel, animated: true)
    }
}
