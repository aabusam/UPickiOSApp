//
//  UPickFarm.swift
//  UPickiOS
//
//  Created by Abdallah Abu Samaha on 6/3/23.
//

import Foundation

struct UPickFarm: Codable{
    let id: Int
    let image_url: String?
    let title: String
    let working_hours: [UPickWorkingHour]
    let description: String?
    let address: UPickAddress
    let entrance_fee: Double?
    let phone: String?
    let email: String?
    let website: String?
    let farm_plants: [UPickPlant]
}

struct UPickWorkingHour: Codable{
    let day: String
    let opening_time: String
    let closing_time: String
    let is_open: Bool?
}

struct UPickAddress: Codable{
    let street: String
    let city: String
    let state: String?
    let country: String
    let zip_code: String?
    let geo_location: UPickGeoLocation
}

struct UPickGeoLocation: Codable{
    let lat: Double
    let long: Double
}
