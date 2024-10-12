//
//  ImageScrollerCVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 19/09/22.
//

import UIKit
import SDWebImage

class ImageScrollerCVC: UICollectionViewCell {

    @IBOutlet weak private var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    func configure(imgUrl: URL) {
        self.imageView.addShimmerGradient()
        self.imageView.sd_setImage(with: imgUrl) { _, _, _, _ in
            self.imageView.removeShimmerGradient()
        }
    }
}
