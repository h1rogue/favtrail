//
//  RecentUpdatesCVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 29/08/22.
//

import UIKit

class RecentUpdatesCVC: UICollectionViewCell {

    @IBOutlet weak private var image: UIImageView!
    @IBOutlet weak private var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title.font = UIFont.poppinsRegular(size: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.image.addDefaultCornerRadius(5)
    }
    
    func configureCell(model: RecentUpdateContentModel) {
        image.contentMode = .scaleAspectFill
        self.title.isHidden = false
        self.title.attributedText = model.title.getAttributedString()
        
        let imageUrl = URL(string: model.imgUrl)
        self.image.addShimmerGradient()
        self.image.sd_setImage(with: imageUrl) { _, _, _, _ in
            self.image.removeShimmerGradient()
        }
    }
}
