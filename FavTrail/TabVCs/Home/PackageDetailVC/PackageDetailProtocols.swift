//
//  PackageDetailProtocols.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 04/01/23.
//

import Foundation
import UIKit

//VIEW
protocol PackageDetailViewProtocol: AnyObject {
    var presenter: PackageDetailPresenterProtocol? { get set }
    
    func fetchPDSuccessfully()
}

//PRESENTER
protocol PackageDetailPresenterProtocol: AnyObject {
    var view: PackageDetailViewProtocol? { get set }
    var interactor: PackageDetailInteractorProtocol? { get set }
    var wireFrame: PackageDetailWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func numberOfRowsInSection(section: Int) -> Int
    func cellModelForRowAtIndex(indexPath: IndexPath) -> HomeGenericObjectModel?
    func getFooterModel() -> PackageDetailFooter?
    
    func fetchedPDSuccessfully(response: PackageDetailModel)
}

//Interactor
protocol PackageDetailInteractorProtocol: AnyObject {
    var presenter: PackageDetailPresenterProtocol? { get set }
    var remoteDataHandler: PackageDetailRemoteDataHandlerProtocol? { get set }
    
    func viewDidLoad()
    func fetchDataSuccessfully(response: PackageDetailModel)
}

//Remote Handler
protocol PackageDetailRemoteDataHandlerProtocol: AnyObject {
    var interactor: PackageDetailInteractorProtocol? { get set }
    
    func fetchPlaceDetailData()
}

//WireFrame
protocol PackageDetailWireFrameProtocol: AnyObject {}


