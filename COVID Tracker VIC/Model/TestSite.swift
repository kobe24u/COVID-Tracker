//
//  TestSites.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import Foundation
import CoreLocation

struct TestSitesResponse: Codable {
  let sites: [Site]
}

struct Site: Codable, Identifiable {
  let Site_ID: String
  let Site_Name: String
  let Website: String?
  let Phone: String?
  let Service_Availability: String
  let Address: String
  let Suburb: String
  private let Latitude: String
  private let Longitude: String
    
  var id: String { Site_ID }
  var clLocation: CLLocationCoordinate2D {
    CLLocationCoordinate2D(
      latitude: Double(Latitude) ?? Double(0),
      longitude: Double(Longitude) ?? Double(0)
    )
  }
}
