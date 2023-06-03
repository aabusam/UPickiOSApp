//
//  UPickEndPoint.swift
//  UPickiOS
//
//  Created by Abdallah Abu Samaha on 6/3/23.
//

import Foundation

/// Object that represent unique API endpoint
@frozen enum UPickEndpoint: String, CaseIterable, Hashable{
    case farms
    case plants
}
