//
//  ProductDetailToolBar.swift
//  DanTangDemo
//
//

import UIKit

protocol ProductDetailToolBarDelegate: NSObjectProtocol {
    func toolBarDidClickedTMALLButton()
}

class ProductDetailToolBar: UIView {
    
    weak var delegate: ProductDetailToolBarDelegate?
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.layer.borderColor = GlobalRedColor().cgColor
        likeButton.layer.borderWidth = klineWidth
        likeButton.setImage(UIImage(named: "content-details_like_16x16_"), for: .normal)
        likeButton.setImage(UIImage(named: "content-details_like_selected_16x16_"), for: .selected)
    }
    
    @IBAction func likeButtonClick(sender: UIButton) {
        // 判断是否登录
        if UserDefaults.standard.bool(forKey: isLogin) {
            sender.isSelected = !sender.isSelected
        } else {
            let loginVC = LoginViewController()
            loginVC.title = "登录"
            let nav = NavigationController(rootViewController: loginVC)
            UIApplication.shared.keyWindow?.rootViewController?.present(nav, animated: true, completion: nil)
        }
    }
    
    @IBAction func goTMALLButtonClick() {
        delegate?.toolBarDidClickedTMALLButton()
    }
}
