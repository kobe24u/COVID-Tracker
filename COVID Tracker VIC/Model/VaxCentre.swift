//
//  VaxCentre.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import CoreLocation
import Foundation

struct VaxCentre: Codable, Identifiable {
  let id: Int
  let suburb: String
  let addressFull: String
  let shortNameClean: String
  let opening_hours: String
  private let lat: Double
  private let lng: Double
    
  var clLocation: CLLocationCoordinate2D {
    .init(
      latitude: lat,
      longitude: lng
    )
  }
}
