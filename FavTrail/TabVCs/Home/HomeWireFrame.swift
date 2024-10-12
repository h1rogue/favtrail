//
//  HomeWireFrame.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 31/07/22.
//

import Foundation
import UIKit


class HomeWireFrame: HomeWireFrameProtocol, BaseWireframeProtocol {
    
    static func createHomeViewModule() -> UIViewController {
        let storyBord = UIStoryboard.init(name: "Main", bundle: .main)
        let view = storyBord.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let presenter: HomePresenterProtocol = HomePresenter()
        let interactor: HomeInteractorProtocol = HomeInteractor()
        let remoteDataHandler: HomeRemoteDataHandlerProtocol = HomeRemoteDataHandler()
        let wireFrame = HomeWireFrame()
        
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
