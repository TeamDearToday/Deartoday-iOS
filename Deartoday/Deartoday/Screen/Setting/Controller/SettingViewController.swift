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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var serviceWithDrawLabel: UILabel!
    @IBOutlet weak var labelBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUI()
    }
    
    // MARK: - @objc
    
    @objc func logoutLabelDidTap() {
        
    }
    
    @objc func serviceWithDrawDidTap() {
        
    }
    
    // MARK: - Custom Method
    
    private func hideSectionHeaderPadding() {
        tableView.sectionHeaderTopPadding = 0
    }
    
    private func setUI() {
        hideSectionHeaderPadding()
        setLabelUI()
        setLayout()
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        registerXib()
    }
    
    private func registerXib() {
        let nib = UINib(nibName: SettingTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
    
    private func setLabelUI() {
        logoutLabel.textColor = .blue01
        logoutLabel.textAlignment = .left
        logoutLabel.font = .p4
        
        serviceWithDrawLabel.textColor = .blue01
        serviceWithDrawLabel.textAlignment = .left
        serviceWithDrawLabel.font = .p4
    }
    
    private func setLayout() {
        labelBottomConstraint.constant = getDeviceHeight() == 667 ? 35 : 73
    }
    
    private func addLogoutLabelGesture() {
        let addLogoutLabelGesture = UITapGestureRecognizer(target: self, action: #selector(logoutLabelDidTap))
        logoutLabel.addGestureRecognizer(addLogoutLabelGesture)
    }
    
    private func addServiceWithDrawLabelGestrue() {
        let addServiceWithDrawGesture = UITapGestureRecognizer(target: self, action: #selector(serviceWithDrawDidTap))
        serviceWithDrawLabel.addGestureRecognizer(addServiceWithDrawGesture)
    }
    
    // MARK: IBAciton
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
            cell.setData(firstSectionLabel[indexPath.row])
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
            cell.setData(secondSectionLabel[indexPath.row])
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
        let headerView = UIView()
        var headerLabel = UILabel().then {
            $0.textColor = .blue02
            $0.textAlignment = .left
            $0.font = .p4
            $0.text = section == 0 ? "설정" : "디어투데이 정보"
        }
        
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalTo(headerView)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}
