//
//  ImagesCVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 08/08/22.
//

import UIKit

class HomeFeedImagesCVC: UICollectionViewCell {
    
    @IBOutlet weak private var image: UIImageView!
    @IBOutlet weak private var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title.font = UIFont.poppinsRegular(size: 14)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.image.addDefaultCornerRadius(5)
    }
    
    func configureCell(model: TrendingContentModel) {
        image.contentMode = .scaleAspectFill
        self.title.attributedText = model.title.getAttributedString()
        
        let imageUrl = URL(string: model.imgUrl)
        self.image.addShimmerGradient()
        self.image.sd_setImage(with: imageUrl) { _, _, _, _ in
            self.image.removeShimmerGradient()
        }
    }
}
