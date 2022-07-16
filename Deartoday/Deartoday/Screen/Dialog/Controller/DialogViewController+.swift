//
//  DialogViewController+.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/14.
//

import UIKit

extension DialogViewController {
    // 나레이션 라벨 애니메이션
    internal func showNarrationLabel(_ component: UILabel, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut) {
            component.transform = CGAffineTransform(translationX: 0, y: -16)
            component.alpha = 1
        } completion: { _ in
            completion()
        }
    }
    
    internal func hideNarrationLabel(_ component: UILabel, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut) {
            component.alpha = 0
        } completion: { _ in
            completion()
        }
    }
    
    // 버튼 애니메이션
    internal func showButton(_ component: UIButton, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.6, delay: 0.6, options: .curveEaseOut) {
            component.alpha = 1
        } completion: { _ in
            completion()
        }
    }
    
    internal func hideButton(_ component: UIButton, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.6, delay: 0.6, options: .curveEaseOut) {
            component.alpha = 0
        } completion: { _ in
            completion()
        }
    }
    
    // 과거의 나 텍스트 애니메이션
    internal func showPastView(_ component: UIView, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, delay: 0.8, options: .curveEaseOut) {
            component.alpha = 1
        } completion: { _ in
            completion()
        }
    }
    
    internal func hidePastView(_ component: UIView, delay: Double = 0.8, duration: Double = 0.3, completion: @escaping () -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut) {
            component.alpha = 0
        } completion: { _ in
            completion()
        }
    }
    
    // 현재의 나 텍스트 애니메이션
    internal func showPresentView(_ component: UIView, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseOut) {
            component.alpha = 1
        } completion: { _ in
            completion()
        }
    }
    
    internal func hidePresentView(_ component: UIView, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseOut) {
            component.alpha = 0
        } completion: { _ in
            completion()
        }
    }
    
    // 나타나는 애니메이션
    internal func showView(_ component: UIView, delay: Double = 0.8, duration: Double = 0.3){
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut) {
            component.alpha = 1
        }
    }
    
    internal func hideView(_ component: UIView, delay: Double = 0.8, duration: Double = 0.3){
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut) {
            component.alpha = 0
        } 
    }
}
