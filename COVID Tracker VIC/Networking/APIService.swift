//
//  APIService.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Combine
import Foundation

class APIService {
  
  func fetch<T: Decodable>(_ url: URL?) -> AnyPublisher<T, APIError> {
    guard let url = url else { return Empty().eraseToAnyPublisher() }
    return URLSession.shared.dataTaskPublisher(for: url)
        .receive(on: DispatchQueue.main)
        .map(\.data)
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError{ $0.toAPIResponseError() }
        .eraseToAnyPublisher()
  }
  
  func asyncFetch<T: Decodable>(_ url: URL?) async throws -> T {
    guard let url = url else { throw APIError.invalidURL }
    let (data, response) = try await URLSession.shared.data(from: url)

    guard let response = response as? HTTPURLResponse
    else { throw APIError.noResponse }
    
    guard response.statusCode == 200
    else { throw APIError.network }
    
    guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
    else { throw APIError.parsing }
    
    return decodedData
  }
}
