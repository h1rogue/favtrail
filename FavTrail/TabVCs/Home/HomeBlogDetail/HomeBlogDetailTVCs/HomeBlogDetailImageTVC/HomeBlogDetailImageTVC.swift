//
//  HomeBlogDetailImageTVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 30/09/22.
//

import UIKit
import SDWebImage

class HomeBlogDetailImageTVC: UITableViewCell {
    
    @IBOutlet weak private var blogImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(image: String) {
        if let imgUrl = URL(string: image) {
            self.blogImageView.addShimmerGradient()
            self.blogImageView.sd_setImage(with: imgUrl) { _, _, _, _ in
                self.blogImageView.removeShimmerGradient()
            }
        }
    }
}
