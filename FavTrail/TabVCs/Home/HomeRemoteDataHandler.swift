//
//  HomeRemoteDataHandler.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 15/08/22.
//

import Foundation

class HomeRemoteDataHandler: HomeRemoteDataHandlerProtocol {
    weak var interactor: HomeInteractorProtocol?
    var networkLayerObj = HttpNetworkLayer()
    
    func fetchHomeData() {
        //TODO: add this later
//        let apiEndPoint = NetworkAPiEndPointBuilder.home(api: .homeApi, queryItems: nil).build()
//        guard let request: URLRequest = HttpNetworkLayer.createRequest(apiEndPoint: apiEndPoint) else {
//            return //TODO: implment this later
//        }
        //TODO: remove this later
        let apiEndPoint = "http://43.207.154.89/apis/home/"
        let url = URL(string: apiEndPoint)!
        let request = URLRequest(url: url)
        
        networkLayerObj.request(request: request, responseType: HomeUserFeedModel.self) { result in
            switch result {
            case .success(let jsonResult):
                self.interactor?.fetchedDataSuccessfully(response: jsonResult)
            case .failure(let error):
                print(error.rawValue)
                //TODO: handle failure cases.
            }
        }
    }
}
