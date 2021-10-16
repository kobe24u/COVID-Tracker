//
//  Place.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 16/10/21.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
  var id = UUID().uuidString
  var place: CLPlacemark
}
