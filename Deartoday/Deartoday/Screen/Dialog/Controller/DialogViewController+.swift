//
//  DialogViewController+.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/14.
//

import UIKit

extension DialogViewController {
    // 나레이션 라벨 애니메이션
    private func showNarrationLabel(_ component: UILabel) {
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut) {
            component.alpha = 1
        }
    }
    
    private func hideNarrationLabel(_ component: UILabel) {
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut) {
            component.alpha = 0
        }
    }
    
    // 버튼 애니메이션
    private func showButton(_ component: UIButton) {
        UIView.animate(withDuration: 0.6, delay: 0.6, options: .curveEaseOut) {
            component.alpha = 1
        }
    }
    
    private func hideButton(_ component: UIButton) {
        UIView.animate(withDuration: 0.6, delay: 0.6, options: .curveEaseOut) {
            component.alpha = 0
        }
    }
    
    // 과거의 나 텍스트 애니메이션
    private func showPastView(_ component: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0.8, options: .curveEaseOut) {
            component.alpha = 1
        }
    }
    
    private func hidePastView(_ component: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0.8, options: .curveEaseOut) {
            component.alpha = 0
        }
    }
    
    // 현재의 나 텍스트 애니메이션
    private func showPresentView(_ component: UIView) {
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseOut) {
            component.alpha = 1
        }
    }
    
    private func hidePresentView(_ component: UIView) {
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseOut) {
            component.alpha = 0
        }
    }
}
