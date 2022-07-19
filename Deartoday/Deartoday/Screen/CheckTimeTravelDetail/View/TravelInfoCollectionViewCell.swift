//
//  TravelInfoCollectionViewCell.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/19.
//

import UIKit

final class TravelInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TravelInfoCollectionViewCell"

    // MARK: - UI Property
    
    @IBOutlet weak var travelDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writtenDateLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    // MARK: - Custom Method
    
    private func setUI() {
        travelDateLabel.font = .h0
        titleLabel.font = .h2
        writtenDateLabel.font = .caption0
    }
    
    func setData(written: String, to: String, title: String) {
        titleLabel.text = title
        writtenDateLabel.text = written
        travelDateLabel.text = to
    }
}
