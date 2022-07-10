//
//  UIViewController+.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/10.
//

import UIKit

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
}
