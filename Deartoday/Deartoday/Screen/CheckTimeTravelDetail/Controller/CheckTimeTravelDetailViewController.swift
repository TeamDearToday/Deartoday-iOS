//
//  CheckTimeTravelDetailViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/19.
//

import UIKit

final class CheckTimeTravelDetailViewController: UIViewController {

    // MARK: - Property

    internal var timeTravelID: String = ""
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    private var travelInfo: CheckTimeTravelDetailResponse?
    private var dialogs: [Message] = []
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = collectionViewFlowLayout
        registerXib()
        setCollectionViewLayout()
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
    
    private func setCollectionViewLayout() {
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionHeadersPinToVisibleBounds = true
    }
    
    // MARK: - IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension CheckTimeTravelDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        //todo : 높이 계산해서 넣기(지금 150은 허상임)
        return (section == 0) ? .zero : CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
}

// MARK: - UICollectionViewDataSource

extension CheckTimeTravelDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? 1 : 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PastImageCollectionViewCell.identifier, for: indexPath) as? PastImageCollectionViewCell else { return UICollectionViewCell() }
            //set data
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelInfoCollectionViewCell.identifier, for: indexPath) as? TravelInfoCollectionViewCell else { return UICollectionViewCell() }
            //set data
            return cell
        case 8:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelAnswerCollectionViewCell.identifier, for: indexPath) as? TravelAnswerCollectionViewCell else { return UICollectionViewCell() }
            //set data (마지막 말)
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelChatCollectionViewCell.identifier, for: indexPath) as? TravelChatCollectionViewCell else { return UICollectionViewCell() }
            //set data (채팅에 맞는!)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CheckTimeTravelDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

// MARK: - Network

extension CheckTimeTravelDetailViewController {
    func getTravelInfo(timeTravelId: String) {
        CheckTimeTravelAPI.shared.getTimeTravelDetail(timeTravelId: timeTravelId) { response in
            guard let info = response?.data else { return }
            self.travelInfo = info
            self.dialogs = info.messages
        }
    }
}
