//
//  TopHeaderView.swift
//  DanTangDemo
//
//

import UIKit

protocol TopHeaderViewDelegate: NSObjectProtocol {
    func topViewDidClickedMoreButton(button: UIButton)
}

class TopHeaderView: UIView {
    
    weak var delegate: TopHeaderViewDelegate?
    
    /// 查看全部按钮
    @IBAction func viewAllButton(sender: UIButton) {
        delegate?.topViewDidClickedMoreButton(button: sender)
    }
}
