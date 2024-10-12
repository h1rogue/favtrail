//
//  PackageDetailModel.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 04/01/23.
//

import Foundation

struct PackageDetailModel: Codable {
    let meta: PackageDetailMetaData
    let feed: PackageDetailFeed
    let footer: PackageDetailFooter
}

struct PackageDetailMetaData: Codable {
    let bgColor: String
}

struct PackageDetailFeed: Codable {
    let displayType: String
    let objects: [HomeGenericObjectModel]
}

struct PackageDetailFooter: Codable {
    let price: String
    let buttonTitle: String
}

struct PackageHeaderModel: ContentModelObject {
    var id: String
    var image: String?
    let headerTitle: String
    let title: String
    let subtitle: String?
    let additionalInfo: String?
}

struct SimilarTripModel: ContentModelObject {
    var id: String
    let title: String
    let subtitle: String
    let image: String?
}
