//
//  HomeBlogDetailTextTVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 30/09/22.
//

import UIKit

class HomeBlogDetailTextTVC: UITableViewCell {

    @IBOutlet weak private var blogTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.blogTextLabel.font = UIFont.poppinsRegular(size: 14)
    }
    
    func configure(text: String) {
        blogTextLabel.attributedText = text.getAttributedString() // TODO: change this to attributed string and get html parsing done for this.
    }
}
