//
//  MeViewController.swift
//  DanTangDemo
//
//
//  我的
//

import UIKit

class MeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cellCount = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    /// 创建 tableView
    private func setupTableView() {
        let tableView = UITableView()
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
    }
    
    private lazy var headerView: MineHeaderView = {
        let headerView = MineHeaderView()
        headerView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: kYMMineHeaderImageHeight)
        headerView.iconButton.addTarget(self, action: #selector(iconButtonClick), for: .touchUpInside)
        headerView.messageButton.addTarget(self, action: #selector(messageButtonClick), for: .touchUpInside)
        headerView.settingButton.addTarget(self, action: #selector(settingButtonClick), for: .touchUpInside)
        return headerView
    }()

    // MARK: - 头部按钮点击
    @objc func iconButtonClick() {
        // 判断是否登录
        if UserDefaults.standard.bool(forKey: isLogin) {
            let actionSheet = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "编辑资料", style: .default, handler: { (_) in
                
            })
            let photoAction = UIAlertAction(title: "退出登录", style: .destructive, handler: { (_) in
                UserDefaults.standard.set(false, forKey: isLogin)
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            actionSheet.addAction(cancelAction)
            actionSheet.addAction(cameraAction)
            actionSheet.addAction(photoAction)
            self.present(actionSheet, animated: true, completion: nil)
        } else {
            let loginVC = LoginViewController()
            loginVC.title = "登录"
            let nav = NavigationController(rootViewController: loginVC)
            present(nav, animated: true, completion: nil)
        }
    }
    
    @objc func messageButtonClick() {
        let messageVC = MessageViewController()
        messageVC.title = "消息"
        navigationController?.pushViewController(messageVC, animated: true)
    }
    
    @objc func settingButtonClick() {
        let settingVC = SettingViewController()
        settingVC.title = "更多"
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    private lazy var footerView: MeFooterView = {
        let footerView = MeFooterView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 200))
        return footerView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let choiceView = MeChoiceView()
        return choiceView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            var tempFrame = headerView.bgImageView.frame
            tempFrame.origin.y = offsetY
            tempFrame.size.height = kYMMineHeaderImageHeight - offsetY
            headerView.bgImageView.frame = tempFrame
        }
    }
}
