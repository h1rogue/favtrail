//
//  ImageContentCVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 10/08/22.
//

import UIKit

class ImageContentCVC: UICollectionViewCell {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var secondView: UIView!
    @IBOutlet weak private var imageCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(imageUrl: String, showImageCount: Int? = nil) {
        if let imageUrl: URL = URL(string: imageUrl) {
            imageView.addShimmerGradient()
            imageView.sd_setImage(with: imageUrl) { _, _, _, _ in
                self.imageView.removeShimmerGradient()
            }
        }
        
        if let imageCount = showImageCount {
            secondView.backgroundColor = .clear.withAlphaComponent(0.6)
            imageCountLabel.isHidden = false
            imageCountLabel.text = "+ \(imageCount)"
        } else {
            secondView.backgroundColor = .clear
            imageCountLabel.isHidden = true
        }
    }
}
