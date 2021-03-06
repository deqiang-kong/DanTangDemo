//
//  CategoryHeaderViewController.swift
//  DanTangDeom
//
//
//  分类界面顶部 专题合集
//

import UIKit

let categoryCollectionCellID = "CategoryCollectionViewCell"

class CategoryHeaderViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TopHeaderViewDelegate {
    
    var collections = [Collection]()
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        // 设置 UI
        setupUI()
        /// 分类界面 顶部 专题合集
        NetworkTool.shareNetworkTool.loadCategoryCollection(limit: 6) { (collections) in
            self.collections = collections
            self.collectionView!.reloadData()
        }
    }
    
    // 设置 UI
    private func setupUI() {
        
        let headerView = Bundle.main.loadNibNamed(String(describing: TopHeaderView.self), owner: nil, options: nil)?.last as! TopHeaderView
        headerView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: 40)
        headerView.delegate = self
        view.addSubview(headerView)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: SCREENW, height: 95), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        let cellNib = UINib(nibName: String(describing: CategoryCollectionViewCell.self), bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: categoryCollectionCellID)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    // MARK: - YMTopHeaderViewDelegate
    func topViewDidClickedMoreButton(button: UIButton) {
        let seeAllVC = SeeAllController()
        seeAllVC.title = "查看全部"
        navigationController?.pushViewController(seeAllVC, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionCellID, for: indexPath as IndexPath) as! CategoryCollectionViewCell
        cell.collection = collections[indexPath.item]
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionDetailVC = CollectionDetailController()
        let collection = collections[indexPath.row]
        collectionDetailVC.title = collection.title
        collectionDetailVC.id = collection.id
        collectionDetailVC.type = "专题合集"
        navigationController?.pushViewController(collectionDetailVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kitemW, height: kitemH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin)
    }
}

