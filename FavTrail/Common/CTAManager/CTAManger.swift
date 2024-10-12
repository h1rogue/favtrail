//
//  CTAManger.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 23/04/23.
//

import Foundation
import UIKit

enum CtaType {
    case dismiss
    case blogDetailVC(blogId: String, view: UIViewController)
    case blogCommentVC(blogId: String, view: UIViewController)
    case presentPlaceDetail(view: UIViewController)
    case imageScrollerVC(itemIndex: Int, delegate: ImageScrollerVCDelegate?, contentList: [String], view: UIViewController)
}
