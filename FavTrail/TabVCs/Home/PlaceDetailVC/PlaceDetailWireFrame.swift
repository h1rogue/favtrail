//
//  PlaceDetailWireFramw.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 25/12/22.
//

import Foundation
import UIKit

class PlaceDetailWireFrame: BaseWireframeProtocol, PlaceDetailWireFrameProtocol {
    
    static func createPlaceDetailModule() -> UIViewController {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: .main)
        let view = storyBoard.instantiateViewController(withIdentifier: "PlaceDetailVC") as! PlaceDetailVC
        
        let presenter: PlaceDetailPresenterProtocol = PLaceDetailPresenter()
        let interactor: PlaceDetailInteractorProtocol = PlaceDetailInteractor()
        let remoteDataHandler: PlaceDetailRemoteDataHandlerProtocol = PlaceDetailRemoteHandler()
        let wireFrame = PlaceDetailWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDataHandler = remoteDataHandler
        remoteDataHandler.interactor = interactor
        
        return view
    }
}
