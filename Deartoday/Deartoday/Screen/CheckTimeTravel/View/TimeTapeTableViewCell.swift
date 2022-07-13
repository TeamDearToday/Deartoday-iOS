//
//  TimeTapeTableViewCell.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/13.
//

import UIKit

final class TimeTapeTableViewCell: UITableViewCell {
    
    // MARK: - UI Property
    
    @IBOutlet weak var pastImageView: UIImageView!
    @IBOutlet weak var rewindImageView: UIImageView!
    @IBOutlet weak var travelToLabel: UILabel!
    @IBOutlet weak var travelFromLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setLabelUI()
        setImageViewUI()
    }
    
    private func setLabelUI() {
        travelToLabel.font = .h0
        travelToLabel.textColor = .blue02
        travelFromLabel.font = .caption0
        travelFromLabel.textColor = .gray01
        titleLabel.font = .p2
        titleLabel.textColor = .gray00
    }
    
    private func setImageViewUI() {
        rewindImageView.tintColor = .gray01
        pastImageView.layer.cornerRadius = 8
    }
    
    func setData(index: Int) {
        titleLabel.text = "\(index)"
    }
}
