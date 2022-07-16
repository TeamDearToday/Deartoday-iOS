//
//  ViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - UI Property

    @IBOutlet weak var backgroundScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var messageCountLabelCollection: [UILabel]!
    @IBOutlet var dateLabelCollection: [UILabel]!
    @IBOutlet var boxButtonTopConstraintCollection: [NSLayoutConstraint]!
    @IBOutlet var boxButtonHeightConstraintCollection: [NSLayoutConstraint]!
    @IBOutlet var backgroundImageViewWidthConstraintCollection: [NSLayoutConstraint]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setData()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setPageControl(page: backgroundScrollView.contentOffset.x == 0 ? 0 : 1)
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setConstraint()
        setLabelUI()
        setPageControlUI()
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
    
    // MARK: - IBAction
    
    @IBAction func timeTravelButtonDidTap(_ sender: Any) {
        let timeTravel = TimeTravelViewController()
        timeTravel.modalTransitionStyle = .crossDissolve
        timeTravel.modalPresentationStyle = .overFullScreen
        present(timeTravel, animated: true)
    }
    
    @IBAction func checkMessageButtonDidTap(_ sender: Any) {
        guard let checkMessage = UIStoryboard(name: Constant.Storyboard.CheckMessage, bundle: nil)
            .instantiateViewController(withIdentifier: Constant.ViewController.CheckMessage) as? CheckMessageViewController else { return }
        navigationController?.pushViewController(checkMessage, animated: true)
    }
    
    @IBAction func checkTimeTravelButtonDidTap(_ sender: Any) {
        guard let checkTimeTravel = UIStoryboard(name: Constant.Storyboard.CheckTimeTravel, bundle: nil).instantiateViewController(withIdentifier: Constant.ViewController.CheckTimeTravel) as? CheckTimeTravelViewController else { return }
        navigationController?.pushViewController(checkTimeTravel, animated: true)
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
    }
    
    private func setPageControlUI() {
        pageControl.currentPageIndicatorTintColor = .lightBlue00
        pageControl.pageIndicatorTintColor = .lightBlue00
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
    }
}
