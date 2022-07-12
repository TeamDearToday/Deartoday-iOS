//
//  TimeTravelVirtualSpaceViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/12.
//

import UIKit

import SnapKit
import Then

final class VirtualSpaceViewController: UIViewController {
    
    // MARK: - Property
    
    internal var year: String = "0000" {
        didSet {
            yearLabel.text = "\(year)"
            textBoxLabel.text = "우리의 \(year)년, 기억하시나요?"
        }
    }
    
    internal var month: String = "00" {
        didSet {
            monthLabel.text = "\(month)"
        }
    }
    
    internal var day: String = "00" {
        didSet {
            dayLabel.text = "\(day)"
        }
    }
    
    // MARK: - UI Property
    
    private var backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private var yearBackView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private var yearLabel = UILabel().then {
        $0.text = ""
    }
    
    private var monthBackView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private var monthLabel = UILabel().then {
        $0.text = ""
    }
    
    private var dayBackView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private var dayLabel = UILabel().then {
        $0.text = ""
    }
    
    private var exitButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(Constant.Image.icExit, for: .normal)
        $0.setImage(Constant.Image.icExit, for: .highlighted)
        $0.tintColor = .yellow02
    }
    
    private var textBoxImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var textBoxLabel = UILabel().then {
        $0.textColor = .gray00
        $0.font = .btn1En
    }
    
    private var mediaCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = true
        }
    }()
    
    private lazy var returnButton = DDSButton().then {
        $0.style = .past
        $0.text = "과거의 나 만나러 가기"
        $0.hasLeftIcon = true
        $0.addTarget(self, action: #selector(returnButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setCollectionView()
    }
    
    // MARK: - @objc
    
    @objc func exitButtonDidTap() {
        
    }
    
    @objc func returnButtonDidTap() {
        
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews([backgroundImageView, mediaCollectionView])
        
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        mediaCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(174)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(161)
        }
    }
    
    private func setCollectionView() {
        mediaCollectionView.register(VirtualSpaceCollectionViewCell.self,
                                     forCellWithReuseIdentifier: VirtualSpaceCollectionViewCell.cellIdentifier)
        
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
    }
}

// MARK: - UICollectionView Delegate

extension VirtualSpaceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = CGFloat(313)
        let cellHeight = collectionView.frame.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension VirtualSpaceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return VirtualSpaceDataModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VirtualSpaceCollectionViewCell.cellIdentifier, for: indexPath) as? VirtualSpaceCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(VirtualSpaceDataModel.images[indexPath.item])
        return cell
    }
}
