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
    
    let sectionTitles = [["사운드", "푸시알림"],
                         ["서비스 이용약관", "문의하기", "오픈소스 라이선스", "Team 디어투데이"]]
    
    // MARK: - UI Property
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.sectionHeaderHeight = 42
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return tableView
    }()
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var backButton = UIButton().then {
        $0.setImage(Constant.Image.icBack, for: .normal)
        $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var logoutButton = UIButton().then {
        $0.titleLabel?.font = .p4
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(.blue01, for: .normal)
        $0.setUnderline()
        $0.addTarget(self, action: #selector(logoutButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var withDrawButton = UIButton().then {
        $0.titleLabel?.font = .p4
        $0.setTitle("서비스 탈퇴", for: .normal)
        $0.setTitleColor(.blue01, for: .normal)
        $0.setUnderline()
        $0.addTarget(self, action: #selector(withDrawButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setTableView()
    }
    
    // MARK: - @objc
    
    @objc func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func logoutButtonDidTap() {}
    
    @objc func withDrawButtonDidTap() {}
    
    // MARK: - Custom Method
    
    private func setLayout() {
        setHierarchy()
        setConstraint()
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setHierarchy() {
        view.addSubviews([backgroundView, navigationView,
                          backButton, tableView,
                          logoutButton, withDrawButton])
    }
    
    private func setConstraint() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(72)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(6)
            $0.centerY.equalTo(navigationView)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).inset(0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(454)
        }
        
        withDrawButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(constraintByNotch(73, 40))
            $0.width.equalTo(69)
            $0.height.equalTo(18)
        }
        
        logoutButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(withDrawButton.snp.top).offset(-22)
            $0.width.equalTo(52)
            $0.height.equalTo(20)
        }
    }
}

    // MARK: - UITableView DataSource

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = sectionTitles[indexPath.section][indexPath.row]
        cell.switchButton.isHidden = (indexPath.section == 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionTitles[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel().then {
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
        return UIView()
    }
}
    // MARK: - UITableView Delegate

extension SettingViewController: UITableViewDelegate { }
