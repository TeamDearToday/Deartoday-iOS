//
//  UIViewController+.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/10.
//

import UIKit

import SnapKit

// MARK: - Data 가져오기 기능

extension UIViewController {
    
    func getDateInfo() -> [String] {
        let year = DateFormatter()
        year.dateFormat = "yyyy"

        let month = DateFormatter()
        month.dateFormat = "MM"

        let day = DateFormatter()
        day.dateFormat = "dd"

        return [year.string(from: Date()),
                month.string(from: Date()),
                day.string(from: Date())]
    }
    
    func getYearInfo() -> String {
        let year = DateFormatter()
        year.dateFormat = "yyyy"
        return year.string(from: Date())
    }

    func getMonthInfo() -> String {
        let month = DateFormatter()
        month.dateFormat = "MM"
        return month.string(from: Date())
    }

    func getDayInfo() -> String {
        let day = DateFormatter()
        day.dateFormat = "dd"
        return day.string(from: Date())
    }
    
    func getDeviceWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func getDeviceHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    ///main navigation controller로 root view controller 변경
    func changeMainRootViewController() {
        let mainViewController = UINavigationController(rootViewController: MainsViewController())
        mainViewController.isNavigationBarHidden = true
        changeRootViewController(mainViewController)
    }
    
    func setBackSwipeGesture() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    ///Constraint 설정 시 노치 유무로 기기를 대응하는 상황에서 사용
    func constraintByNotch(_ hasNotch: CGFloat, _ noNotch: CGFloat) -> CGFloat {
        return UIScreen.main.hasNotch ? hasNotch : noNotch
    }
    
    ///아이폰 13 미니(width 375)를 기준으로 레이아웃을 잡고, 기기의 width 사이즈를 곱해 대응 값을 구할 때 사용
    func convertByWidthRatio(_ convert: CGFloat) -> CGFloat {
        return (convert / 375) * getDeviceWidth()
    }
    
    ///아이폰 13 미니(height 812)를 기준으로 레이아웃을 잡고, 기기의 height 사이즈를 곱해 대응 값을 구할 때 사용
    func convertByHeightRatio(_ convert: CGFloat) -> CGFloat {
        return (convert / 812) * getDeviceHeight()
    }
}
