//
//  SeeAllTopicCell.swift
//  DanTangDemo
//
//

import UIKit
import Kingfisher

class SeeAllTopicCell: UITableViewCell {
    
    var collection: Collection? {
        didSet {
            let url = collection!.cover_image_url
            bgImageView.kf.setImage(with: URL(string: url!)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.placeholderButton.isHidden = true
            }
            titleLabel.text = collection!.title
            subtitleLabel.text = collection!.subtitle
        }
    }
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var placeholderButton: UIButton!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgImageView.layer.cornerRadius = kCornerRadius
        bgImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
