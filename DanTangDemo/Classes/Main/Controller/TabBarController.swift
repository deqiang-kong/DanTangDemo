//
//  TabBarController.swift
//  DanTangDemo
//
//  Created by kongdq on 2017/11/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = UITabBar.appearance()
        self.view.backgroundColor = UIColor.white
        tabBar.tintColor = Color(r: 245, g: 90, b: 93, a: 1/0)
        addChildViewControllers()
    }
    
    /**
     * 添加子控制器
     */
    private func addChildViewControllers() {
        addChildViewController(childController: DanTangViewController(), title: "单糖", imageName: "TabBar_home_23x23_")
        addChildViewController(childController: ProductViewController(), title: "单品", imageName: "TabBar_gift_23x23_")
        addChildViewController(childController: CategoryViewController(), title: "分类", imageName: "TabBar_category_23x23_")
        addChildViewController(childController: MeViewController(), title: "我的", imageName: "TabBar_me_boy_23x23_")
    }
    
    /**
     # 初始化子控制器
     - parameter childControllerName: 需要初始化的控制器
     - parameter title:               标题
     - parameter imageName:           图片名称
     */
    private func addChildViewController(childController: UIViewController, title: String, imageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        childController.title = title
        let navC = NavigationController(rootViewController: childController)
        addChildViewController(navC)
    }
}
