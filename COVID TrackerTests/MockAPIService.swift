//
//  MockAPIService.swift
//  COVID TrackerTests
//
//  Created by Vinnie Liu on 3/2/2022.
//

import Combine
import Foundation
@testable import COVID_Tracker_VIC

class MockAPIService: APIServiceType {
    private let mockAPIUrl: URL?
    
    init(mockAPIUrl: URL?) {
        self.mockAPIUrl = mockAPIUrl
    }
    
    func fetch<T: Decodable>(_ url: URL?) -> AnyPublisher<T, APIError> {
      guard let url = mockAPIUrl else { return Empty().eraseToAnyPublisher() }
      return URLSession.shared.dataTaskPublisher(for: url)
          .receive(on: DispatchQueue.main)
          .map(\.data)
          .decode(type: T.self, decoder: JSONDecoder())
          .mapError{ $0.toAPIResponseError() }
          .eraseToAnyPublisher()
    }
    
    func asyncFetch<T: Decodable>(_ url: URL?) async throws -> T {
      guard let url = mockAPIUrl else { throw APIError.invalidURL }
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
