//
//  CommentFullScreenBuilder.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 26/04/23.
//

import Foundation
import UIKit

struct CommentFullScreenBuilder {
    static func buildCommentVC(blogId: String, view: UIViewController) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let blogCommentVC = storyBoard.instantiateViewController(withIdentifier: CommentFullScreenVC.identifier) as? CommentFullScreenVC {
            let viewModel = CommentFullScreenViewModel(blogID: blogId, delegate: blogCommentVC)
            blogCommentVC.viewModel = viewModel
            let navBlogComentVC = UINavigationController(rootViewController: blogCommentVC)
            navBlogComentVC.modalPresentationStyle = .fullScreen
            view.present(navBlogComentVC, animated: true)
        }
    }
}
