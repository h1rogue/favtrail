//
//  PlaceDetailInteractor.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 25/12/22.
//

import Foundation

class PlaceDetailInteractor: PlaceDetailInteractorProtocol {
    
    var remoteDataHandler: PlaceDetailRemoteDataHandlerProtocol?
    weak var presenter: PlaceDetailPresenterProtocol?
    
    var placeDetailResponse: PlaceDetailModel?

    func viewDidLoad() {
        remoteDataHandler?.fetchPlaceDetailData()
    }
    
    func fetchDataSuccessfully(response: PlaceDetailModel) {
        self.placeDetailResponse = response
        presenter?.fetchedPDSuccessfully(response: response)
    }
}
