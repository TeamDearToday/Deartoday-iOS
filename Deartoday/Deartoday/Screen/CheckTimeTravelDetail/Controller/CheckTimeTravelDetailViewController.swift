//
//  CheckTimeTravelDetailViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/18.
//

import UIKit

final class CheckTimeTravelDetailViewController: UIViewController {

    // MARK: - Property
    // MARK: - UI Property
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - @objc
    // MARK: - Custom Method
    
    private func setUI() {
        setLabelUI()
    }
    
    private func setLabelUI() {
        titleLabel.font = .btn0
    }
    
    // MARK: - IBAction
}
