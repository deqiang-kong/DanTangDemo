//
//  CategoryViewController.swift
//  DanTangDemo
//
//
//  分类界面
//

import UIKit

class CategoryViewController: BaseViewController, CategoryBottomViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Feed_SearchBtn_18x18_"), style: .plain, target: self, action: #selector(categoryRightBBClick))
        setupScrollView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        // 顶部控制器
        let headerViewController = CategoryHeaderViewController()
        addChildViewController(headerViewController)
        
        let topBGView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 135))
        scrollView.addSubview(topBGView)
        
        let headerVC = childViewControllers[0]
        topBGView.addSubview(headerVC.view)
        
        let bottomBGView = CategoryBottomView(frame: CGRect(x: 0, y: topBGView.frame.maxY + 10, width: SCREENW, height: SCREENH - 160))
        bottomBGView.backgroundColor = GlobalColor()
        bottomBGView.delegate = self
        scrollView.addSubview(bottomBGView)
        scrollView.contentSize = CGSize(width: SCREENW, height: bottomBGView.frame.maxY)
    }
    
    @objc func categoryRightBBClick() {
        let searchBarVC = SearchViewController()
        navigationController?.pushViewController(searchBarVC, animated: true)
    }
    
    /// 懒加载创建 scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = GlobalColor()
        scrollView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH)
        return scrollView
    }()
    
    // MARK: - CategoryBottomViewDelegate
    func bottomViewButtonDidClicked(button: UIButton) {
        let collectionDetailVC = CollectionDetailController()
        collectionDetailVC.title = button.titleLabel?.text!
        collectionDetailVC.id = button.tag
        collectionDetailVC.type = "风格品类"
        navigationController?.pushViewController(collectionDetailVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
