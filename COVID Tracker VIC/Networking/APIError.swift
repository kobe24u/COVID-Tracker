//
//  APIError.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Foundation

enum APIError: Error {
  case network
  case parsing
  case unknown
}

extension APIError: CustomStringConvertible {
  var description: String {
    switch self {
    case .network:
      return "Request to API Server failed"
    case .parsing:
      return "Failed parsing response from server"
    case .unknown:
      return "An unknown error occurred"
    }
  }
}
