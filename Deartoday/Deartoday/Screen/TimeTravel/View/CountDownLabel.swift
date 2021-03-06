//
//  CountScrollLabel.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/12.
//

import UIKit

final class CountDownLabel: UILabel {
    private var scrollLayers: [CAScrollLayer] = []
    private var labels: [UILabel] = []
    private var duration: TimeInterval = 0
    private var originText: String = ""
    
    func config(num: String, duration: TimeInterval) {
        originText = num
        self.duration = duration
        setupLabel(numString: num)
    }
    
    private func setupLabel(numString: String) {
        let numArr = numString.map { String($0) }
        var x: CGFloat = 0
        let y: CGFloat = 0
        
        numArr.forEach {
            let label = UILabel()
            label.frame.origin = CGPoint(x: x, y: y)
            label.text = "0"
            label.font = .h0
            label.textColor = .lightBlue00
            label.textAlignment = .center
            label.sizeToFit()
            createScrollLayer(label: label, num: Int($0)!)
            x += label.bounds.width
        }
    }
    
    private func createScrollLayer(label: UILabel, num: Int) {
        let scrollLayer = CAScrollLayer()
        scrollLayer.frame = label.frame
        scrollLayers.append(scrollLayer)
        self.layer.addSublayer(scrollLayer)
        
        makeScrollContent(num: num, scrollLayer: scrollLayer)
    }
    
    private func makeScrollContent(num: Int, scrollLayer: CAScrollLayer) {
        var numSet: [Int] = []
        
        for i in num...num+10 {
            let contentNum = i > 9 ? i % 10 : i
            numSet.append(contentNum)
        }
        
        var height: CGFloat = 0
        for i in numSet {
            let label = UILabel()
            label.text = "\(i)"
            label.font = .h0
            label.textColor = .lightBlue00
            label.frame = .init(x: 0, y: height, width: scrollLayer.frame.width, height: scrollLayer.frame.height)
            label.sizeToFit()
            scrollLayer.addSublayer(label.layer)
            labels.append(label)
            height = label.frame.maxY
        }
    }
    
    func animate(ascending: Bool) {
        var offset: TimeInterval = 0.0
        for scrollLayer in scrollLayers {
            let maxY = scrollLayer.sublayers?.last?.frame.origin.y ?? 0
            let animation = CABasicAnimation(keyPath: "sublayerTransform.translation.y")
            animation.duration = duration + offset
            animation.timingFunction = .init(name: .easeOut)
            
            if ascending {
                animation.toValue = 0
                animation.fromValue = maxY
            } else {
                animation.toValue = maxY
                animation.fromValue = 0
            }
            
            scrollLayer.scrollMode = .vertically
            scrollLayer.add(animation, forKey: nil)
            scrollLayer.scroll(to: CGPoint(x: 0, y: maxY))
            
            offset += 0.4
        }
    }
}

