//
//  BaseWireframe.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 23/04/23.
//

import Foundation
import UIKit

protocol BaseWireframeProtocol: AnyObject {
    func ctaTapped(ctaType: CtaType)
}

extension BaseWireframeProtocol {
    
    func ctaTapped(ctaType: CtaType) {
        switch ctaType {
        case .dismiss:
            break
        case .blogDetailVC(let blogId, let view):
            presentBlogDetailVC(blogId: blogId, view: view)
        case .blogCommentVC(let blogId, let view):
            presentCommentFullScreenVC(blogId, view)
        case .presentPlaceDetail(let view):
            presentPlaceDetailVC(view: view)
        case .imageScrollerVC(let itemIndex, let delegate, let contentList, let view):
            presentImageScrollerVC(itemIndex: itemIndex, delegate: delegate, contentList: contentList, view: view)
        }
    }
    
    private func presentImageScrollerVC(itemIndex: Int, delegate: ImageScrollerVCDelegate?, contentList: [String], view: UIViewController) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let imageVC = storyBoard.instantiateViewController(withIdentifier: ImageScrollerVC.identifier) as? ImageScrollerVC {
            imageVC.configure(contentList: contentList, indexClicked: itemIndex)
            imageVC.modalPresentationStyle = .overFullScreen
            view.present(imageVC, animated: true)
        }
    }
    
    private func presentBlogDetailVC(blogId: String, view: UIViewController) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let blogDetailVC = storyBoard.instantiateViewController(withIdentifier: HomeBlogDetailVC.identifier) as? HomeBlogDetailVC {
            let viewModel = HomeBlogDetailVM(blogId: blogId)
            blogDetailVC.configureVM(viewModel: viewModel)
            blogDetailVC.hidesBottomBarWhenPushed = true
            view.navigationController?.pushViewController(blogDetailVC, animated: true)
        }
    }
    
    private func presentPlaceDetailVC(view: UIViewController) {
        if let placeDetailVC = PlaceDetailWireFrame.createPlaceDetailModule() as? PlaceDetailVC {
            placeDetailVC.hidesBottomBarWhenPushed = true
            view.navigationController?.pushViewController(placeDetailVC, animated: true)
        }
    }
    
    private func presentCommentFullScreenVC(_ blogId: String, _ view: UIViewController) {
        CommentFullScreenBuilder.buildCommentVC(blogId: blogId, view: view)
    }
}
