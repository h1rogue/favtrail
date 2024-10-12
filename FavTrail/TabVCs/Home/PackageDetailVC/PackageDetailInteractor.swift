//
//  PackageDetailInteracotr.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 04/01/23.
//

import Foundation

class PackageDetailInteractor: PackageDetailInteractorProtocol {
    
    weak var presenter: PackageDetailPresenterProtocol?
    var remoteDataHandler: PackageDetailRemoteDataHandlerProtocol?
    
    func viewDidLoad() {
        remoteDataHandler?.fetchPlaceDetailData()
    }
    
    func fetchDataSuccessfully(response: PackageDetailModel) {
        presenter?.fetchedPDSuccessfully(response: response)
    }
    
    
}
