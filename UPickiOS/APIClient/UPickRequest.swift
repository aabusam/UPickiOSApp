//
//  UPickRequest.swift
//  UPickiOS
//
//  Created by Abdallah Abu Samaha on 6/3/23.
//

import Foundation

final class UPickRequest {
    //API Constants
    private struct Constants{
        static let baseUrl = "http://127.0.0.1:8000/UPick"
    }
    
    // Desired Endpoint
    public let endpoint: UPickEndpoint
    
    // Path componets for API, if any
    private let pathComponents: [String]
    
    // Path query parameters, API if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed URL for the API resquest in a string format
    private var urlString:String{
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({ string += "/\($0)"
            })
        }
        if !queryParameters.isEmpty {
            string += "?"
            //name=value&name=value
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        return string
    }
    
    // expose the url
    public var url: URL?{
        return URL(string: urlString)
    }
    
    // TODO: - create an object for httpMethods when back end is ready
    public let httpMethod = "GET"
    
    // MARK: - Init
    
    /// Construct Request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of path components
    ///   - queryParameters: Collection of query parameters
    public init(endpoint: UPickEndpoint,
                pathComponents: [String] = [],
                queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    // Atempt to create URL request to parse
    convenience init?(url: URL){
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl){
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/"){
            var components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                if components.count > 1 {
                    components.remove(at: 0)
                }
                if let rmEndpoint = UPickEndpoint(rawValue: endpointString){
                    self.init(endpoint: rmEndpoint,
                              pathComponents: components)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty {
                if !components.isEmpty, components.count >= 2{
                    let endpointString = components[0]
                    let queryItemsString = components[1]
                    
                    let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                        guard $0.contains("=") else {
                            return nil
                        }
                        let parts = $0.components(separatedBy:"=")
                        return URLQueryItem(name: parts[0],value:parts[1])})
                    
                    if let rmEndpoint = UPickEndpoint(rawValue: endpointString){
                        self.init(endpoint: rmEndpoint, queryParameters: queryItems)
                        return
                    }
                }
            }
        }
        return nil
    }
}


extension UPickRequest {
    static let listFarmsRequests = UPickRequest(endpoint: .farms)
    static let listPlantsRequests = UPickRequest(endpoint: .plants)
}
