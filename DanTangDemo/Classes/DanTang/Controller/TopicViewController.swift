//
//  TopicViewController.swift
//  DanTang


import UIKit

let homeCellID = "homeCellID"

class TopicViewController: UITableViewController, HomeCellDelegate {
    
    var type = Int()
    
    /// 首页列表数据
    var items = [HomeItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalColor()
        
        setupTableView()
        
        // 添加刷新控件
        refreshControl?.addTarget(self, action: #selector(loadHomeData), for: .valueChanged)
        // 获取首页数据
        weak var weakSelf = self
        NetworkTool.shareNetworkTool.loadHomeInfo(id: type) { (homeItems) in
            weakSelf!.items = homeItems
            weakSelf!.tableView!.reloadData()
        }
    }
    
    @objc func loadHomeData() {
        // 获取首页数据
        weak var weakSelf = self
        NetworkTool.shareNetworkTool.loadHomeInfo(id: type) { (homeItems) in
            weakSelf!.items = homeItems
            weakSelf!.tableView!.reloadData()
            weakSelf!.refreshControl?.endRefreshing()
        }
    }
    
    func setupTableView() {
        tableView.rowHeight = 160
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(kTitlesViewY + kTitlesViewH, 0, tabBarController!.tabBar.height, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        let nib = UINib(nibName: String(describing: HomeCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: homeCellID)
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCell = tableView.dequeueReusableCell(withIdentifier: homeCellID) as! HomeCell
        homeCell.selectionStyle = .none
        homeCell.homeItem = items[indexPath.row]
        homeCell.delegate = self
        
        return homeCell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.homeItem = items[indexPath.row]
        detailVC.title = "攻略详情"
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - HomeCellDelegate
    func homeCellDidClickedFavoriteButton(button: UIButton) {
//        if !UserDefaults.standard.bool(forKey: isLogin) {
//            let loginVC = LoginViewController()
//            loginVC.title = "登录"
//            let nav = YMNavigationController(rootViewController: loginVC)
//            present(nav, animated: true, completion: nil)
//        } else {
//
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

