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
    
    func setBackSwipeGesture() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    ///Constraint 설정 시 노치 유무로 기기를 대응하는 상황에서 사용
    func constraintByNotch(_ hasNotch: Int, _ noNotch: Int) -> ConstraintOffsetTarget {
        return UIScreen.main.hasNotch ? hasNotch : noNotch
    }
}
