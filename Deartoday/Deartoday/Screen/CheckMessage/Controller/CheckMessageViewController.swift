//
//  CheckMessageViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/08/11.
//

import UIKit

import SnapKit
import Then

enum MessageSection {
    case message
}

final class CheckMessageViewController: UIViewController {
    
    // MARK: - Property
    
    private var dataSource: UICollectionViewDiffableDataSource<MessageSection, MessageDataModel>!
    private var snapshot: NSDiffableDataSourceSnapshot<MessageSection, MessageDataModel>!
    private var messages: [MessageDataModel] = []
    
    // MARK: - UI Property
    
    private let navigationView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let backButton = UIButton().then {
        $0.setImage(Constant.Image.icBack, for: .normal)
        $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    private let messageImageView = UIImageView().then {
        $0.image = Constant.Image.imgMemoBundle
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "나의 메시지"
        $0.font = .h1
        $0.textColor = .darkGray01
        $0.setPartialLabelColor(targetStringList: ["메시지"], color: .blue02)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "미래의 나로부터 도착한 메시지를 확인해보세요"
        $0.font = .caption2
        $0.textColor = .gray00
    }
    
    private let emptyView = UIView().then {
        $0.isHidden = true
        $0.backgroundColor = .clear
    }
    
    private let emptyMessageImageView = UIImageView().then {
        $0.image = Constant.Image.imgMemoempty
    }
    
    private let emptyDescriptionLabel = UILabel().then {
        $0.text = "아직 나에게 도착한 메시지가 없어요!\n지금 바로 시간 여행을 떠나볼까요?"
        $0.numberOfLines = 0
        $0.font = .caption2
        $0.textColor = .gray01
        $0.setTextWithLineHeight(text: $0.text, lineHeight: 22)
    }
    
    private let timeTravelButton = DDSButton().then {
        $0.text = "시간 여행 떠나기"
        $0.hasLeftIcon = true
        $0.style = .present
    }
    
    private let timeTravelView = UIView().then {
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.isHidden = true
        }
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setGesture()
        setCollectionView()
        getMessageInfo()
    }
    
    // MARK: - @objc
    
    @objc private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func timeTravelButtonDidTap() {
        let timeTravel = TimeTravelViewController()
        timeTravel.modalTransitionStyle = .crossDissolve
        timeTravel.modalPresentationStyle = .fullScreen
        present(timeTravel, animated: true) {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        setHierarchy()
        setConstraint()
    }
    
    private func setHierarchy() {
        view.addSubviews([navigationView, emptyView, collectionView])
        navigationView.addSubviews([backButton, messageImageView,
                                   titleLabel, descriptionLabel])
        emptyView.addSubviews([emptyMessageImageView, emptyDescriptionLabel, timeTravelButton])
        timeTravelButton.addSubview(timeTravelView)
    }
    
    private func setConstraint() {
        setNavigationBarConstraint()
        setEmptyViewContraint()
        setCollectionViewConstraint()
    }
    
    private func setGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(timeTravelButtonDidTap))
        timeTravelView.addGestureRecognizer(gesture)
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: MessageCollectionViewCell.identifier)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
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
    
    private func updateMessageList() {
        setDataSource()
        updateSnapshot()
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
    
    private func setMessageInfo(response: [String]) {
        setMessageArray(response: response)
        updateMessageList()
        emptyView.isHidden = !(messages.count == 0)
        collectionView.isHidden = (messages.count == 0)
    }
    
    private func setMessageArray(response: [String]) {
        messages.removeAll()
        response.forEach {
            messages.append(MessageDataModel(message: $0, uuid: UUID()))
        }
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
        CheckMessageAPI.shared.getCheckMessage { [weak self] messageData in
            guard let messageData = messageData else { return }
            self?.setMessageInfo(response: messageData.data?.lastAnswer ?? [])
        }
    }
}

// MARK: - Constraints

extension CheckMessageViewController {
    private func setNavigationBarConstraint() {
        navigationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(0)
            make.height.equalTo(161)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(6)
            make.width.height.equalTo(44)
        }
        
        messageImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(2)
            make.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(72)
            make.leading.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
    private func setEmptyViewContraint() {
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(0)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(0)
        }
        
        emptyMessageImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(constraintByNotch(83, 50))
            make.centerX.equalToSuperview()
        }
        
        emptyDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyMessageImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        timeTravelButton.snp.makeConstraints { make in
            make.top.equalTo(emptyDescriptionLabel.snp.bottom).offset(12)
            make.width.equalTo(190)
            make.height.equalTo(68)
            make.centerX.equalToSuperview()
        }
        
        timeTravelView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setCollectionViewConstraint() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(0)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(0)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
