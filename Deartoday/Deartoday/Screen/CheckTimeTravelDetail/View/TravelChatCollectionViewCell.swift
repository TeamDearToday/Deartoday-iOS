//
//  TravelChatCollectionViewCell.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/20.
//

import UIKit

final class TravelChatCollectionViewCell: UICollectionViewCell {

    static let identifier = "TravelChatCollectionViewCell"
    
    // MARK: - Property
    // MARK: - UI Property
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionImageViewHeightConstraint: UIImageView!
    @IBOutlet weak var answerImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var answerImageViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    // MARK: - Custom Method
    
    private func setUI() {
        questionLabel.font = .caption2
        answerLabel.font = .caption2
    }
    
    private func updateUI() {
        //past imageview width는 라벨 width에 60을 더함
        //past imageview height는 라벨 height에 28을 더함
        
        //answer imageview width는 라벨 width에 32을 더함
        //answer imageview height는 라벨 height에 28을 더함
    }

    func setData(question: String, answer: String) {
        questionLabel.text = question
        answerLabel.text = answer
        updateUI()
    }
}
