//
//  PlaceDetailPresenter.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 25/12/22.
//

import Foundation
import UIKit

class PLaceDetailPresenter: PlaceDetailPresenterProtocol {
    
    weak var view: PlaceDetailViewProtocol?
    var interactor: PlaceDetailInteractorProtocol?
    var wireFrame: PlaceDetailWireFrame?
    
    var responseModel: PlaceDetailModel?
   
    func viewDidLoad() {
        interactor?.viewDidLoad()
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return responseModel?.feed.objects.count ?? 0
    }
    
    func cellModelForRowAtIndex(indexPath: IndexPath) -> HomeGenericObjectModel? {
        return responseModel?.feed.objects[indexPath.row]
    }
    
    func fetchedPDSuccessfully(response: PlaceDetailModel) {
        responseModel = response
        view?.fetchPDSuccessfully()
    }
    
    
    
    func presentImageScrollerVC(itemIndex: Int, delegate: ImageScrollerVCDelegate?, contentList: [String], view: UIViewController) {
        wireFrame?.ctaTapped(ctaType: .imageScrollerVC(itemIndex: itemIndex, delegate: delegate, contentList: contentList, view: view))
    }
    
    func presentBlogDetailVC(blogId: String, view: UIViewController) {
        wireFrame?.ctaTapped(ctaType: .blogDetailVC(blogId: blogId, view: view))
    }
    
    func searchButtonTapped(view: UIViewController) {
        //TODO: when requirede add here.
    }
    
    func presentBlogCommentVC(blogId: String, view: UIViewController) {
        wireFrame?.ctaTapped(ctaType: .blogCommentVC(blogId: blogId, view: view))
    }
}
