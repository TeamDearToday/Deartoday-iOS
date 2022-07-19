//
//  CheckTimeTravelDetailViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/19.
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
        setCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setLabelUI()
    }
    
    private func setLabelUI() {
        titleLabel.font = .btn0
    }
    
    private func setCollectionView() {
        registerXib()
    }
    
    private func registerXib() {
        let pastImageXib = UINib(nibName: PastImageCollectionViewCell.identifier, bundle: nil)
        let infoXib = UINib(nibName: TravelInfoCollectionViewCell.identifier, bundle: nil)
        let chatXib = UINib(nibName: TravelChatCollectionViewCell.identifier, bundle: nil)
        let answerXib = UINib(nibName: TravelAnswerCollectionViewCell.identifier, bundle: nil)
        collectionView.register(pastImageXib,
                                forCellWithReuseIdentifier: PastImageCollectionViewCell.identifier)
        collectionView.register(infoXib,
                                forCellWithReuseIdentifier: TravelInfoCollectionViewCell.identifier)
        collectionView.register(chatXib,
                                forCellWithReuseIdentifier: TravelChatCollectionViewCell.identifier)
        collectionView.register(answerXib,
                                forCellWithReuseIdentifier: TravelAnswerCollectionViewCell.identifier)
    }
    
    // MARK: - IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
