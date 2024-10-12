
//
//  BlogCommentCVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 26/04/23.
//

import UIKit

protocol BlogCommentCVCDelegate: AnyObject {
    func didTapLikeButton(value: Bool)
}

class BlogCommentTVC: UITableViewCell {

    @IBOutlet weak private var userTitle: UILabel!
    @IBOutlet weak private var userComment: UILabel!
    @IBOutlet weak private var userImage: UIImageView!
    
    weak var delegate: BlogCommentCVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userTitle.font = UIFont.poppinsSemiBold(size: 12.0)
        self.userComment.font = UIFont.poppinsRegular(size: 14.0)
    }
    
    func configure(model: CommentFullScreenViewModel.CommentModel) {
        self.userTitle.attributedText = model.userName.getAttributedString()
        self.userComment.attributedText = model.userComment.getAttributedString()
        
        let imageString = model.userImage
        let imageUrl = URL(string: imageString)
        self.userImage.addShimmerGradient()
        self.userImage.sd_setImage(with: imageUrl) { _, _, _, _ in
            self.userImage.removeShimmerGradient()
        }
        self.userImage.addDefaultCornerRadius(15)
    }
}

extension BlogCommentTVC {
    static func getCellSize(model: CommentFullScreenViewModel.CommentModel, width: CGFloat) -> CGSize {
        var itemHeight: CGFloat = 20.0 //top + bottom
        let userNameHeight = model.userName.getAttributedString().height(width: width - (73.0))
        let userCommentHeight = model.userComment.getAttributedString().height(width: width - (73.0))
        itemHeight += max(userNameHeight + userCommentHeight + 4, 30.0)
        
        return CGSize(width: width, height: itemHeight)
    }
}
