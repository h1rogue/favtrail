//
//  PlaceDetailRemoteHandler.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 25/12/22.
//

import Foundation

class PlaceDetailRemoteHandler: PlaceDetailRemoteDataHandlerProtocol {
    weak var interactor: PlaceDetailInteractorProtocol?
    var httpNetworkLayer: HttpNetworkLayer = HttpNetworkLayer()
    
    func fetchPlaceDetailData() {
        //TODO: add this later
        
//        let apiEndPoint = NetworkAPiEndPointBuilder.home(api: .placeDetailApi, queryItems: ["placde_name": "pataya"]).build() //TODO REMOVE DUMMY LATER
//        guard let request: URLRequest = HttpNetworkLayer.createRequest(apiEndPoint: apiEndPoint) else {
//            return //TODO: handle this later
//        }
        
        //TODO: remove this later
        let apiEndPoint = "http://43.207.154.89/apis/place/Bangalore,%20India/"
        let url = URL(string: apiEndPoint)!
        let request = URLRequest(url: url)
        
        httpNetworkLayer.request(request: request, responseType: PlaceDetailModel.self) { [weak self] result in
            switch result {
            case .success(let successModel):
                self?.interactor?.fetchDataSuccessfully(response: successModel)
            case .failure(let failure):
                print(failure.rawValue) //TODO: handle this later
            }
        }
    }
}
