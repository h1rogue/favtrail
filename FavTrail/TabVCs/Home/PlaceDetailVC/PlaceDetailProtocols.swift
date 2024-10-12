//
//  PlaceDetailProtocols.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 25/12/22.
//

import Foundation
import UIKit

///VIEW
protocol PlaceDetailViewProtocol: AnyObject {
    var presenter: PlaceDetailPresenterProtocol? { get set }
    
    func fetchPDSuccessfully()
}

///Presenter
protocol PlaceDetailPresenterProtocol: AnyObject {
    var view: PlaceDetailViewProtocol? { get set }
    var interactor: PlaceDetailInteractorProtocol? { get set }
    var wireFrame: PlaceDetailWireFrame? { get set }
    
    func viewDidLoad()
    func numberOfRowsInSection(section: Int) -> Int
    func cellModelForRowAtIndex(indexPath: IndexPath) -> HomeGenericObjectModel?
    
    func fetchedPDSuccessfully(response: PlaceDetailModel)
    func presentImageScrollerVC(itemIndex: Int, delegate: ImageScrollerVCDelegate?, contentList: [String], view: UIViewController)
    func presentBlogDetailVC(blogId: String, view: UIViewController)
    func presentBlogCommentVC(blogId: String, view: UIViewController)
    func searchButtonTapped(view: UIViewController)
}

//Interactor
protocol PlaceDetailInteractorProtocol: AnyObject {
    var presenter: PlaceDetailPresenterProtocol? { get set }
    var remoteDataHandler: PlaceDetailRemoteDataHandlerProtocol? { get set }
    
    func viewDidLoad()
    func fetchDataSuccessfully(response: PlaceDetailModel)
}

//Remote Handler
protocol PlaceDetailRemoteDataHandlerProtocol: AnyObject {
    var interactor: PlaceDetailInteractorProtocol? { get set }
    
    func fetchPlaceDetailData()
}

//WireFrame
protocol PlaceDetailWireFrameProtocol: AnyObject {}


