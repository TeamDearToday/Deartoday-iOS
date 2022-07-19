//
//  CheckTimeTravelViewController.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/13.
//

import UIKit

enum TimeTravelSection {
    case tape
}

final class CheckTimeTravelViewController: UIViewController {
    
    // MARK: - Property
    
    var dataSource: UITableViewDiffableDataSource<TimeTravelSection, TimeTapeDataModel>!
    var snapshot: NSDiffableDataSourceSnapshot<TimeTravelSection, TimeTapeDataModel>!
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
        setGesture()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTimeTravelInfo()
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
        tableView.delegate = self
        registerXib()
        setTableViewUI()
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
    
    private func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(timeTravelButtonDidTap))
        timeTravelImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setTimeTravelTapeInfo() {
        updateTapeList()
        let isEmpty = (timeTapes.count == 0)
        emptyView.isHidden = !isEmpty
        tableView.isHidden = isEmpty
    }
    
    // MARK: - IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate

extension CheckTimeTravelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let detail = UIStoryboard(name: Constant.Storyboard.CheckTimeTravelDetail, bundle: nil)
//            .instantiateViewController(withIdentifier: Constant.ViewController.CheckTimeTravelDetail) as? CheckTimeTravelDetailViewController else { return }
//        detail.timeTravelID = timeTapes[indexPath.item].timeTravelID
//        navigationController?.pushViewController(detail, animated: true)
    }
}

// MARK: - Network

extension CheckTimeTravelViewController {
    private func getTimeTravelInfo() {
        CheckTimeTravelAPI.shared.getCheckTimeTravel { response in
            guard let responseData = response else { return }
            self.timeTapes = responseData.data?.timeTravels ?? []
            self.setTimeTravelTapeInfo()
        }
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
