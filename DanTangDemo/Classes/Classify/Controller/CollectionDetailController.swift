//
//  CollectionDetailController.swift
//  DanTangDemo
//
//

import UIKit

let collectionTableCellID = "CollectionTableViewCell"

class CollectionDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var type = String()
    
    var posts = [CollectionPost]()
    
    var id: Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: String(describing: CollectionTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: collectionTableCellID)
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        weak var weakSelf = self
        if type == "专题合集" {
            NetworkTool.shareNetworkTool.loadCollectionPosts(id: id!) { (posts) in
                weakSelf!.posts = posts
                weakSelf!.tableView.reloadData()
            }
        } else if type == "风格品类" {
            NetworkTool.shareNetworkTool.loadStylesOrCategoryInfo(id: id!, finished: { (items) in
                weakSelf!.posts = items
                weakSelf!.tableView.reloadData()
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: collectionTableCellID) as! CollectionTableViewCell
        cell.selectionStyle = .none
        cell.collectionPost = posts[indexPath.row
        ]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetailVC = PostDetailViewController()
        postDetailVC.post = posts[indexPath.row]
        postDetailVC.title = "攻略详情"
        navigationController?.pushViewController(postDetailVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
