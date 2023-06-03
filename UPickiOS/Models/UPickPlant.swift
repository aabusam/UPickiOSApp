//
//  UPickPlant.swift
//  UPickiOS
//
//  Created by Abdallah Abu Samaha on 6/3/23.
//

import Foundation

struct UPickPlant: Codable{
    let id: Int
    let title: String
    let category: UPickPlantCategory
    let image_url: String
    let description: String
    let season_start: String
    let season_end: String
    let organic: Bool
    let scientific_name: String?
    let country_of_origin: String?
    let plant_farm: UPickFarm
}

struct UPickPlantCategory: Codable{
    let id: Int
    let name: String
}
