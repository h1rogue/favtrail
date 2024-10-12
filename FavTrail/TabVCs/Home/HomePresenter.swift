//
//  HomePresenter.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 31/07/22.
//

import Foundation
import UIKit

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    
    var interactor: HomeInteractorProtocol?
    
    var wireFrame: HomeWireFrame?
    
    var userFeed: HomeUserFeedModel?
    
    func numberOfRowsInSection(section: Int) -> Int {
        return userFeed?.feed.objects.count ?? 0
    }
    
    func cellModelForRowAtIndex(indexPath: IndexPath) -> HomeGenericObjectModel? {
        return userFeed?.feed.objects[indexPath.row]
    }
    
    func viewDidLoad() {
        interactor?.fetchHomeData()
    }
    
    func fetchedHomeDataSuccessfully(response: HomeUserFeedModel) {
        userFeed = response
        view?.fetchedHomeDataSuccessfully()
    }
    
    func presentImageScrollerVC(itemIndex: Int, delegate: ImageScrollerVCDelegate?, contentList: [String], view: UIViewController) {
        wireFrame?.ctaTapped(ctaType: .imageScrollerVC(itemIndex: itemIndex, delegate: delegate, contentList: contentList, view: view))
    }
    
    func presentBlogDetailVC(blogId: String, view: UIViewController) {
        wireFrame?.ctaTapped(ctaType: .blogDetailVC(blogId: blogId, view: view))
    }
    
    func presentBlogCommentVC(blogId: String, view: UIViewController) {
        wireFrame?.ctaTapped(ctaType: .blogCommentVC(blogId: blogId, view: view))
    }
    
    func searchButtonTapped(view: UIViewController) {
        wireFrame?.ctaTapped(ctaType: .presentPlaceDetail(view: view))
    }
}
