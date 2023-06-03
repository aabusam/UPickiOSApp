//
//  UPickListFarmsResponse.swift
//  UPickiOS
//
//  Created by Abdallah Abu Samaha on 6/3/23.
//

import Foundation

struct UPickListFarmsResponse: Codable{
    let info: UPickListResponseInfo
    let results: [UPickFarm]
}

