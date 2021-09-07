//
//  APIService.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Combine
import Foundation

class APIService {
  private var cancellables: Set<AnyCancellable> = []
  
  func fetch<T: Decodable>(_ url: URL?) -> AnyPublisher<T, APIError> {
    guard let url = url else { return Empty().eraseToAnyPublisher() }
    return URLSession.shared.dataTaskPublisher(for: url)
        .receive(on: DispatchQueue.main)
        .map(\.data)
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError{ $0.toAPIResponseError() }
        .eraseToAnyPublisher()
  }
}
