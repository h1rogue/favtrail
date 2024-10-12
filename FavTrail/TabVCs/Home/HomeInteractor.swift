//
//  HomeInteractor.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 31/07/22.
//

import Foundation

class HomeInteractor: HomeInteractorProtocol {

    var remoteDataHandler: HomeRemoteDataHandlerProtocol?
    weak var presenter: HomePresenterProtocol?
    
    var homeDataResponse: HomeUserFeedModel?
    
    func fetchHomeData() {
        remoteDataHandler?.fetchHomeData()
    }
    
    func fetchedDataSuccessfully(response: HomeUserFeedModel) {
        self.homeDataResponse = response
        presenter?.fetchedHomeDataSuccessfully(response: response)
    }
}
