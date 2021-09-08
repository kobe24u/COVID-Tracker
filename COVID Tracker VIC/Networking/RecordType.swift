//
//  APIRequestType.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 5/9/21.
//

import Foundation

let baseURLString = "https://discover.data.vic.gov.au"

enum RecordType: String, CaseIterable {
  case lga = "LGA"
  case postcode = "Postcode"
}

extension RecordType {
  var apiEndpoint: URL? {
    var servicePath = ""
    switch self {
    case .lga:
      servicePath = "/api/3/action/datastore_search?resource_id=bc71e010-253a-482a-bdbc-d65d1befe526"
    case .postcode:
      servicePath = "/api/3/action/datastore_search?resource_id=e3c72a49-6752-4158-82e6-116bea8f55c8"
    }
    return URL(string: baseURLString + servicePath)
  }
}
