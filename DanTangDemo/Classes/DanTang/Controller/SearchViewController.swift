//
//  SearchViewController.swift
//  DanTang
//
//

import UIKit

let searchCollectionCellID = "searchCollectionCellID"

class SearchViewController: BaseViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout, CollectionViewCellDelegate, SortTableViewDelegate {
    
    /// 搜索结果列表
    var results = [SearchResult]()
    
    weak var collectionView: UICollectionView?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏
        setupNav()
        
        view.addSubview(searchRecordView)
    }
    
    // 设置导航栏
    func setupNav() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(navigationBackClick))
    }
    
    /// 设置collectionView
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        collectionView.backgroundColor = view.backgroundColor
        collectionView.dataSource = self
        let nib = UINib(nibName: String(describing: CollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: searchCollectionCellID)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    /// 搜索条件点击
    @objc func sortButtonClick() {
        popView.show()
    }
    
    private lazy var popView: SortTableView = {
        let popView = SortTableView()
        popView.delegate = self
        return popView
    }()
    
    /// 返回按钮、取消按钮点击
    @objc func navigationBackClick() {
        navigationController?.popViewController(animated: true)
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "搜索商品、专题"
        return searchBar
    }()
    
    private lazy var searchRecordView: SearchRecordView = {
        let searchRecordView = SearchRecordView()
        searchRecordView.backgroundColor = GlobalColor()
        searchRecordView.frame = CGRect(x: 0, y: 64, width: SCREENW, height: SCREENH - 64)
        return searchRecordView
    }()
    
    private func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        /// 设置collectionView
        setupCollectionView()
        return true
    }
    
    /// 搜索按钮点击
    private func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .plain, target: self, action: #selector(navigationBackClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_sort_21x21_"), style: .plain, target: self, action: #selector(sortButtonClick))
        /// 根据搜索条件进行搜索
        let keyword = searchBar.text
        weak var weakSelf = self
        NetworkTool.shareNetworkTool.loadSearchResult(keyword: keyword!, sort: "") { (results) in
            weakSelf!.results = results
            weakSelf!.collectionView!.reloadData()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCollectionCellID, for: indexPath as IndexPath) as! CollectionViewCell
        cell.result = results[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let productDetailVC = ProductDetailViewController()
//        productDetailVC.title = "商品详情"
//        productDetailVC.type = String(describing: self)
//        productDetailVC.result = results[indexPath.item]
//        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - 20) / 2
        let height: CGFloat = 245
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // MARK: - CollectionViewCellDelegate
    func collectionViewCellDidClickedLikeButton(button: UIButton) {
//        if !UserDefaults.standard.bool(forKey: isLogin) {
//            let loginVC = YMLoginViewController()
//            loginVC.title = "登录"
//            let nav = YMNavigationController(rootViewController: loginVC)
//            present(nav, animated: true, completion: nil)
//        } else {
//
//        }
    }
    
    // MARK: - SortTableViewDelegate
    func sortView(sortView: SortTableView, didSelectSortAtIndexPath sort: String) {
        /// 根据搜索条件进行搜索
        let keyword = searchBar.text
        weak var weakSelf = self
        NetworkTool.shareNetworkTool.loadSearchResult(keyword: keyword!, sort: sort) { (results) in
            sortView.dismiss()
            weakSelf!.results = results
            weakSelf!.collectionView!.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
