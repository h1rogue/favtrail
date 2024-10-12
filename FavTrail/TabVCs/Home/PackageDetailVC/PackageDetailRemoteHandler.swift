//
//  PackageDetailRemoteHandler.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 04/01/23.
//

import Foundation

class PackageDetailRemoteHandler: PackageDetailRemoteDataHandlerProtocol {
    weak var interactor: PackageDetailInteractorProtocol?
    var httpNetworkLayer: HttpNetworkLayer?
    
    func fetchPlaceDetailData() {
        let apiEndPoint = NetworkAPiEndPointBuilder.search(api: .packageDetailApi, queryItems: ["place_name": "hash"]).build()
        
        guard let request: URLRequest = HttpNetworkLayer.createRequest(apiEndPoint: apiEndPoint) else {
            return
        }
        httpNetworkLayer = HttpNetworkLayer()
        httpNetworkLayer?.request(request: request, responseType: PackageDetailModel.self, completion: { [weak self] result in
            switch result {
            case .success(let successModel):
                self?.interactor?.fetchDataSuccessfully(response: successModel)
            case .failure(let failure):
                print(failure.rawValue)
            }
            self?.httpNetworkLayer = nil
        })
    }
}
