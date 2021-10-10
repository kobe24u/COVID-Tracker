//
//  TestSites.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 10/10/21.
//

import Foundation

struct TestSitesResponse: Codable {
  let sites: [Site]
}

struct Site: Codable {
  let Site_ID: String
  let Site_Name: String
  let Website: String?
  let Phone: String?
  let Service_Availability: String
  let Address: String
  let Suburb: String
  let State: String
  let Postcode: String
  let Latitude: String
  let Longitude: String
}
