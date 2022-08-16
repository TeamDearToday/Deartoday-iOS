//
//  CheckTimeTravelsViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/08/16.
//

import UIKit

import SnapKit
import Then

enum TimeTravelSection {
    case tape
}

final class CheckTimeTravelsViewController: UIViewController {
    
    // MARK: - Property
    
    private var dataSource: UITableViewDiffableDataSource<TimeTravelSection, TimeTapeDataModel>!
    private var snapshot: NSDiffableDataSourceSnapshot<TimeTravelSection, TimeTapeDataModel>!
    private var timeTapes: [TimeTapeDataModel] = []

    // MARK: - UI Property
    
    private let tapesImageView = UIImageView(image: Constant.Image.imgTapeBundle)
    private let emptyImageView = UIImageView(image: Constant.Image.imgTape)
    
    private let headerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let backButton = UIButton().then {
        $0.setImage(Constant.Image.icBack, for: .normal)
        $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .h1
        $0.text = "나의 시간 여행"
        $0.textColor = .darkGray01
        $0.setPartialLabelColor(targetStringList: ["시간 여행"], color: .blue02)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = .caption2
        $0.text = "디어투데이와 함께한 시간 여행을\n확인하고 그날의 행복을 추억해보세요"
        $0.textColor = .gray00
        $0.numberOfLines = 0
    }
    
    private let emptyView = UIView().then {
        $0.isHidden = true
        $0.backgroundColor = .clear
    }
    
    private let emptyDescriptionLabel = UILabel().then {
        $0.font = .caption2
        $0.text = "아직 디어투데이와 함께한 시간 여행이 없어요\n지금 바로 시간 여행을 떠나볼까요?"
        $0.textColor = .gray01
        $0.numberOfLines = 0
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
    
    private lazy var tableView: UITableView = {
        return UITableView(frame: .zero, style: .plain).then {
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.isHidden = true
        }
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setTableView()
        setGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTimeTravelInfo()
    }
    
    // MARK: - @objc
    
    @objc private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func timeTravelComponentDidTap() {
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
    
    private func setTableView() {
        tableView.delegate = self
        registerXib()
        setTableViewUI()
    }
    
    private func setGesture() {
        let timeTravelGesture = UIGestureRecognizer(target: self, action: #selector(timeTravelComponentDidTap))
        timeTravelView.addGestureRecognizer(timeTravelGesture)
    }
    
    private func setDataSource() {
        dataSource = UITableViewDiffableDataSource<TimeTravelSection, TimeTapeDataModel>(tableView: tableView, cellProvider: { (tableView: UITableView, indexPath: IndexPath, identifier: TimeTapeDataModel) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TimeTapeTableViewCell.identifier, for: indexPath) as? TimeTapeTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setData(model: self.timeTapes[indexPath.item])
            return cell
        })
    }
    
    private func updateSnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<TimeTravelSection, TimeTapeDataModel>()
        snapshot.appendSections([.tape])
        snapshot.appendItems(timeTapes, toSection: .tape)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func updateTapeList() {
        setDataSource()
        updateSnapshot()
    }
    
    private func registerXib() {
        let nib = UINib(nibName: TimeTapeTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TimeTapeTableViewCell.identifier)
    }
    
    private func setTableViewUI() {
        tableView.estimatedRowHeight = 273
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setTimeTravelTapeInfo() {
        updateTapeList()
        emptyView.isHidden = !(timeTapes.count == 0)
        tableView.isHidden = (timeTapes.count == 0)
    }
    
    private func setHierarchy() {
        view.addSubviews([headerView, emptyView, tableView])
        headerView.addSubviews([backButton, tapesImageView, titleLabel, descriptionLabel])
        emptyView.addSubviews([emptyImageView, emptyDescriptionLabel, timeTravelButton])
        timeTravelButton.addSubview(timeTravelView)
    }
    
    private func setConstraint() {
        setHeaderViewConstraint()
        setTableViewConstraint()
        setEmptyViewConstraint()
    }
}


// MARK: - UITableViewDelegate

extension CheckTimeTravelsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detail = UIStoryboard(name: Constant.Storyboard.CheckTimeTravelDetail, bundle: nil)
            .instantiateViewController(withIdentifier: Constant.ViewController.CheckTimeTravelDetail) as? CheckTimeTravelDetailViewController else { return }
        detail.timeTravelID = timeTapes[indexPath.item].timeTravelID
        navigationController?.pushViewController(detail, animated: true)
    }
}

// MARK: - Network

extension CheckTimeTravelsViewController {
    private func getTimeTravelInfo() {
        CheckTimeTravelAPI.shared.getCheckTimeTravel { [weak self] tapeData in
            guard let tapeData = tapeData else { return }
            self?.timeTapes = tapeData.data?.timeTravels ?? []
            self?.setTimeTravelTapeInfo()
        }
    }
}

// MARK: - Constraint

extension CheckTimeTravelsViewController {
    private func setHeaderViewConstraint() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(0)
            $0.height.equalTo(167)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(6)
            $0.width.height.equalTo(44)
        }
        
        tapesImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(69)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(14)
            $0.leading.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    private func setTableViewConstraint() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(0)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(0)
        }
    }
    
    private func setEmptyViewConstraint() {
        
    }
}
