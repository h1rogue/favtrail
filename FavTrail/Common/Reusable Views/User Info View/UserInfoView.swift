//
//  UserInfoView.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 07/08/22.
//

import UIKit

class UserInfoView: UIView {

    @IBOutlet weak private var userImage: UIImageView!
    @IBOutlet weak private var userName: UILabel!
    @IBOutlet weak private var postTime: UILabel!
    @IBOutlet weak private var userLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userName.font = UIFont.poppinsMedium(size: 14)
        self.userLocation.font = UIFont.poppinsRegular(size: 10)
        self.postTime.font = UIFont.poppinsRegular(size: 10)
    }
    
    func configureView(model: UserInfoModel, postTime: String) {

        self.postTime.attributedText = postTime.getAttributedString()
        self.userName.attributedText = model.userName.getAttributedString()
        self.userLocation.attributedText = model.userLocation.getAttributedString()
        
        let imageString = model.userImage
        let imageUrl = URL(string: imageString)
        self.userImage.addShimmerGradient()
        self.userImage.sd_setImage(with: imageUrl) { _, _, _, _ in
            self.userImage.removeShimmerGradient()
        }
        self.userImage.addDefaultCornerRadius(10)
    }
}
