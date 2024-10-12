//
//  AddPostVM.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 09/10/22.
//

import Foundation
import UIKit

class AddPostVM {
    
    var cvImageLists: [AddPostImageModel] = [ButtonImageAddPostModel()]
    var selectedImageLimit: Int = 9 // currently only 9 images allowed to upload
    
    func getCVImageListCount() -> Int {
        return cvImageLists.count
    }
    
    func removeImage(at indexPath: IndexPath) {
        if indexPath.row < cvImageLists.count {
            cvImageLists.remove(at: indexPath.row)
        }
    }
    
    func checkCVImageSpacePresent() -> Bool {
        if cvImageLists.count > selectedImageLimit {
            return false
        }
        return true
    }
    
    private func validateString(_ string: String?) -> Bool {
        if let string = string, !string.isEmpty {
            return true
        }
        return false
    }
    
    private func validateImageList() -> Bool {
        return cvImageLists.filter({$0.type == .selectedImage}).count > 0 ? true : false
    }
    
    func checkPostForUpload(about: String?, location: String?) -> Bool {
        if validateString(about) || validateString(location) || validateImageList() {
            return true
        }
        return false
    }
    
    func uploadPost(about: String?, location: String?) {
        //TODO: UPLOAD POST
        
        let imageList: [Data] = cvImageLists.compactMap({$0 as? SelectedImagePostModel}).compactMap({$0.image?.pngData()})
        
        var multiFormData: [(String, String)] = []
        if let about = about {
            multiFormData.append(("about",about))
        }
        if let location = location {
            multiFormData.append(("location", location))
        }
        multiFormData.append(contentsOf: ImageNetworkManager().uploadImages(imageList: imageList))
        
        let apiEndPoint = NetworkAPiEndPointBuilder.addPost(api: .addPostApi).build()
        guard let request = HttpNetworkLayer.createRequest(apiEndPoint: apiEndPoint) else { return }
        HttpNetworkLayer().request(request: request, responseType: ImageData.self, multiPartFormData: multiFormData) { result in
            //TODO: add here later
            
            switch result {
            case .success(let success):
                print("success")
            case .failure(let failure):
                print("failure")
            }
        }
        
    }
}
