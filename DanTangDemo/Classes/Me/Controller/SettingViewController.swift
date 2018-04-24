//
//  SettingViewController.swift
//  DanTangDemo
//
//

import UIKit

class SettingViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    var settings = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 从 plist 文件在加载数据
        configCellFromPlist()
        
        setupTableView()
    }
    /// 从 plist 文件在加载数据
    func configCellFromPlist() {
        let path = Bundle.main.path(forResource: "SettingCell", ofType: ".plist")
        let settingsPlist = NSArray.init(contentsOfFile: path!)
        for arrayDict in settingsPlist! {
            let array = arrayDict as! NSArray
            var sections = [AnyObject]()
            for dict in array {
                let setting = Setting(dict: dict as! [String: AnyObject])
                sections.append(setting)
            }
            settings.append(sections as AnyObject)
        }
    }
    
    /// 创建 tableView
    private func setupTableView() {
        let tableView = UITableView()
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 54
        let nib = UINib(nibName: String(describing: SettingCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: messageCellID)
        tableView.tableFooterView = UIView()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settings.count 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let setting = settings[section] as! [Setting]
        return setting.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messageCellID) as! SettingCell
        let setting = settings[indexPath.section] as! [Setting]
        cell.setting = setting[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin + 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
