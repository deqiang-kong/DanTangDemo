//
//  DetailScrollView.swift
//  DanTangDemo
//
//

import UIKit

class DetailScrollView: UIScrollView {
    
    var product: Product? {
        didSet {
            topScrollView.product = product
            bottomScrollView.product = product
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        
        addSubview(topScrollView)
        // 添加底部滚动视图
        addSubview(bottomScrollView)
        
        topScrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.size.equalTo(CGSize(width: SCREENW, height: 520))
        }
        
        bottomScrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(topScrollView.snp.bottom).offset(kMargin)
            make.size.equalTo(CGSize(width: SCREENW, height: SCREENH - 64 - 45))
        }
    }
    
    /// 顶部滚动视图
    private lazy var topScrollView: ProductDetailTopView = {
        let topScrollView = ProductDetailTopView()
        topScrollView.backgroundColor = UIColor.white
        return topScrollView
    }()
    
    /// 底部滚动视图
    private lazy var bottomScrollView: ProductDetailBottomView = {
        let bottomScrollView = ProductDetailBottomView()
        bottomScrollView.backgroundColor = UIColor.white
        return bottomScrollView
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
