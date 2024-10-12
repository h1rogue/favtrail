//
//  PlaceDetailHorizontalCVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 30/12/22.
//

import UIKit

struct PDHorizontalCardModel {
    let title: String
    let subtitle: String
    let image: String?
}

class PlaceDetailHorizontalCVC: UICollectionViewCell {

    @IBOutlet weak private var topImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.poppinsMedium(size: 10)
        subtitleLabel.font = UIFont.poppinsMedium(size: 8)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topImageView.addDefaultCornerRadius(5)
    }
    
    func configure(model: PDHorizontalCardModel) {
        self.titleLabel.attributedText = model.title.getAttributedString()
        self.subtitleLabel.attributedText = model.subtitle.getAttributedString()
        if let image = model.image {
            let imgUrl = URL(string: image)
            self.topImageView.addShimmerGradient()
            self.topImageView.sd_setImage(with: imgUrl) { _, _, _, _ in
                self.topImageView.removeShimmerGradient()
            }
            self.topImageView.clipsToBounds = true
        }
    }
}
