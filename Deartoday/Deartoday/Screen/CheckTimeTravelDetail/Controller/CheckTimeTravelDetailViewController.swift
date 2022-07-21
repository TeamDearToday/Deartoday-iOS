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
        //hedaer view 높이 73에 line height * line 수 만큼 곱하기 + 4
        let knds = travelInfo?.title.getEstimatedFrame(with: .h2)
        var lineheight = ((knds?.width ?? 0) / collectionView.frame.width) * 26
        if (knds?.width ?? 0).truncatingRemainder(dividingBy: collectionView.frame.width) != 0 {
            lineheight += 26
        }
        return (section == 0) ? .zero : CGSize(width: collectionView.frame.width, height: 58 + lineheight)
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
                cell.setData(answer: dialogs.count == 0 ? "" : "\(dialogs[6].answer)")
                return cell
            }
            else if indexPath.item % 2 == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PastDialogCollectionViewCell.identifier, for: indexPath) as? PastDialogCollectionViewCell else { return UICollectionViewCell() }
                cell.setData(content: dialogs.count == 0 ? "" : dialogs[indexPath.item/2].question)
                return cell
            }
            else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PresentDialogCollectionViewCell.identifier, for: indexPath) as? PresentDialogCollectionViewCell else { return UICollectionViewCell() }
                cell.setData(content: dialogs.count == 0 ? "" : dialogs[indexPath.item/2].answer)
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
        return UIEdgeInsets(top: 0, left: 0, bottom: (section == 0 ? 20 : 0), right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        switch indexPath.section {
        case 0:
            height = collectionView.frame.width * ( 191 / 343 )
        case 1:
            if indexPath.item == 12 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelAnswerCollectionViewCell.identifier, for: indexPath) as? TravelAnswerCollectionViewCell else { return .zero }
                if !dialogs.isEmpty { cell.contentLabel.text = dialogs[6].answer }
                cell.contentLabel.sizeToFit()
                height = cell.contentLabel.frame.height + 28 + 63
            }
            else if indexPath.item % 2 == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PastDialogCollectionViewCell.identifier, for: indexPath) as? PastDialogCollectionViewCell else { return .zero }
                if !dialogs.isEmpty { cell.contentLabel.text = "\(dialogs[indexPath.item / 2].question)" }
                cell.contentLabel.sizeToFit()
                height = cell.contentLabel.frame.height + 28
            }
            else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PresentDialogCollectionViewCell.identifier, for: indexPath) as? PresentDialogCollectionViewCell else { return .zero }
                if !dialogs.isEmpty { cell.contentLabel.text = dialogs[indexPath.item / 2].answer }
                cell.contentLabel.sizeToFit()
                height = cell.contentLabel.frame.height + 43
            }
        default:
            return .zero
            
        }
        return CGSize(width: collectionView.frame.width, height: height)
    }
}

// MARK: - Network

extension CheckTimeTravelDetailViewController {
    func getTravelInfo(timeTravelId: String) {
        CheckTimeTravelAPI.shared.getTimeTravelDetail(timeTravelId: timeTravelId) { response in
            guard let info = response?.data as? CheckTimeTravelDetailResponse else { return }
            self.travelInfo = info
            self.dialogs = info.messages
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UI setting functions

extension CheckTimeTravelDetailViewController {
    private func setLabelUI() {
        titleLabel.font = .btn0
    }
    
    private func registerXib() {
        let pastImageXib = UINib(nibName: PastImageCollectionViewCell.identifier, bundle: nil)
        let infoXib = UINib(nibName: TravelInfoCollectionViewCell.identifier, bundle: nil)
        let chatXib = UINib(nibName: TravelChatCollectionViewCell.identifier, bundle: nil)
        let answerXib = UINib(nibName: TravelAnswerCollectionViewCell.identifier, bundle: nil)
        let pastXib = UINib(nibName: PastDialogCollectionViewCell.identifier, bundle: nil)
        let presentXib = UINib(nibName: PresentDialogCollectionViewCell.identifier, bundle: nil)
        let sectionXib = UINib(nibName: TravelInfoCollectionReusableView.identifier, bundle: nil)
        collectionView.register(sectionXib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TravelInfoCollectionReusableView.identifier)
        collectionView.register(pastImageXib,
                                forCellWithReuseIdentifier: PastImageCollectionViewCell.identifier)
        collectionView.register(infoXib,
                                forCellWithReuseIdentifier: TravelInfoCollectionViewCell.identifier)
        collectionView.register(chatXib,
                                forCellWithReuseIdentifier: TravelChatCollectionViewCell.identifier)
        collectionView.register(answerXib,
                                forCellWithReuseIdentifier: TravelAnswerCollectionViewCell.identifier)
        collectionView.register(pastXib,
                                forCellWithReuseIdentifier: PastDialogCollectionViewCell.identifier)
        collectionView.register(presentXib,
                                forCellWithReuseIdentifier: PresentDialogCollectionViewCell.identifier)
    }
    
    private func setCollectionViewLayout() {
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionHeadersPinToVisibleBounds = true
    }
}




extension String {
    func getEstimatedFrame(with font: UIFont) -> CGRect {
        let size = CGSize(width: UIScreen.main.bounds.width * 2/3, height: 1000)
        let optionss = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: self).boundingRect(with: size, options: optionss, attributes: [.font: font], context: nil)
        return estimatedFrame
    }
}
