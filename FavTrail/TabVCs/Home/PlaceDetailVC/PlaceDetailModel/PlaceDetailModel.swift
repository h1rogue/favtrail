//
//  PlaceDetailModel.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 30/12/22.
//

import Foundation

struct PlaceDetailModel: Codable {
    let meta: PlaceDetailMetaData
    let feed: PlaceDetailFeed
}

struct PlaceDetailMetaData: Codable {
    let bgColor: String
}

struct PlaceDetailFeed: Codable {
    let displayType: String
    let objects: [HomeGenericObjectModel]
}

struct PDHeaderModel: ContentModelObject {
    var id: String
    let imgUrl: String?
    let headerTitle: String
    let title: String
    let subtitle: String?
    let rating: Double?
    let ratingText: String?
    let reviewText: String?
}

struct PDCafeModel: ContentModelObject {
    var id: String
    let title: String
    let subtitle: String
    let imgUrl: String?
}

struct PDResortStayModel: ContentModelObject {
    var id: String
    let title: String
    let subtitle: String
    let imgUrl: String?
}

struct PDNearbyPlacesModel: ContentModelObject {
    var id: String
    let title: String
    let subtitle: String
    let imgUrl: String?
}

struct PDQuestionAnswerModel: ContentModelObject {
    var id: String
    let question: String
    let answer: String?
}


