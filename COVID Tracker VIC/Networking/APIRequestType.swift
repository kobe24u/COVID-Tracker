//
//  APIRequestType.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Foundation

enum RequestType {
  case LGA
  case Postcode
}

extension RequestType {
  var apiEndpoint: String {
    switch self {
    case .LGA:
      return "https://discover.data.vic.gov.au/api/3/action/datastore_search?resource_id=bc71e010-253a-482a-bdbc-d65d1befe526"
    case .Postcode:
      return "https://discover.data.vic.gov.au/api/3/action/datastore_search?resource_id=e3c72a49-6752-4158-82e6-116bea8f55c8"
    }
  }
}
