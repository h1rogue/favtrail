//
//  AddPostImageModel.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 10/10/22.
//

import Foundation
import UIKit

enum AddPostImageModelType {
    case imageButton, selectedImage
}

protocol AddPostImageModel {
    var type: AddPostImageModelType { get }
    var image: UIImage? { get }
}

struct ButtonImageAddPostModel: AddPostImageModel {
    var type: AddPostImageModelType = .imageButton
    var image: UIImage? = nil
    var isDisabled: Bool = false
}

struct SelectedImagePostModel: AddPostImageModel {
    var type: AddPostImageModelType = .selectedImage
    var image: UIImage?
}

