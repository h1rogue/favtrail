//
//  HomeFeedNearbyCVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 09/08/22.
//

import UIKit

class HomeFeedNearbyCVC: UICollectionViewCell {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont.poppinsMedium(size: 10)
        self.subTitleLabel.font = UIFont.poppinsRegular(size: 8)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.addDefaultCornerRadius(5)
    }
    
    func configureCell(model: NearbyTravelContentModel) {
        imageView.contentMode = .scaleAspectFill
        imageView.frame = frame
        self.titleLabel.isHidden = false
        self.titleLabel.attributedText = model.title.getAttributedString()
        
        if let subTitle = model.subTitle {
            self.subTitleLabel.isHidden = false
            self.subTitleLabel.attributedText = subTitle.getAttributedString()
        } else {
            self.subTitleLabel.isHidden = true
        }
        let imageUrl = URL(string: model.imgUrl)
        self.imageView.addShimmerGradient()
        self.imageView.sd_setImage(with: imageUrl) { _, _, _, _ in
            self.imageView.removeShimmerGradient()
        }
        self.imageView.clipsToBounds = true
    }
}
