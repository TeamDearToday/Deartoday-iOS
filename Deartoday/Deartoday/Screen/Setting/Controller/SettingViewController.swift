//
//  SettingViewController.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/21.
//

import UIKit

import SnapKit
import Then

final class SettingViewController: UIViewController {
    
    // MARK: - Property
    let firstSectionLabel = ["사운드", "푸시알림"]
    let secondSectionLabel = ["서비스 이용약관", "문의하기", "오픈소스 라이선스", "Team 디어투데이"]
    
    // MARK: - UI Property
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.sectionHeaderHeight = 42
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var backGroundView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var navibarView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var backButton = UIButton().then {
        $0.setImage(Constant.Image.icBack, for: .normal)
        $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - @objc
    
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func logoutLabelDidTap() {
    }
    
    @objc func serviceWithDrawDidTap() {
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setTableView()
        setHierarchy()
        setLayout()
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setHierarchy() {
        view.addSubviews([backGroundView, navibarView,
                          backButton, tableView])
    }
    
    private func setLayout() {
        backGroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navibarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(72)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(6)
            $0.centerY.equalTo(navibarView)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(navibarView.snp.bottom).inset(0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(454)
        }
    }
}

// MAKR: UITableViewDataSource, Delegate

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
            cell.setLabelData(firstSectionLabel[indexPath.row])
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
            cell.setLabelData(secondSectionLabel[indexPath.row])
            cell.switchButton.isHidden = true
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        lazy var headerView = UIView()
        lazy var headerLabel = UILabel().then {
            $0.font = .p4
            $0.textColor = .blue02
            $0.textAlignment = .left
            $0.text = section == 0 ? "설정" : "디어투데이 정보"
        }
        
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalTo(headerView)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 10 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        lazy var footerView = UIView()
        return section == 0 ? footerView : nil
    }
}
