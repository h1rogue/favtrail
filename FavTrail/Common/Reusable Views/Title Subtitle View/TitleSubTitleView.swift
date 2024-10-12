//
//  TitleSubTitleView.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 07/08/22.
//

import UIKit

class TitleSubTitleView: UIView {
    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title.font = UIFont.poppinsMedium(size: 14)
        self.subTitle.font = UIFont.poppinsRegular(size: 12)
    }
    
    func configureView(title: String, subTitle: String?) {
        self.title.attributedText = title.getAttributedString()
        self.subTitle.attributedText = subTitle?.getAttributedString()
    }
}
