//
//  APIRequestType.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Foundation

let baseURLString = "https://data.nsw.gov.au/data"

enum RecordType: String, CaseIterable {
  case lga = "LGA"
  case postcode = "Postcode"
}

extension RecordType {
  var yesterdayQueryString: String { Date.daysAgo(value: 1).toQueryString() }
  
  var apiEndpoint: URL? {
    var servicePath = ""
    switch self {
    case .lga:
      servicePath = "/api/3/action/datastore_search?resource_id=5d63b527-e2b8-4c42-ad6f-677f14433520&q=\(yesterdayQueryString)"
    case .postcode:
      servicePath = "/api/3/action/datastore_search?resource_id=e3c72a49-6752-4158-82e6-116bea8f55c8"
    }
    return URL(string: baseURLString + servicePath)
  }
}
