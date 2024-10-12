//
//  URLConfigs.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 29/09/22.
//

import Foundation

struct URLConstants {
    static let domainURL: String = "demo7653918.mockable.io"
    
    struct Home {
        static let base: String = "/home"
        static let blogDetail: String = base.appending("/blog_detail")
        static let placeDetail: String = base.appending("/place_detail")
    }
    
    struct AddPost {
        static let base: String = "/addPost"
    }
    
    struct Search {
        static let base: String = "/search"
        static let packageDetail: String = base.appending("/package_detail")
    }
}
