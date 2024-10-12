//
//  PlaceDetailHeaderTVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 25/12/22.
//

import UIKit

class PlaceDetailHeaderTVC: UITableViewCell {

    @IBOutlet weak private var placeImageView: UIImageView!
    @IBOutlet weak private var imageTitle: UILabel!
    @IBOutlet weak private var placeTitle: UILabel!
    @IBOutlet weak private var placeSubtitle: UILabel!
    @IBOutlet weak private var ratingLabel: UILabel!
    @IBOutlet weak private var reviewLabel: UILabel!
    @IBOutlet weak private var ratingBar: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageTitle.textColor = UIColor.white
        imageTitle.font = UIFont.poppinsMedium(size: 20)
        placeTitle.font = UIFont.poppinsMedium(size: 16)
        placeSubtitle.font = UIFont.poppinsMedium(size: 12)
        ratingLabel.font = UIFont.poppinsMedium(size: 12)
        reviewLabel.font = UIFont.poppinsMedium(size: 12)
    }
    
    func configure(model: HomeGenericObjectModel) {
        guard let objects = model.objects as? [PDHeaderModel], let object = objects.first else { return }
        if let imageStr = object.imgUrl, let imageURL = URL(string: imageStr) {
            placeImageView.addShimmerGradient()
            placeImageView.sd_setImage(with: imageURL) { _, _, _, _ in
                self.placeImageView.removeShimmerGradient()
            }
        }
        
        imageTitle.attributedText = object.headerTitle.getAttributedString()
        placeTitle.attributedText = object.title.getAttributedString()
        placeSubtitle.attributedText = object.subtitle?.getAttributedString()
        ratingLabel.attributedText = object.ratingText?.getAttributedString()
        reviewLabel.attributedText = object.reviewText?.getAttributedString()
        
        guard let ratingBarView = ReusableView.ratingStarBarView.instantiateView() as? RatingStarBarView else { return }
        ratingBar.addSubview(ratingBarView)
        ratingBarView.fillSuperView()
        
        ratingBarView.configure(rating: object.rating ?? 0.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
