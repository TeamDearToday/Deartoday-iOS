//
//  CheckMessageViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/12.
//

import UIKit

enum MessageSection {
    case message
}

final class CheckMessageViewController: UIViewController {
    
    // MARK: - Property
    
    var dataSource: UICollectionViewDiffableDataSource<MessageSection, MessageDataModel>!
    var snapshot: NSDiffableDataSourceSnapshot<MessageSection, MessageDataModel>!
    var messages: [MessageDataModel] = []
    
    // MARK: - UI Property
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyDescriptionLabel: UILabel!
    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var timeTravelImageView: UIImageView!
    @IBOutlet weak var rewindImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionView()
        setGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMessageInfo()
    }
    
    // MARK: - @objc
    
    @objc private func timeTravelButtonDidTap() {
        let timeTravel = TimeTravelViewController()
        timeTravel.modalTransitionStyle = .crossDissolve
        timeTravel.modalPresentationStyle = .overFullScreen
        present(timeTravel, animated: true) {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setHeaderViewUI()
        setEmptyViewUI()
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        registerXib()
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
    }
    
    private func registerXib() {
        let nib = UINib(nibName: MessageCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MessageCollectionViewCell.identifier)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(((getDeviceWidth()-55)/2)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(15)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<MessageSection, MessageDataModel>(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, identifier: MessageDataModel) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCollectionViewCell.identifier, for: indexPath) as? MessageCollectionViewCell else { return UICollectionViewCell() }
            cell.setData(content: self.messages[indexPath.item].message)
            return cell
        })
    }
    
    private func updateSnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<MessageSection, MessageDataModel>()
        snapshot.appendSections([.message])
        snapshot.appendItems(messages, toSection: .message)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    private func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(timeTravelButtonDidTap))
        timeTravelImageView.addGestureRecognizer(tapGesture)
    }
    
    private func updateMessageList() {
        setDataSource()
        updateSnapshot()
    }
    
    private func setMessageInfo(response: [String]) {
        setMessageArray(response: response)
        updateMessageList()
        let isEmpty = (messages.count == 0)
        emptyView.isHidden = !isEmpty
        collectionView.isHidden = isEmpty
    }
    
    private func setMessageArray(response: [String]) {
        messages.removeAll()
        response.forEach {
            messages.append(MessageDataModel(message: $0, uuid: UUID()))
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension CheckMessageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let messageDetail = UIStoryboard(name: Constant.Storyboard.CheckMessageDetail, bundle: nil)
            .instantiateViewController(withIdentifier: Constant.ViewController.CheckMessageDetail) as? CheckMessageDetailViewController else { return }
        messageDetail.modalPresentationStyle = .overFullScreen
        messageDetail.content = messages[indexPath.item].message
        present(messageDetail, animated: false, completion: nil)
    }
}

// MARK: - Network

extension CheckMessageViewController {
    private func getMessageInfo() {
        CheckMessageAPI.shared.getCheckMessage { response in
            guard let responseData = response else { return }
            self.setMessageInfo(response: responseData.data?.lastAnswer ?? [])
        }
    }
}

// MARK: - Component UI Setting functions

extension CheckMessageViewController {
    private func setHeaderViewUI() {
        titleLabel.font = .h1
        titleLabel.textColor = .darkGray01
        titleLabel.setPartialLabelColor(targetStringList: ["메시지"], color: .blue02)
        descriptionLabel.font = .caption2
        descriptionLabel.textColor = .gray00
    }
    
    private func setEmptyViewUI() {
        emptyDescriptionLabel.font = .caption2
        emptyDescriptionLabel.textColor = .gray01
        emptyTitleLabel.font = .btn0
        emptyTitleLabel.textColor = .blue02
        rewindImageView.tintColor = .blue02
    }
}
