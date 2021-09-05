//
//  APIService.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Combine
import Foundation

struct APIService {
  func fetchRecords<T: Codable>(of type: RequestType) -> AnyPublisher<[T], APIError> {
    guard let url = URL(string: type.apiEndpoint) else { return Empty().eraseToAnyPublisher() }
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: [T].self, decoder: JSONDecoder())
        .mapError{ error in
          error.toAPIResponseError()
        }
       .eraseToAnyPublisher()
  }
}
