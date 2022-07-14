//
//  CheckTimeTravelViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/13.
//

import UIKit

enum Section {
    case tape
}

final class CheckTimeTravelViewController: UIViewController {
    
    // MARK: - Property
    
    var dataSource: UITableViewDiffableDataSource<Section, TimeTapeDataModel>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, TimeTapeDataModel>!
    var timeTapes: [TimeTapeDataModel] = []

    // MARK: - UI Property
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyDescriptionLabel: UILabel!
    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var timeTravelImageView: UIImageView!
    @IBOutlet weak var rewindImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        setGesture()
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
    
    private func setTableView() {
        registerXib()
        setTableViewUI()
        setDataSource()
    }
    
    private func registerXib() {
        let nib = UINib(nibName: TimeTapeTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TimeTapeTableViewCell.identifier)
    }
    
    private func setTableViewUI() {
        tableView.estimatedRowHeight = 273
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, TimeTapeDataModel>(tableView: tableView, cellProvider: { (tableView: UITableView, indexPath: IndexPath, identifier: TimeTapeDataModel) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TimeTapeTableViewCell.identifier, for: indexPath) as? TimeTapeTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setData(model: self.timeTapes[indexPath.item])
            return cell
        })
        snapshot = NSDiffableDataSourceSnapshot<Section, TimeTapeDataModel>()
        snapshot.appendSections([.tape])
        snapshot.appendItems(timeTapes, toSection: .tape)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(timeTravelButtonDidTap))
        timeTravelImageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Component UI Setting functions

extension CheckTimeTravelViewController {
    private func setHeaderViewUI() {
        titleLabel.textColor = .darkGray01
        titleLabel.setPartialLabelColor(targetStringList: ["시간 여행"], color: .blue02)
        titleLabel.font = .h1
        descriptionLabel.textColor = .gray00
        descriptionLabel.font = .caption2
    }
    
    private func setEmptyViewUI() {
        emptyDescriptionLabel.font = .caption2
        emptyDescriptionLabel.textColor = .gray01
        emptyTitleLabel.font = .btn0
        emptyTitleLabel.textColor = .blue02
        rewindImageView.tintColor = .blue02
    }
}
