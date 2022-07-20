//
//  TravelInfoCollectionReusableView.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/20.
//

import UIKit

final class TravelInfoCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "TravelInfoCollectionReusableView"
    
    // MARK: - UI Property
    
    @IBOutlet weak var pastDateLabel: UILabel!
    @IBOutlet weak var writtenDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        pastDateLabel.font = .h0
        writtenDateLabel.font = .caption0
        titleLabel.font = .h2
    }
}
