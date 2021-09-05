//
//  APIService.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Combine
import Foundation

struct APIService {
  func fetchLGARecords() -> AnyPublisher<[LGARecord], APIError> {
    guard let url = URL(string: RequestType.LGA.apiEndpoint) else { return Empty().eraseToAnyPublisher() }
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: LGAResponse.self, decoder: JSONDecoder())
        .map{ $0.result.records }
        .mapError{ $0.toAPIResponseError() }
       .eraseToAnyPublisher()
  }
}
