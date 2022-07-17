//
//  TimeTapeTableViewCell.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/13.
//

import UIKit

import Kingfisher

final class TimeTapeTableViewCell: UITableViewCell {
    
    static let identifier = "TimeTapeTableViewCell"
    
    // MARK: - UI Property
    
    @IBOutlet weak var pastImageView: UIImageView!
    @IBOutlet weak var rewindImageView: UIImageView!
    @IBOutlet weak var travelToLabel: UILabel!
    @IBOutlet weak var travelFromLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet var imageViewConstraintCollection: [NSLayoutConstraint]!
    
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
        setViewUI()
        setLayout()
    }
    
    private func setLabelUI() {
        travelToLabel.font = .h0
        travelToLabel.textColor = .blue02
        travelFromLabel.font = .caption0
        travelFromLabel.textColor = .gray01
        titleLabel.font = .p2
        titleLabel.textColor = .gray00
    }
    
    private func setViewUI() {
        rewindImageView.tintColor = .gray01
        pastImageView.layer.cornerRadius = 8
        separatorView.backgroundColor = .lightBlue01
    }
    
    private func setLayout() {
        imageViewConstraintCollection.forEach {
            $0.constant = $0.constant * ( UIScreen.main.bounds.width / 375 )
        }
    }
    
    func setData(model: TimeTapeDataModel) {
        pastImageView.kf.setImage(with: URL(string: model.image))
        travelFromLabel.text = model.writtenDate
        travelToLabel.text = "\(model.year).\(model.month).\(model.day)"
        titleLabel.text = model.title
    }
}
