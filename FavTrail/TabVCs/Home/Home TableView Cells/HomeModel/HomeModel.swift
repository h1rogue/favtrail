//
//  HomeModel.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 27/08/22.
//

import Foundation

enum ParseError: Error {
    case notRecognizedType(Any)
}

struct HomeUserFeedModel: Codable {
    let meta: HomeMetaData
    let feed: HomeUserFeed
}

struct HomeMetaData: Codable {
    let bgColor: String
}

struct HomeUserFeed: Codable {
    let displayType: String
    let objects: [HomeGenericObjectModel]
}

struct HomeGenericObjectModel: Codable {
    let title: String
    let type: HomeCardTypes
    let objects: [ContentModelObject]
    
    enum CodingKeys: String, CodingKey {
        case title, type, objects
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typeString = try container.decode(String.self, forKey: .type)
        self.title = try container.decode(String.self, forKey: .title)
        if let type = HomeCardTypes.init(rawValue: typeString) {
            self.type = type
        } else {
            throw ParseError.notRecognizedType(typeString)
        }
    
        switch type {
        case .blog:
            self.objects = try container.decode([BlogContentModel].self, forKey: .objects)
        case .recentUpdates:
            self.objects = try container.decode([RecentUpdateContentModel].self, forKey: .objects)
        case .trending:
            self.objects = try container.decode([TrendingContentModel].self, forKey: .objects)
        case .curatedVideo:
            self.objects = try container.decode([CuratedVideoContentModel].self, forKey: .objects)
        case .nearbyTravel:
            self.objects = try container.decode([NearbyTravelContentModel].self, forKey: .objects)
        case .headerPDCard:
            self.objects = try container.decode([PDHeaderModel].self, forKey: .objects)
        case .cafePDCard:
            self.objects = try container.decode([PDCafeModel].self, forKey: .objects)
        case .resortStay:
            self.objects = try container.decode([PDResortStayModel].self, forKey: .objects)
        case .qnaCard:
            self.objects = try container.decode([PDQuestionAnswerModel].self, forKey: .objects)
        case .packageHeaderCard:
            self.objects = try container.decode([PackageHeaderModel].self, forKey: .objects)
        case .similarTripModel:
            self.objects = try container.decode([SimilarTripModel].self, forKey: .objects)
        case .tripItineraryCard:
            self.objects = try container.decode([TripItineraryCardModel].self, forKey: .objects)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(type, forKey: .type)
    }
}

protocol ContentModelObject: Codable {
    var id: String { get set }
}

struct RecentUpdateContentModel: ContentModelObject {
    var id: String
    var postTime: String
    let title: String
    let imgUrl: String
}

struct NearbyTravelContentModel: ContentModelObject {
    var id: String
    var postTime: String
    let title: String
    let subTitle: String?
    let imgUrl: String
}

struct TrendingContentModel: ContentModelObject {
    var id: String
    var postTime: String
    let title: String
    let imgUrl: String
}

struct BlogContentModel: ContentModelObject {
    var id: String
    var postTime: String
    let userInfo: UserInfoModel
    var statsInfo: StatsModel
    let blogData: UserFeedDataModel
}

struct CuratedVideoContentModel: ContentModelObject {
    var id: String
    var postTime: String
    let title: String
    let subTitle: String
    let videoUrl: String
}

enum HomeCardTypes: String, Codable {
    case blog, recentUpdates, trending, curatedVideo, nearbyTravel, headerPDCard, cafePDCard, resortStay, qnaCard, packageHeaderCard, tripItineraryCard, similarTripModel
}


struct UserInfoModel: Codable {
    let userImage: String
    let userName: String
    let userLocation: String
    
    init(userImage: String, userName: String, userLocation: String) {
        self.userImage = userImage
        self.userName = userName
        self.userLocation = userLocation
    }
}

struct StatsModel: Codable {
    var numberOfLikes: String
    var numberOfComments: String
    var isLiked: Bool = false
    
    init(numberOfLikes: String, numberOfComments: String, isLiked: Bool = false) {
        self.numberOfLikes = numberOfLikes
        self.numberOfComments = numberOfComments
        self.isLiked = isLiked
    }
}

struct UserFeedDataModel: Codable {
    var title: String
    var subTitle: String?
    var body: String?
    var images: [String]?
}

