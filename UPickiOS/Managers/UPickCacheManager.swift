//
//  UPickCacheManager.swift
//  UPickiOS
//
//  Created by Abdallah Abu Samaha on 6/3/23.
//

import Foundation

/// Manages in mememory session API caches
final class UPickAPICacheManager {
    private var cacheDictionary: [UPickEndpoint: NSCache<NSString, NSData>] = [:]
    
    init(){
        setUpCache()
    }
    
    // MARK: - public
    
    public func cachedResponse(for endpoint:UPickEndpoint, url:URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {return nil}
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint:UPickEndpoint, url:URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {return}
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    // MARK: - private
    private func setUpCache(){
        UPickEndpoint.allCases.forEach { endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        }
    }
}
