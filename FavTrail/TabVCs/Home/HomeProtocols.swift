//
//  HomeWireFrame.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 31/07/22.
//

import Foundation
import UIKit

///VIEW
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    
    func reloadData()
    func fetchedHomeDataSuccessfully()
}

///PRESENTER
protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var wireFrame: HomeWireFrame? { get set }
    
    func viewDidLoad()
    func numberOfRowsInSection(section: Int) -> Int
    func cellModelForRowAtIndex(indexPath: IndexPath) -> HomeGenericObjectModel?
    func searchButtonTapped(view: UIViewController)
    
    func fetchedHomeDataSuccessfully(response: HomeUserFeedModel)
    func presentImageScrollerVC(itemIndex: Int, delegate: ImageScrollerVCDelegate?, contentList: [String], view: UIViewController)
    func presentBlogDetailVC(blogId: String, view: UIViewController)
    func presentBlogCommentVC(blogId: String, view: UIViewController)
}

///INTERACTOR
protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    var remoteDataHandler: HomeRemoteDataHandlerProtocol? { get set }
    
    func fetchHomeData()
    func fetchedDataSuccessfully(response: HomeUserFeedModel) //MARK: todo
}

///REMOTE HANDLER
protocol HomeRemoteDataHandlerProtocol: AnyObject {
    var interactor: HomeInteractorProtocol? { get set }
    
    func fetchHomeData()
}

///WIREFRAME
protocol HomeWireFrameProtocol: AnyObject {
    
    static func createHomeViewModule() -> UIViewController
}
