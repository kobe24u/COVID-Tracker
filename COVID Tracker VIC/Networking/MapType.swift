//
//  MapType.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import Foundation

enum MapType: String, CaseIterable {
  case testSites = "Testing sites"
  case vaxCentres = "Vax centres"
}

extension MapType {
  var apiEndpoint: URL? {
    switch self {
    case .testSites:
       return URL(string: "https://pausedatahealth01.blob.core.windows.net/testsitemaster/testingsitedata/TestSitesData.json")
    case .vaxCentres:
      return URL(string: "https://api.npoint.io/61ec92feef255bce0448")
    }
  }
}

