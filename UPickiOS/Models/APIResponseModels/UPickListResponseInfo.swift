//
//  UPickListResponseInfo.swift
//  UPickiOS
//
//  Created by Abdallah Abu Samaha on 6/3/23.
//

import Foundation

struct UPickListResponseInfo: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results_per_page: Int
}
