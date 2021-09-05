//
//  Error+Converter.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Foundation

extension Error {
  func toAPIResponseError() -> APIError {
    switch self {
    case is URLError:
      return .network
    case is DecodingError:
      return .parsing
    default:
      return .unknown
    }
  }
}
