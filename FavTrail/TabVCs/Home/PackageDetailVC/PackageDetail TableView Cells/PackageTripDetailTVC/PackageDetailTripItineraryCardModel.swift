//
//  PackageDetailTripItineraryCard.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 08/01/23.
//

import Foundation

struct TripItineraryCardModel: ContentModelObject {
    var id: String
    let title: String
    let type: TripItineraryType
    var data: TripItineraryDataModel?
    
    enum CodingKeys: CodingKey {
        case id, title, type, data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.type = try container.decode(TripItineraryType.self, forKey: .type)
        
        switch type {
        case .cab:
            self.data = try container.decode(CabItineraryDataModel.self, forKey: .data)
        case .flight:
            self.data = try container.decode(FlightItineraryDataModel.self, forKey: .data)
        case .hotel:
            self.data = try container.decode(HotelDetailDataModel.self, forKey: .data)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(type, forKey: .type)
    }
}

protocol TripItineraryDataModel: Codable {
    
    var dateTime: String { get set }
    var isViewExpanded: Bool {get set}
}

class CabItineraryDataModel: TripItineraryDataModel {
    
    var title: String?
    var dateTime: String
    var subtitle: String
    let pickupLocation: String
    let dropLocation: String
    let avgDropTime: String?
    let vehicleTypeText: String
    let vehicleType: String?
    let vehicleIcon: String?
    //Additon Info
    var isViewExpanded: Bool = false
    
    enum CodingKeys: CodingKey {
        case title, dateTime, subtitle, pickupLocation, dropLocation, avgDropTime, vehicleTypeText, vehicleType, vehicleIcon
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.dateTime = try container.decode(String.self, forKey: .dateTime)
        self.subtitle = try container.decode(String.self, forKey: .subtitle)
        self.pickupLocation = try container.decode(String.self, forKey: .pickupLocation)
        self.dropLocation = try container.decode(String.self, forKey: .dropLocation)
        self.avgDropTime = try container.decodeIfPresent(String.self, forKey: .avgDropTime)
        self.vehicleTypeText = try container.decode(String.self, forKey: .vehicleTypeText)
        self.vehicleType = try container.decodeIfPresent(String.self, forKey: .vehicleType)
        self.vehicleIcon = try container.decodeIfPresent(String.self, forKey: .vehicleIcon)
        self.isViewExpanded = false
    }
}

class FlightItineraryDataModel: TripItineraryDataModel {
    var title: String?
    var dateTime: String
    let departureLocation: String
    let departureTime: String?
    let arrivalLocation: String
    let arrivalTime: String?
    let flightIcon: String?
    let flightName: String?
    let flightNumber: String?
    //Additon Info
    var isViewExpanded: Bool = false
    
    enum CodingKeys: CodingKey {
        case title, dateTime, departureLocation, departureTime, arrivalLocation, arrivalTime, flightIcon, flightName, flightNumber
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.dateTime = try container.decode(String.self, forKey: .dateTime)
        self.departureLocation = try container.decode(String.self, forKey: .departureLocation)
        self.departureTime = try container.decodeIfPresent(String.self, forKey: .departureTime)
        self.arrivalLocation = try container.decode(String.self, forKey: .arrivalLocation)
        self.arrivalTime = try container.decodeIfPresent(String.self, forKey: .arrivalTime)
        self.flightIcon = try container.decodeIfPresent(String.self, forKey: .flightIcon)
        self.flightName = try container.decodeIfPresent(String.self, forKey: .flightName)
        self.flightNumber = try container.decodeIfPresent(String.self, forKey: .flightNumber)
        self.isViewExpanded = false
    }
}

class HotelDetailDataModel: TripItineraryDataModel {

    var title: String?
    var dateTime: String
    let rating: String
    let numberOfDays: String
    //Additon Info
    var isViewExpanded: Bool = false
    
    enum CodingKeys: CodingKey {
        case title, dateTime, rating, numberOfDays
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.dateTime = try container.decode(String.self, forKey: .dateTime)
        self.rating = try container.decode(String.self, forKey: .rating)
        self.numberOfDays = try container.decode(String.self, forKey: .numberOfDays)
        self.isViewExpanded = false
    }
}

enum TripItineraryType: String, Codable {
    case cab, flight, hotel
}
