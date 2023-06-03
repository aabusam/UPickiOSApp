//
//  UPickService.swift
//  UPickiOS
//
//  Created by Abdallah Abu Samaha on 6/3/23.
//

import Foundation

/// Primary API service ob ject to get Rick and Morty data
final class UPickService {
    /// Shared singleton instance
    static let shared = UPickService()
    
    private let cacheManager = UPickAPICacheManager()
    
    /// Privatized constructor forces everyone to use the singleton
    private init() {}
    
    /// API error object
    enum UPickServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    // MARK: - Excutes a request
    
    /// Send Rick and Mort API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: Type of object we expect to get back
    ///   - completion: Callback with data or error
    ///
    public func excute<T:Codable>(
        _ request: UPickRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        if let cachedData = cacheManager.cachedResponse(for: request.endpoint,
                                                        url: request.url) {
            
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(UPickServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? UPickServiceError.failedToGetData))
                return
            }
            
            //Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(for: request.endpoint, url: request.url, data: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - Private
    
    private func request(from upickRequest: UPickRequest) -> URLRequest? {
        guard let url = upickRequest.url else {
            return nil
        }
        var request = URLRequest(url:url)
        request.httpMethod = upickRequest.httpMethod
        return request
    }
}
