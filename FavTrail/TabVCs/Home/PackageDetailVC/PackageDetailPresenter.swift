//
//  PackageDetailPresenter.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 04/01/23.
//

import Foundation

class PackageDetailPresenter: PackageDetailPresenterProtocol {
  
    weak var view: PackageDetailViewProtocol?
    var interactor: PackageDetailInteractorProtocol?
    var wireFrame: PackageDetailWireFrameProtocol?
    
    var responseModel: PackageDetailModel?
    
    func viewDidLoad() {
        interactor?.viewDidLoad()
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return responseModel?.feed.objects.count ?? 0
    }
    
    func cellModelForRowAtIndex(indexPath: IndexPath) -> HomeGenericObjectModel? {
        return responseModel?.feed.objects[indexPath.row]
    }
    
    func getFooterModel() -> PackageDetailFooter? {
        return responseModel?.footer
    }
    
    func fetchedPDSuccessfully(response: PackageDetailModel) {
        responseModel = response
        view?.fetchPDSuccessfully()
    }
    
}
