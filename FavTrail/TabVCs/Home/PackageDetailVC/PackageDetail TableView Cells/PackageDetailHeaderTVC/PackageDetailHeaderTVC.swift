//
//  PackageDetailHeaderTVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 04/01/23.
//

import UIKit

class PackageDetailHeaderTVC: UITableViewCell {

    @IBOutlet weak private var topImageView: UIImageView!
    @IBOutlet weak private var imageLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    @IBOutlet weak private var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageLabel.textColor = UIColor.white
        imageLabel.font = UIFont.poppinsMedium(size: 20)
        titleLabel.font = UIFont.poppinsMedium(size: 16)
        subtitleLabel.font = UIFont.poppinsMedium(size: 12)
        durationLabel.font =  UIFont.poppinsMedium(size: 18)
    }
    
    func configure(model: HomeGenericObjectModel) {
        guard let objects = model.objects as? [PackageHeaderModel], let object = objects.first else { return }
        if let imageStr = object.image, let imageURL = URL(string: imageStr) {
            topImageView.addShimmerGradient()
            topImageView.sd_setImage(with: imageURL) { _, _, _, _ in
                self.topImageView.removeShimmerGradient()
            }
            imageLabel.attributedText = object.headerTitle.getAttributedString()
            titleLabel.attributedText = object.title.getAttributedString()
            subtitleLabel.attributedText = object.subtitle?.getAttributedString()
            durationLabel.attributedText = object.additionalInfo?.getAttributedString()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
