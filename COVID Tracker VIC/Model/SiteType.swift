//
//  SiteType.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 16/10/21.
//

import Foundation
import CoreLocation

struct SiteType: Identifiable {
  let id: String
  let clLocation: CLLocationCoordinate2D
  let name: String
  let address: String
  let suburb: String
  let availability: String
  let website: String?
  let phone: String?
  var fullAddress: String {
    if address.contains(suburb) {
      return address
    } else {
      return address + ", " + suburb
    }
  }
  
  init(from testSite: Site) {
    self.id = testSite.id
    self.name = testSite.Site_Name
    self.website = testSite.Website
    self.phone = testSite.Phone
    self.availability = testSite.Service_Availability
    self.address = testSite.Address
    self.suburb = testSite.Suburb
    self.clLocation = testSite.clLocation
  }
  
  init(from vaxCentre: VaxCentre) {
    self.id = "\(vaxCentre.id)"
    self.name = vaxCentre.shortNameClean
    self.availability = vaxCentre.opening_hours
    self.address = vaxCentre.addressFull
    self.suburb = vaxCentre.suburb
    self.clLocation = vaxCentre.clLocation
    self.website = nil
    self.phone = nil
  }
}
