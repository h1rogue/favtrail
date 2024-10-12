//
//  AddPostImageUploadButtonCVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 10/10/22.
//

import UIKit

class AddPostImageUploadButtonCVC: UICollectionViewCell {

    @IBOutlet weak private var plusImage: UIImageView!
    @IBOutlet weak private var label: UILabel!
    @IBOutlet weak private var viewBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.label.text = "Upload Photos"
        self.label.font = UIFont.poppinsRegular(size: 12)
        self.viewBackgroundView.backgroundColor = Theme.light.backGroundColor.withAlphaComponent(0.3)
        self.viewBackgroundView.addDefaultCornerRadius(8)
    }

}
