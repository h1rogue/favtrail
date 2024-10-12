//
//  ImageNetworkManager.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 01/11/22.
//

import Foundation

struct ImageData: Codable {
    let fileName: String?
    let imageData: Data?
}

struct ImageNetworkManager {
    
    func uploadImages(imageList: [Data]) -> [(String, String)] {
        var multiformData: [(String, String)] = []
          for (index, element) in imageList.enumerated() {
  
              multiformData.append(("upload_image_\(index)", element.base64EncodedString()))
          }
        return multiformData
    }

}
