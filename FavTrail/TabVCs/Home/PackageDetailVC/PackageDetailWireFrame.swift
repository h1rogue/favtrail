//
//  PackageDetailWireFrame.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 04/01/23.
//

import Foundation
import UIKit

class PackageDetailWireFrame: PackageDetailWireFrameProtocol {
    
    static func createPackageDetailModule() -> UIViewController {
        let storyBard = UIStoryboard.init(name: "Main", bundle: .main)
        let view = storyBard.instantiateViewController(withIdentifier: "PackageDetailViewController") as! PackageDetailViewController
        
        let presenter: PackageDetailPresenterProtocol = PackageDetailPresenter()
        let interactor: PackageDetailInteractorProtocol = PackageDetailInteractor()
        let remoteHandler: PackageDetailRemoteDataHandlerProtocol = PackageDetailRemoteHandler()
        let wireFrame = PackageDetailWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDataHandler = remoteHandler
        remoteHandler.interactor = interactor
        
        return view
    }
}
