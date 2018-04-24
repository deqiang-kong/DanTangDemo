//
//  CategoryCollectionViewCell.swift
//  DanTangDemo
//
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var placeholderButton: UIButton!
    
    var collection: Collection? {
        didSet {
            let url = collection!.banner_image_url
            collectionImageView.kf.setImage(with: URL(string: url!), placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.placeholderButton.isHidden = true
            }
        }
    }
    
    @IBOutlet weak var collectionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
