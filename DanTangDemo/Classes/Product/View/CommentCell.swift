//
//  CommentCell.swift
//  DanTangDemo
//


import UIKit
import Kingfisher

class CommentCell: UITableViewCell {

    var comment: Comment? {
        didSet {
            let user = comment!.user
            if let url = user!.avatar_url  {
                avatarImageView.kf.setImage(with: URL(string: url))
            }
            
            nicknameLabel.text = user!.nickname
            contentLabel.text = comment!.content
        }
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
