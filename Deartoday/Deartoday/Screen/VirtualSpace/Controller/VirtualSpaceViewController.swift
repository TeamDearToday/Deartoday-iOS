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
        $0.image = Constant.Image.imgHomePastLeft
    }
    
    private var yearBackView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Constant.Image.bgYearYellow
    }
    
    private var yearLabel = UILabel().then {
        $0.text = "0000"
    }
    
    private var monthBackView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Constant.Image.bgMonthYellow
    }
    
    private var monthLabel = UILabel().then {
        $0.text = "00"
    }
    
    private var dayBackView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Constant.Image.bgMonthYellow
    }
    
    private var dayLabel = UILabel().then {
        $0.text = "00"
    }
    
    private var exitButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(Constant.Image.icExit, for: .normal)
        $0.setImage(Constant.Image.icExit, for: .highlighted)
        $0.tintColor = .yellow02
    }
    
    private var textBoxImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Constant.Image.imgTextBoxShadow
    }
    
    private var textBoxLabel = UILabel().then {
        $0.text = "우리의 0000년, 기억나나요?"
        $0.textColor = .gray00
        $0.font = .btn0
    }
    
    private lazy var mediaCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = true
            $0.alpha = 0
            $0.showsHorizontalScrollIndicator = false
        }
    }()
    
    private lazy var nextButton = DDSButton().then {
        $0.style = .past
        $0.text = "과거의 나 만나러 가기"
        $0.hasLeftIcon = false
        $0.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setCollectionView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseOut) {
                self.mediaCollectionView.alpha = 1
            }
        }
    }
    
    // MARK: - @objc
    
    @objc func exitButtonDidTap() {
        
    }
    
    @objc func nextButtonDidTap() {
        UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseOut) {
            self.mediaCollectionView.alpha = 0
            self.nextButton.alpha = 0
        }
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        view.backgroundColor = .white
        
        [yearLabel, monthLabel, dayLabel].forEach {
            $0.textColor = .gray00
            $0.font = .h0
        }
    }
    
    private func setLayout() {
        view.addSubviews([backgroundImageView,
                          yearBackView,
                          monthBackView,
                          dayBackView,
                          textBoxImageView,
                          mediaCollectionView,
                          nextButton])
        
        yearBackView.addSubview(yearLabel)
        monthBackView.addSubview(monthLabel)
        dayBackView.addSubview(dayLabel)
        
        textBoxImageView.addSubview(textBoxLabel)
        
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        yearBackView.snp.makeConstraints {
            $0.width.equalTo(114)
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(6)
        }
        
        monthBackView.snp.makeConstraints {
            $0.width.equalTo(73)
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(106)
        }
        
        dayBackView.snp.makeConstraints {
            $0.width.equalTo(73)
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(165)
        }
        
        [yearLabel , monthLabel, dayLabel].forEach {
            $0.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
        }
        
        textBoxImageView.snp.makeConstraints {
            $0.width.equalTo(244)
            $0.height.equalTo(67)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(58)
            $0.leading.equalToSuperview().inset(6)
        }
        
        textBoxLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        mediaCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(174)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(161)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(6)
            $0.height.equalTo(68)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
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

// MARK: - UICollectionView DataSource

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
