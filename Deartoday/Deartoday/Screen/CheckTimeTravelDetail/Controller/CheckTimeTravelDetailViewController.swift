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
        setCollectionView()
    }
    
    // MARK: - @objc
    // MARK: - Custom Method
    
    private func setUI() {
        setLabelUI()
    }
    
    private func setLabelUI() {
        titleLabel.font = .btn0
    }

    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        registerXib()
    }
    
    private func registerXib() {
        let imageXib = UINib(nibName: PastImageCollectionViewCell.identifier, bundle: nil)
        collectionView.register(imageXib,
                                forCellWithReuseIdentifier: PastImageCollectionViewCell.identifier)
        let chatXib = UINib(nibName: TimeTravelChatCollectionViewCell.identifier, bundle: nil)
        collectionView.register(chatXib,
                                forCellWithReuseIdentifier: TimeTravelChatCollectionViewCell.identifier)
        let lastXib = UINib(nibName: TimeTravelLastAnswerCollectionViewCell.identifier, bundle: nil)
        collectionView.register(lastXib,
                                forCellWithReuseIdentifier: TimeTravelLastAnswerCollectionViewCell.identifier)
    }
}

// MARK: - UICollectionViewDelegate

extension CheckTimeTravelDetailViewController: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDataSource

extension CheckTimeTravelDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PastImageCollectionViewCell.identifier, for: indexPath) as? PastImageCollectionViewCell else { return UICollectionViewCell() }
            //image data string 넣기
            cell.setData(image: "")
            return cell
        }
        else {
            if indexPath.item == 6 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeTravelLastAnswerCollectionViewCell.identifier, for: indexPath) as? TimeTravelLastAnswerCollectionViewCell else { return UICollectionViewCell() }
                //last answer data setting 넣기
                return UICollectionViewCell()
            }
            else {
                //대화 셀
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeTravelChatCollectionViewCell.identifier, for: indexPath) as? TimeTravelChatCollectionViewCell else { return UICollectionViewCell() }
                //chat 관련 data setting 넣기
                return UICollectionViewCell()
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? 1 : 7
    }
}
