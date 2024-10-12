//
//  ApiEndPoints.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 17/08/22.
//

import Foundation

protocol ApiEndpoint {
    var baseURL: String { get }
    var domainPath: String? { get }
    var httpMethod: HttpRequestType { get set }
    var httpBody: Data? { get set }
    var queryItems: [String: String]? { get set }
    var headers: [String: String] { get set }
}

struct HomeApiEndPoint: ApiEndpoint {
    var baseURL: String = URLConstants.domainURL
    var domainPath: String?
    var httpMethod: HttpRequestType = .GET
    var httpBody: Data? = nil
    var queryItems: [String : String]? = nil
    var headers: [String : String]
}

struct AddPostApiEndPoint: ApiEndpoint {
    var baseURL: String = URLConstants.domainURL
    var domainPath: String?
    var httpMethod: HttpRequestType = .GET
    var httpBody: Data? = nil
    var queryItems: [String : String]? = nil
    var headers: [String : String]
}

struct SearchApiEndpoint: ApiEndpoint {
    var baseURL: String = URLConstants.domainURL
    var domainPath: String?
    var httpMethod: HttpRequestType = .GET
    var httpBody: Data? = nil
    var queryItems: [String : String]? = nil
    var headers: [String : String]
}

enum HomeDomainApis {
    case homeApi
    case blogDetailApi
    case placeDetailApi
}

enum AddPostDomainApis {
    case addPostApi
}

enum SearchTabDomainApis {
    case searchApi
    case packageDetailApi
}

enum NetworkAPiEndPointBuilder {
    case home(api: HomeDomainApis, queryItems: [String: String]? = nil)
    case addPost(api: AddPostDomainApis, URLQueryItem: [String: String]? = nil)
    case search(api: SearchTabDomainApis, queryItems: [String: String]? = nil)
    
    func build() -> ApiEndpoint {
        switch self {
        case .home(let endpath, let queryItems):
            let commonHeader: [String: String] = [:]
            
            switch endpath {
            case .homeApi:
                return HomeApiEndPoint(domainPath: URLConstants.Home.base, httpMethod: .GET, queryItems: queryItems, headers: commonHeader)
            case .blogDetailApi:
                return HomeApiEndPoint(domainPath: URLConstants.Home.blogDetail, httpMethod: .GET, queryItems: queryItems, headers: commonHeader)
            case .placeDetailApi:
                return HomeApiEndPoint(domainPath: URLConstants.Home.placeDetail, queryItems: queryItems, headers: commonHeader)
            }
            
        case .addPost(let api, let queryItems):
            let commonHeader: [String: String] = [:]
            
            switch api {
            case .addPostApi:
                return AddPostApiEndPoint(domainPath: URLConstants.AddPost.base, httpMethod: .POST, queryItems: queryItems, headers: commonHeader)
            }
        
        case .search(let api, let queryItems):
            let commonHeader: [String: String] = [:]
            
            switch api {
            case .searchApi:
                return SearchApiEndpoint(headers: commonHeader)
            case .packageDetailApi:
                return SearchApiEndpoint(domainPath: URLConstants.Search.packageDetail, httpMethod: .GET, queryItems: queryItems, headers: commonHeader)
            }
        }
    }
}


