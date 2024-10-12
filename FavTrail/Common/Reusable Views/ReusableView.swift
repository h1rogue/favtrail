//
//  ReusableView.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 07/08/22.
//

import Foundation
import UIKit

enum ReusableView {
    
    case titleSubtitleView, blogPostView, navigationBarView, userInfoView, blogBottomBarView, customInputField, commentInputField
    case ratingStarBarView
    
    func instantiateView() -> UIView {
        switch self {
        case .titleSubtitleView:
            return TitleSubTitleView.instantiateFromNib(.main)
        case .blogPostView:
            return BlogPostView.instantiateFromNib(.main)
        case .userInfoView:
            return UserInfoView.instantiateFromNib(.main)
        case .navigationBarView:
            return NavigationBarView.instantiateFromNib(.main)
        case .blogBottomBarView:
            return BlogBottomBarView.instantiateFromNib(.main)
        case .customInputField:
            return CustomInputField.instantiateFromNib(.main)
        case .ratingStarBarView:
            return RatingStarBarView.instantiateFromNib(.main)
        case .commentInputField:
            return CommentInputField.instantiateFromNib(.main)
        }
    }
}
