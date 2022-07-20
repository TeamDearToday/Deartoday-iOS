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
        getTravelInfo(timeTravelId: timeTravelID)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setLabelUI()
    }
    
    private func setCollectionView() {
        setCollectionViewLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = collectionViewFlowLayout
        registerXib()
    }
    
    // MARK: - IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension CheckTimeTravelDetailViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        //hedaer view 높이 73에 line height * line 수 만큼 곱하기
        return (section == 0) ? .zero : CGSize(width: collectionView.frame.width, height: 73)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
}

// MARK: - UICollectionViewDataSource

extension CheckTimeTravelDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? 1 : 13
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PastImageCollectionViewCell.identifier, for: indexPath) as? PastImageCollectionViewCell else { return UICollectionViewCell() }
            cell.setData(image: travelInfo?.image ?? "")
            return cell
        default:
            if indexPath.item == 12 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelAnswerCollectionViewCell.identifier, for: indexPath) as? TravelAnswerCollectionViewCell else { return UICollectionViewCell() }
                return cell
            }
            else if indexPath.item % 2 == 0 {
                //과거 채팅 셀 설정
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PastDialogCollectionViewCell.identifier, for: indexPath) as? PastDialogCollectionViewCell else { return UICollectionViewCell() }
                //set data (채팅에 맞는!)
                return cell
            }
            else {
                //현재 채팅 셀 설정
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PresentDialogCollectionViewCell.identifier, for: indexPath) as? PresentDialogCollectionViewCell else { return UICollectionViewCell() }
                //set data (채팅에 맞는!)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: TravelInfoCollectionReusableView.identifier,
                                                  for: indexPath) as? TravelInfoCollectionReusableView else { return UICollectionReusableView() }
            headerView.titleLabel?.text = travelInfo?.title ?? ""
            headerView.pastDateLabel?.text = "\(travelInfo?.year ?? 0).\(travelInfo?.month ?? 0).\(travelInfo?.day ?? 0)"
            headerView.writtenDateLabel?.text = travelInfo?.writtenDate ?? ""
            return headerView
        default: assert(false, "not section header")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CheckTimeTravelDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width,
                          height: collectionView.frame.width * ( 191 / 343 ))
        default:
            return CGSize(width: collectionView.frame.width, height: 100)
        }
    }
}

// MARK: - Network

extension CheckTimeTravelDetailViewController {
    func getTravelInfo(timeTravelId: String) {
        CheckTimeTravelAPI.shared.getTimeTravelDetail(timeTravelId: timeTravelId) { response in
            guard let info = response?.data else { return }
            self.travelInfo = info
            self.dialogs = info.messages
            self.collectionView.reloadData()
        }
    }
}
